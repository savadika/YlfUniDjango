import { constantRoutes } from '@/router'
import Layout from '@/layout'
import EmptyLayout from '@/layout/components/EmptyLayout'

const state = {
  routes: [], // constant + dynamic
  addRoutes: [],
  generated: false
}

const mutations = {
  SET_ROUTES(state, routes) {
    state.addRoutes = routes
    state.routes = constantRoutes.concat(routes)
  },
  SET_GENERATED(state, val) {
    state.generated = !!val
  },
  RESET_ROUTES(state) {
    state.generated = false
    state.addRoutes = []
    state.routes = []
  }
}

// 将后端返回的菜单转换为前端可用的路由配置
function normalizeComponentPath(viewPath = '') {
  // 去掉开头的'/'、'views/'前缀和'.vue'后缀
  let p = (viewPath || '')
    .replace(/^\/+/, '')
    .replace(/^views\//, '')
    .replace(/\.vue$/, '')

  // 针对目录迁移做兼容映射（保守：只映射已知页面）
  const rewriteMap = {
    'system/index': '__LAYOUT__',
    'system/menu/index': 'menu/index',
    'system/role/index': 'role/index',
    'system/user/index': 'user/index',
    'system/dept/index': 'department/index',
    'system/department/index': 'department/index'
  }
  return rewriteMap[p] || p
}

function loadView(viewPath) {
  const normalized = normalizeComponentPath(viewPath)
  // 采用 Webpack require 方式，兼容 vue-router@3 & vue-cli 4
  return (resolve) => {
    require([`@/views/${normalized}.vue`], resolve)
  }
}

function transformMenusToRoutes(menus = [], parentPath = '') {
  const res = []
  menus.forEach(menu => {
    // 过滤掉按钮类型的菜单(F)，不生成路由
    if (menu.menu_type === 'F') {
      return
    }

    // 统一构造 meta，确保 title 一定有值
    const metaFromMenu = menu.meta || {}
    const meta = {
      ...metaFromMenu,
      title: (metaFromMenu.title || menu.title || menu.name || ''),
      icon: (metaFromMenu.icon || menu.icon),
      roles: (metaFromMenu.roles || menu.roles)
    }

    const rawPath = menu.path || ''
    let path = rawPath
    if (parentPath) {
      // 子路由：使用相对路径，避免以'/'开头导致脱离父级
      if (rawPath.indexOf(parentPath + '/') === 0) {
        path = rawPath.slice(parentPath.length + 1)
      } else {
        path = rawPath.replace(/^\/+/, '')
      }
    }

    const route = {
      path: parentPath ? path : rawPath, // 根路由保留原始路径，子路由使用相对路径
      name: menu.name || (parentPath ? path : rawPath),
      hidden: menu.hidden === true,
      redirect: menu.redirect,
      meta,
      // 透传后端提供的 alwaysShow（优先级最高）
      alwaysShow: (metaFromMenu.alwaysShow === true) || (menu.alwaysShow === true)
    }

    // 是否目录（使用 Layout 作为容器）
    const isDir = menu.menu_type === 'M'

    if (isDir) {
      // 根目录使用Layout，子目录使用EmptyLayout，防止Layout嵌套导致UI错乱
      route.component = parentPath ? EmptyLayout : Layout
    } else if (menu.component) {
      const compPath = normalizeComponentPath(menu.component)
      if (compPath === '__LAYOUT__' || menu.component === 'Layout') {
        route.component = Layout
      } else {
        route.component = loadView(compPath)
      }
    } else if (menu.children && menu.children.length) {
      // 如果没有显式component且有children，默认使用Layout作为容器（如果是根节点），否则EmptyLayout
      route.component = parentPath ? EmptyLayout : Layout
    }

    if (menu.children && Array.isArray(menu.children) && menu.children.length) {
      route.children = transformMenusToRoutes(menu.children, rawPath)

      // 如果存在默认子路由（path为''），则移除父路由的name属性，避免vue-router警告
      // Warning: Named Route 'xxx' has a default child route...
      const hasDefaultChild = route.children.some(child => child.path === '')
      if (hasDefaultChild) {
        delete route.name
      }
      // 若为目录，且仅有一个可见子项，按 element-admin 规则会折叠父级，这里强制展示父级
      if (isDir && route.alwaysShow !== true) {
        const visibleChildren = route.children.filter(c => !c.hidden)
        if (visibleChildren.length === 1) {
          route.alwaysShow = true
        }
      }
    }

    res.push(route)
  })
  return res
}

const actions = {
  generateRoutes({ commit }, menus) {
    return new Promise(resolve => {
      const accessedRoutes = transformMenusToRoutes(menus)
      commit('SET_ROUTES', accessedRoutes)
      // 注意：不要在这里设置 SET_GENERATED，由路由守卫在真正 addRoute 之后设置
      resolve(accessedRoutes)
    })
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}