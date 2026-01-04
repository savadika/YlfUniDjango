/**
 * Django模型到Vue代码生成器
 * 集成Django模型解析器和Vue模板生成器
 */

import DjangoModelParser from './djangoModelParser.js'
import VueTemplateGenerator from './vueTemplateGenerator.js'

class DjangoToVueGenerator {
  constructor() {
    this.djangoParser = new DjangoModelParser()
  }

  /**
   * 从Django模型代码生成Vue组件
   * @param {string} modelCode - Django模型代码
   * @param {Object} options - 生成选项
   * @returns {Object} 生成结果
   */
  generateFromDjangoModel(modelCode, options = {}) {
    try {
      // 1. 解析Django模型
      const frontendConfig = this.djangoParser.generateFrontendConfig(modelCode)
      
      // 2. 合并用户自定义选项
      if (options.moduleName) {
        frontendConfig.moduleName = options.moduleName
      }
      if (options.moduleKey) {
        frontendConfig.moduleKey = options.moduleKey
      }
      if (options.options) {
        frontendConfig.options = { ...frontendConfig.options, ...options.options }
      }
      
      // 3. 允许用户自定义字段配置
      if (options.fieldOverrides) {
        frontendConfig.fields = this.applyFieldOverrides(frontendConfig.fields, options.fieldOverrides)
      }
      
      // 4. 生成Vue组件代码
      const vueGenerator = new VueTemplateGenerator(frontendConfig)
      const vueCode = vueGenerator.generate()
      
      return {
        success: true,
        config: frontendConfig,
        vueCode: vueCode,
        modelInfo: this.djangoParser.parseModel(modelCode)
      }
    } catch (error) {
      return {
        success: false,
        error: error.message,
        config: null,
        vueCode: null
      }
    }
  }

  /**
   * 应用字段覆盖配置
   * @param {Array} fields - 原始字段配置
   * @param {Object} overrides - 覆盖配置
   * @returns {Array} 更新后的字段配置
   */
  applyFieldOverrides(fields, overrides) {
    return fields.map(field => {
      if (overrides[field.key]) {
        return { ...field, ...overrides[field.key] }
      }
      return field
    })
  }

  /**
   * 预览Django模型解析结果
   * @param {string} modelCode - Django模型代码
   * @returns {Object} 解析结果预览
   */
  previewDjangoModel(modelCode) {
    try {
      const modelInfo = this.djangoParser.parseModel(modelCode)
      const frontendConfig = this.djangoParser.generateFrontendConfig(modelCode)
      
      return {
        success: true,
        modelInfo: modelInfo,
        frontendConfig: frontendConfig,
        fieldCount: frontendConfig.fields.length,
        selectFields: frontendConfig.fields.filter(f => f.type === 'select'),
        requiredFields: frontendConfig.fields.filter(f => f.required),
        searchableFields: frontendConfig.fields.filter(f => f.searchable)
      }
    } catch (error) {
      return {
        success: false,
        error: error.message
      }
    }
  }

  /**
   * 生成API接口代码
   * @param {Object} modelInfo - 模型信息
   * @returns {string} API接口代码
   */
  generateApiCode(modelInfo) {
    const { modelName, tableName } = modelInfo
    const apiName = (tableName || modelName.toLowerCase()).replace('_', '')
    
    return `/**
 * ${modelInfo.verboseName || modelName} API接口
 */
import request from '@/utils/request'

// 获取${modelInfo.verboseName || modelName}列表
export function get${modelName}List(params) {
  return request({
    url: '/api/${apiName}/',
    method: 'get',
    params
  })
}

// 创建${modelInfo.verboseName || modelName}
export function create${modelName}(data) {
  return request({
    url: '/api/${apiName}/',
    method: 'post',
    data
  })
}

// 更新${modelInfo.verboseName || modelName}
export function update${modelName}(id, data) {
  return request({
    url: \`/api/${apiName}/\${id}/\`,
    method: 'put',
    data
  })
}

// 删除${modelInfo.verboseName || modelName}
export function delete${modelName}(id) {
  return request({
    url: \`/api/${apiName}/\${id}/\`,
    method: 'delete'
  })
}

// 获取${modelInfo.verboseName || modelName}详情
export function get${modelName}Detail(id) {
  return request({
    url: \`/api/${apiName}/\${id}/\`,
    method: 'get'
  })
}
`
  }

  /**
   * 生成完整的模块文件
   * @param {string} modelCode - Django模型代码
   * @param {Object} options - 生成选项
   * @returns {Object} 生成的文件内容
   */
  generateCompleteModule(modelCode, options = {}) {
    const result = this.generateFromDjangoModel(modelCode, options)
    
    if (!result.success) {
      return result
    }

    const apiCode = this.generateApiCode(result.modelInfo)
    
    return {
      ...result,
      files: {
        vue: {
          path: `src/views/${result.config.moduleKey}/index.vue`,
          content: result.vueCode
        },
        api: {
          path: `src/api/${result.config.moduleKey}.js`,
          content: apiCode
        }
      }
    }
  }

  /**
   * 批量生成多个Django模型
   * @param {Array} models - 模型代码数组
   * @param {Object} globalOptions - 全局选项
   * @returns {Array} 生成结果数组
   */
  generateMultipleModels(models, globalOptions = {}) {
    return models.map((modelCode, index) => {
      const options = {
        ...globalOptions,
        ...(globalOptions.modelSpecificOptions && globalOptions.modelSpecificOptions[index])
      }
      
      return this.generateCompleteModule(modelCode, options)
    })
  }
}

export default DjangoToVueGenerator