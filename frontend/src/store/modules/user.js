import { login, logout, getInfo, getUserList } from '@/api/user'
import { getToken, setToken, removeToken } from '@/utils/auth'
import { resetRouter } from '@/router'

const getDefaultState = () => {
  return {
    token: getToken(),
    id: '',
    name: '',
    avatar: '',
    permissions: [],
    menus: [] // 用于存储用户的菜单权限
  }
}

const state = getDefaultState()

const mutations = {
  RESET_STATE: (state) => {
    Object.assign(state, getDefaultState())
  },
  SET_TOKEN: (state, token) => {
    state.token = token
  },
  SET_ID: (state, id) => {
    state.id = id
  },
  SET_NAME: (state, name) => {
    state.name = name
  },
  SET_AVATAR: (state, avatar) => {
    state.avatar = avatar
  },
  SET_PERMISSIONS: (state, permissions) => {
    state.permissions = permissions
  },
  SET_MENUS: (state, menus) => {
    //此处可以将menus存储到vuex中，方便后续使用
    state.menus = menus
  }
}

const actions = {
  // user login
  login({ commit }, userInfo) {
    const { username, password } = userInfo
    return new Promise((resolve, reject) => {
      login({ username: username.trim(), password: password }).then(response => {
        //此处修改为自己的登录逻辑
        console.log('Login success, token:', response.token)
        commit('SET_TOKEN', response.token)
        setToken(response.token)
        resolve()
      }).catch(error => {
        reject(error)
      })
    })
  },

  // get user info
  async getInfo({ commit, state, dispatch }) {
    try {
      const response = await getInfo(state.token)
      const raw = response
      const data = response && response.data ? response.data : response
      console.log('[user/getInfo] raw response:', raw)
      console.log('[user/getInfo] parsed data:', data)
      if (!data) throw new Error('Verification failed, please Login again.')
      let { id, username, avatar } = data
      
      // 尝试从其他常见字段获取ID
      if (!id) {
        id = data.pk || data.uid || data.userId || data.user_id
      }

      // 如果还是没有ID，尝试通过用户名查询用户列表来获取ID
      if (!id && username) {
        try {
          console.log('[user/getInfo] ID missing, trying to fetch via getUserList for username:', username)
          const listRes = await getUserList({ username })
          const users = listRes.results || listRes.data || listRes
          if (Array.isArray(users)) {
            const found = users.find(u => u.username === username)
            if (found) {
              id = found.id || found.pk
              console.log('[user/getInfo] Found ID via list:', id)
            }
          }
        } catch (e) {
          console.error('[user/getInfo] Failed to fetch ID via list:', e)
        }
      }

      commit('SET_ID', id)
      commit('SET_NAME', username)
      commit('SET_AVATAR', avatar)
      
      // 1. 获取菜单数据
      const menus = data.menus || data.menu || data.permissions || []
      commit('SET_MENUS', menus)
      
      // 2. 处理权限数据
      let permissions = []
      // 如果后端直接返回了权限字符串数组，则直接使用
      if (data.permissions && data.permissions.length > 0 && typeof data.permissions[0] === 'string') {
        permissions = data.permissions
      } else {
        // 否则从菜单树中递归提取 perms 字段
        const extractPermissions = (list) => {
          let perms = []
          list.forEach(item => {
            if (item.perms) {
              perms.push(item.perms)
            }
            if (item.children && item.children.length) {
              perms = perms.concat(extractPermissions(item.children))
            }
          })
          return perms
        }
        permissions = extractPermissions(menus)
      }
      
      commit('SET_PERMISSIONS', permissions)
      // 触发基于菜单的动态路由生成
      await dispatch('permission/generateRoutes', menus, { root: true })
      return data
    } catch (error) {
      console.log(error)
      throw error
    }
  },

  // user logout
  logout({ commit, state }) {
    return new Promise((resolve, reject) => {
      logout(state.token).then(() => {
        removeToken() // must remove  token  first
        resetRouter()
        commit('RESET_STATE')
        commit('permission/RESET_ROUTES', null, { root: true })
        resolve()
      }).catch(error => {
        reject(error)
      })
    })
  },

  // remove token
  resetToken({ commit }) {
    return new Promise(resolve => {
      removeToken() // must remove  token  first
      commit('RESET_STATE')
      commit('permission/RESET_ROUTES', null, { root: true })
      resolve()
    })
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}

