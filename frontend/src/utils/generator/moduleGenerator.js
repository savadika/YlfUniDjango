/**
 * 模块代码生成器主程序
 * 整合所有模板生成功能，提供统一的代码生成接口
 */

import { FieldConfig, ConfigBuilder } from './fieldConfig.js'
import VueTemplateGenerator from './vueTemplateGenerator.js'
import { ApiTemplateGenerator, ApiDocGenerator } from './apiTemplateGenerator.js'
import { RouterTemplateGenerator, RouterRegistrar, BreadcrumbGenerator, MenuGenerator } from './routerTemplateGenerator.js'

/**
 * 模块代码生成器主类
 */
class ModuleGenerator {
  constructor() {
    this.config = null
    this.generatedFiles = []
    this.errors = []
  }

  /**
   * 设置模块配置
   */
  setConfig(moduleConfig) {
    try {
      // 验证配置
      FieldConfig.validateModuleConfig(moduleConfig)
      this.config = moduleConfig
      this.errors = []
      return this
    } catch (error) {
      this.errors.push(`配置验证失败: ${error.message}`)
      throw error
    }
  }

  /**
   * 生成所有文件
   */
  generateAll() {
    if (!this.config) {
      throw new Error('请先设置模块配置')
    }

    this.generatedFiles = []
    this.errors = []

    try {
      // 生成Vue组件
      const vueComponent = this.generateVueComponent()
      this.generatedFiles.push({
        type: 'vue',
        path: `src/views/${this.config.moduleKey}/index.vue`,
        content: vueComponent,
        description: `${this.config.moduleName}管理页面组件`
      })

      // 生成API接口
      const apiFile = this.generateApiFile()
      this.generatedFiles.push({
        type: 'api',
        path: `src/api/${this.config.moduleKey}.js`,
        content: apiFile,
        description: `${this.config.moduleName}API接口`
      })

      // 生成路由配置
      const routerFile = this.generateRouterFile()
      this.generatedFiles.push({
        type: 'router',
        path: `src/router/modules/${this.config.moduleKey}.js`,
        content: routerFile,
        description: `${this.config.moduleName}路由配置`
      })

      // 生成API文档
      const apiDoc = this.generateApiDoc()
      this.generatedFiles.push({
        type: 'doc',
        path: `docs/api/${this.config.moduleKey}.md`,
        content: apiDoc,
        description: `${this.config.moduleName}API文档`
      })

      // 生成路由注册指南
      const routerGuide = this.generateRouterGuide()
      this.generatedFiles.push({
        type: 'guide',
        path: `docs/setup/${this.config.moduleKey}-router.md`,
        content: routerGuide,
        description: `${this.config.moduleName}路由注册指南`
      })

      // 生成菜单配置
      const menuConfig = this.generateMenuConfig()
      this.generatedFiles.push({
        type: 'config',
        path: `config/${this.config.moduleKey}-menu.json`,
        content: menuConfig,
        description: `${this.config.moduleName}菜单配置`
      })

      return {
        success: true,
        files: this.generatedFiles,
        errors: this.errors
      }
    } catch (error) {
      this.errors.push(`生成失败: ${error.message}`)
      return {
        success: false,
        files: this.generatedFiles,
        errors: this.errors
      }
    }
  }

  /**
   * 生成Vue组件
   */
  generateVueComponent() {
    const generator = new VueTemplateGenerator(this.config)
    return generator.generate()
  }

  /**
   * 生成API文件
   */
  generateApiFile() {
    const generator = new ApiTemplateGenerator(this.config)
    return generator.generate()
  }

  /**
   * 生成路由文件
   */
  generateRouterFile() {
    const generator = new RouterTemplateGenerator(this.config)
    return generator.generateRouteFile()
  }

  /**
   * 生成API文档
   */
  generateApiDoc() {
    const generator = new ApiDocGenerator(this.config)
    return generator.generate()
  }

  /**
   * 生成路由注册指南
   */
  generateRouterGuide() {
    const registrar = new RouterRegistrar()
    return registrar.generateRegistrationGuide(this.config.moduleKey)
  }

  /**
   * 生成菜单配置
   */
  generateMenuConfig() {
    const menuGenerator = new MenuGenerator(this.config)
    const menuConfig = menuGenerator.generate()
    const permissions = menuGenerator.generatePermissions()
    
    return JSON.stringify({
      menu: menuConfig,
      permissions: permissions
    }, null, 2)
  }

