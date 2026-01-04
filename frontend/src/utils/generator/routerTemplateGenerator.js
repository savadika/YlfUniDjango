/**
 * 路由配置模板生成器
 * 基于字段配置生成标准的路由配置
 */

/**
 * 路由模板生成器类
 */
class RouterTemplateGenerator {
  constructor(moduleConfig) {
    this.config = moduleConfig
    this.fields = moduleConfig.fields
    this.moduleName = moduleConfig.moduleName
    this.moduleKey = moduleConfig.moduleKey
    this.options = moduleConfig.options || {}
  }

  /**
   * 生成路由配置
   */
  generate() {
    const routeConfig = this.generateRouteConfig()
    return routeConfig
  }

  /**
   * 生成路由配置对象
   */
  generateRouteConfig() {
    const routePath = `/${this.moduleKey}`
    const componentPath = `@/views/${this.moduleKey}/index`
    
    return {
      path: routePath,
      component: 'Layout',
      redirect: `${routePath}/index`,
      name: this.toPascalCase(this.moduleKey),
      meta: {
        title: `${this.moduleName}管理`,
        icon: this.getDefaultIcon(),
        roles: ['admin'] // 可根据需要调整权限
      },
      children: [
        {
          path: 'index',
          name: `${this.toPascalCase(this.moduleKey)}Index`,
          component: `() => import('${componentPath}')`,
          meta: {
            title: `${this.moduleName}管理`,
            noCache: false,
            affix: false
          }
        }
      ]
    }
  }

  /**
   * 生成路由配置字符串
   */
  generateRouteString() {
    const config = this.generateRouteConfig()
    return this.formatRouteConfig(config)
  }

  /**
   * 格式化路由配置为字符串
   */
  formatRouteConfig(config, indent = 0) {
    const spaces = '  '.repeat(indent)
    let result = ''
    
    if (typeof config === 'object' && config !== null) {
      if (Array.isArray(config)) {
        result += '[\n'
        config.forEach((item, index) => {
          result += `${spaces}  ${this.formatRouteConfig(item, indent + 1)}`
          if (index < config.length - 1) result += ','
          result += '\n'
        })
        result += `${spaces}]`
      } else {
        result += '{\n'
        const keys = Object.keys(config)
        keys.forEach((key, index) => {
          const value = config[key]
          result += `${spaces}  ${key}: `
          
          if (typeof value === 'string' && value.startsWith('() => import(')) {
            // 动态导入不需要引号
            result += value
          } else {
            result += this.formatRouteConfig(value, indent + 1)
          }
          
          if (index < keys.length - 1) result += ','
          result += '\n'
        })
        result += `${spaces}}`
      }
    } else if (typeof config === 'string') {
      result += `'${config}'`
    } else if (Array.isArray(config)) {
      result += `[${config.map(item => `'${item}'`).join(', ')}]`
    } else {
      result += JSON.stringify(config)
    }
    
    return result
  }

  /**
   * 生成完整的路由文件
   */
  generateRouteFile() {
    const imports = this.generateImports()
    const routeConfig = this.generateRouteString()
    const exports = this.generateExports()
    
    return `${imports}

/**
 * ${this.moduleName}管理路由配置
 * 自动生成于 ${new Date().toLocaleString()}
 */
const ${this.moduleKey}Router = ${routeConfig}

${exports}`
  }

  /**
   * 生成导入语句
   */
  generateImports() {
    return `import Layout from '@/layout'`
  }

  /**
   * 生成导出语句
   */
  generateExports() {
    return `export default ${this.moduleKey}Router`
  }

  /**
   * 获取默认图标
   */
  getDefaultIcon() {
    // 根据模块名称推测合适的图标
    const iconMap = {
      user: 'user',
      department: 'tree',
      role: 'peoples',
      permission: 'lock',
      menu: 'tree-table',
      system: 'system',
      log: 'documentation',
      config: 'setting',
      dict: 'dict',
      file: 'upload'
    }
    
    const lowerKey = this.moduleKey.toLowerCase()
    for (const [key, icon] of Object.entries(iconMap)) {
      if (lowerKey.includes(key)) {
        return icon
      }
    }
    
    return 'table' // 默认图标
  }

  /**
   * 转换为PascalCase
   */
  toPascalCase(str) {
    return str.replace(/(?:^|_)([a-z])/g, (_, char) => char.toUpperCase())
  }
}

/**
 * 路由注册器
 * 用于自动注册新生成的路由到现有路由系统
 */
class RouterRegistrar {
  constructor() {
    this.routerFilePath = 'src/router/index.js'
    this.modulesPath = 'src/router/modules'
  }

  /**
   * 生成路由模块文件
   */
  generateModuleFile(moduleConfig) {
    const generator = new RouterTemplateGenerator(moduleConfig)
    return generator.generateRouteFile()
  }