  /**
   * 生成面包屑配置
   */
  generateBreadcrumbConfig() {
    const generator = new BreadcrumbGenerator(this.config)
    return generator.generateString()
  }

  /**
   * 获取生成的文件列表
   */
  getGeneratedFiles() {
    return this.generatedFiles
  }

  /**
   * 获取错误列表
   */
  getErrors() {
    return this.errors
  }

  /**
   * 生成预览数据
   */
  generatePreview() {
    if (!this.config) {
      throw new Error('请先设置模块配置')
    }

    return {
      moduleInfo: {
        name: this.config.moduleName,
        key: this.config.moduleKey,
        fieldsCount: this.config.fields.length,
        options: this.config.options
      },
      fields: this.config.fields.map(field => ({
        key: field.key,
        label: field.label,
        type: field.type,
        required: field.required,
        searchable: field.searchable,
        showInTable: field.showInTable,
        showInForm: field.showInForm
      })),
      features: {
        search: this.config.options.enableSearch,
        export: this.config.options.enableExport,
        pagination: this.config.options.enablePagination
      },
      estimatedFiles: [
        `src/views/${this.config.moduleKey}/index.vue`,
        `src/api/${this.config.moduleKey}.js`,
        `src/router/modules/${this.config.moduleKey}.js`,
        `docs/api/${this.config.moduleKey}.md`,
        `docs/setup/${this.config.moduleKey}-router.md`,
        `config/${this.config.moduleKey}-menu.json`
      ]
    }
  }
}

/**
 * 批量生成器
 * 支持批量生成多个模块
 */
class BatchGenerator {
  constructor() {
    this.modules = []
    this.results = []
  }

  /**
   * 添加模块配置
   */
  addModule(moduleConfig) {
    this.modules.push(moduleConfig)
    return this
  }

  /**
   * 批量生成所有模块
   */
  generateAll() {
    this.results = []
    
    for (const moduleConfig of this.modules) {
      try {
        const generator = new ModuleGenerator()
        const result = generator.setConfig(moduleConfig).generateAll()
        
        this.results.push({
          moduleKey: moduleConfig.moduleKey,
          moduleName: moduleConfig.moduleName,
          ...result
        })
      } catch (error) {
        this.results.push({
          moduleKey: moduleConfig.moduleKey,
          moduleName: moduleConfig.moduleName,
          success: false,
          files: [],
          errors: [error.message]
        })
      }
    }
    
    return this.results
  }

  /**
   * 获取生成结果统计
   */
  getStatistics() {
    const total = this.results.length
    const successful = this.results.filter(r => r.success).length
    const failed = total - successful
    const totalFiles = this.results.reduce((sum, r) => sum + r.files.length, 0)
    
    return {
      total,
      successful,
      failed,
      totalFiles,
      successRate: total > 0 ? (successful / total * 100).toFixed(2) + '%' : '0%'
    }
  }
}

/**
 * 代码生成器工厂
 * 提供便捷的创建方法
 */
class GeneratorFactory {
  /**
   * 创建单个模块生成器
   */
  static createModuleGenerator() {
    return new ModuleGenerator()
  }

  /**
   * 创建批量生成器
   */
  static createBatchGenerator() {
    return new BatchGenerator()
  }

  /**
   * 创建配置构建器
   */
  static createConfigBuilder() {
    return new ConfigBuilder()
  }

  /**
   * 快速生成模块（使用预设模板）
   */
  static quickGenerate(moduleName, moduleKey, template = 'basic', customFields = []) {
    const builder = new ConfigBuilder()
    const config = builder
      .setModule(moduleName, moduleKey)
      .useTemplate(template)
      .addFields(customFields)
      .build()
    
    const generator = new ModuleGenerator()
    return generator.setConfig(config).generateAll()
  }

  /**
   * 从部门模块克隆生成新模块
   */
  static cloneFromDepartment(moduleName, moduleKey, fieldOverrides = {}) {
    // 基于部门模块的字段配置
    const departmentFields = [
      { key: 'id', label: 'ID', type: 'number', showInForm: false, showInTable: true, width: 80 },
      { key: 'name', label: '名称', type: 'string', required: true, searchable: true, defaultSearch: true, placeholder: `请输入${moduleName}名称` },
      { key: 'status', label: '状态', type: 'switch', searchable: true, defaultSearch: true, activeText: '正常', inactiveText: '停用', activeValue: 1, inactiveValue: 0, defaultValue: 1 },
      { key: 'remark', label: '备注', type: 'textarea', searchable: true, placeholder: `请输入${moduleName}备注` },
      { key: 'create_time', label: '创建时间', type: 'date', searchable: true, showInForm: false, width: 140 },
      { key: 'update_time', label: '更新时间', type: 'date', searchable: true, showInForm: false, width: 140 }
    ]

    // 应用字段覆盖
    const fields = departmentFields.map(field => ({ ...field, ...fieldOverrides[field.key] }))

    const config = {
      moduleName,
      moduleKey,
      fields,
      options: {
        enableSearch: true,
        enableExport: true,
        enablePagination: true,
        pageSize: 10
      }
    }

    const generator = new ModuleGenerator()
    return generator.setConfig(config).generateAll()
  }
}

/**
 * 文件写入器
 * 负责将生成的代码写入到实际文件
 */
class FileWriter {
  constructor(basePath = '') {
    this.basePath = basePath
    this.writtenFiles = []
    this.errors = []
  }

  /**
   * 写入生成的文件
   */
  async writeFiles(generatedFiles) {
    this.writtenFiles = []
    this.errors = []

    for (const file of generatedFiles) {
      try {
        const fullPath = this.basePath ? `${this.basePath}/${file.path}` : file.path
        
        // 这里需要实际的文件写入逻辑
        // 在实际使用时，可以使用 Node.js 的 fs 模块或浏览器的文件 API
        console.log(`写入文件: ${fullPath}`)
        console.log(`文件类型: ${file.type}`)
        console.log(`文件描述: ${file.description}`)
        console.log(`文件内容长度: ${file.content.length} 字符`)
        
        this.writtenFiles.push({
          path: fullPath,
          type: file.type,
          description: file.description,
          size: file.content.length
        })
      } catch (error) {
        this.errors.push(`写入文件 ${file.path} 失败: ${error.message}`)
      }
    }

    return {
      success: this.errors.length === 0,
      writtenFiles: this.writtenFiles,
      errors: this.errors
    }
  }

  /**
   * 创建目录结构
   */
  createDirectories(paths) {
    // 实际实现中需要创建目录
    console.log('创建目录结构:', paths)
  }
}

/**
 * 代码生成器CLI接口
 * 提供命令行接口支持
 */
class GeneratorCLI {
  constructor() {
    this.generator = new ModuleGenerator()
    this.writer = new FileWriter()
  }

  /**
   * 执行生成命令
   */
  async execute(options) {
    try {
      // 解析配置
      const config = this.parseConfig(options)
      
      // 生成代码
      const result = this.generator.setConfig(config).generateAll()
      
      if (!result.success) {
        throw new Error(`生成失败: ${result.errors.join(', ')}`)
      }
      
      // 写入文件
      const writeResult = await this.writer.writeFiles(result.files)
      
      return {
        success: writeResult.success,
        message: writeResult.success ? '生成成功' : '生成失败',
        files: writeResult.writtenFiles,
        errors: [...result.errors, ...writeResult.errors]
      }
    } catch (error) {
      return {
        success: false,
        message: `执行失败: ${error.message}`,
        files: [],
        errors: [error.message]
      }
    }
  }

  /**
   * 解析配置
   */
  parseConfig(options) {
    // 实际实现中可以从命令行参数、配置文件等解析
    return options.config || {}
  }

  /**
   * 显示帮助信息
   */
  showHelp() {
    return `
模块代码生成器 CLI

用法:
  generate --config <配置文件路径>
  generate --module <模块名> --key <模块标识> [选项]

选项:
  --config <path>     指定配置文件路径
  --module <name>     模块名称
  --key <key>         模块标识
  --template <name>   使用预设模板 (basic, withSort)
  --output <path>     输出目录
  --help              显示帮助信息

示例:
  generate --module "用户管理" --key "user" --template "basic"
  generate --config "./user-config.json" --output "./src"
`
  }
}

export {
  ModuleGenerator,
  BatchGenerator,
  GeneratorFactory,
  FileWriter,
  GeneratorCLI
}

export default ModuleGenerator