  /**
   * 获取路由模块文件路径
   */
  getModuleFilePath(moduleKey) {
    return `${this.modulesPath}/${moduleKey}.js`
  }

  /**
   * 生成路由导入语句
   */
  generateImportStatement(moduleKey) {
    return `import ${moduleKey}Router from './modules/${moduleKey}'`
  }

  /**
   * 生成路由注册代码
   */
  generateRegistrationCode(moduleKey) {
    return `  ...${moduleKey}Router,`
  }

  /**
   * 生成路由注册指南
   */
  generateRegistrationGuide(moduleKey) {
    const importStatement = this.generateImportStatement(moduleKey)
    const registrationCode = this.generateRegistrationCode(moduleKey)
    
    return `/**
 * ${moduleKey} 路由注册指南
 * 
 * 1. 将生成的路由文件保存到: ${this.getModuleFilePath(moduleKey)}
 * 
 * 2. 在 ${this.routerFilePath} 文件中添加以下导入语句:
 * ${importStatement}
 * 
 * 3. 在 constantRoutes 或 asyncRoutes 数组中添加:
 * ${registrationCode}
 * 
 * 完整示例:
 * 
 * // 在文件顶部添加导入
 * ${importStatement}
 * 
 * // 在路由数组中添加
 * export const asyncRoutes = [
 *   // ... 其他路由
 * ${registrationCode}
 *   // ... 其他路由
 * ]
 */`
  }
}

/**
 * 面包屑配置生成器
 */
class BreadcrumbGenerator {
  constructor(moduleConfig) {
    this.config = moduleConfig
    this.moduleName = moduleConfig.moduleName
    this.moduleKey = moduleConfig.moduleKey
  }

  /**
   * 生成面包屑配置
   */
  generate() {
    return {
      [`/${this.moduleKey}`]: {
        title: `${this.moduleName}管理`,
        path: `/${this.moduleKey}`,
        children: {
          [`/${this.moduleKey}/index`]: {
            title: `${this.moduleName}列表`,
            path: `/${this.moduleKey}/index`
          }
        }
      }
    }
  }

  /**
   * 生成面包屑配置字符串
   */
  generateString() {
    const config = this.generate()
    return JSON.stringify(config, null, 2)
  }
}

/**
 * 菜单配置生成器
 */
class MenuGenerator {
  constructor(moduleConfig) {
    this.config = moduleConfig
    this.moduleName = moduleConfig.moduleName
    this.moduleKey = moduleConfig.moduleKey
  }

  /**
   * 生成菜单配置
   */
  generate() {
    return {
      id: this.generateMenuId(),
      title: `${this.moduleName}管理`,
      path: `/${this.moduleKey}`,
      icon: this.getDefaultIcon(),
      component: 'Layout',
      redirect: `/${this.moduleKey}/index`,
      children: [
        {
          id: this.generateMenuId('index'),
          title: `${this.moduleName}管理`,
          path: 'index',
          icon: '',
          component: `views/${this.moduleKey}/index`,
          permissions: [
            `${this.moduleKey}:list`,
            `${this.moduleKey}:create`,
            `${this.moduleKey}:update`,
            `${this.moduleKey}:delete`
          ]
        }
      ]
    }
  }

  /**
   * 生成菜单ID
   */
  generateMenuId(suffix = '') {
    const timestamp = Date.now()
    const base = `menu_${this.moduleKey}`
    return suffix ? `${base}_${suffix}_${timestamp}` : `${base}_${timestamp}`
  }

  /**
   * 获取默认图标
   */
  getDefaultIcon() {
    const iconMap = {
      user: 'user',
      department: 'tree',
      role: 'peoples',
      permission: 'lock',
      menu: 'tree-table',
      system: 'system',
      log: 'documentation',
      config: 'setting',
      dict: 'dict',
      file: 'upload'
    }
    
    const lowerKey = this.moduleKey.toLowerCase()
    for (const [key, icon] of Object.entries(iconMap)) {
      if (lowerKey.includes(key)) {
        return icon
      }
    }
    
    return 'table'
  }

  /**
   * 生成权限列表
   */
  generatePermissions() {
    return [
      {
        code: `${this.moduleKey}:list`,
        name: `查看${this.moduleName}`,
        description: `查看${this.moduleName}列表和详情的权限`
      },
      {
        code: `${this.moduleKey}:create`,
        name: `创建${this.moduleName}`,
        description: `创建新${this.moduleName}的权限`
      },
      {
        code: `${this.moduleKey}:update`,
        name: `编辑${this.moduleName}`,
        description: `编辑${this.moduleName}信息的权限`
      },
      {
        code: `${this.moduleKey}:delete`,
        name: `删除${this.moduleName}`,
        description: `删除${this.moduleName}的权限`
      }
    ]
  }
}

export {
  RouterTemplateGenerator,
  RouterRegistrar,
  BreadcrumbGenerator,
  MenuGenerator
}

export default RouterTemplateGenerator