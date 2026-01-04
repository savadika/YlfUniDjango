/**
 * API接口模板生成器
 * 基于字段配置生成标准的CRUD接口
 */

/**
 * API模板生成器类
 */
class ApiTemplateGenerator {
  constructor(moduleConfig) {
    this.config = moduleConfig
    this.fields = moduleConfig.fields
    this.moduleName = moduleConfig.moduleName
    this.moduleKey = moduleConfig.moduleKey
    this.options = moduleConfig.options || {}
  }

  /**
   * 生成完整的API文件
   */
  generate() {
    const imports = this.generateImports()
    const functions = this.generateFunctions()
    const exports = this.generateExports()

    return `${imports}

${functions}

${exports}`
  }

  /**
   * 生成导入语句
   */
  generateImports() {
    return `import request from '@/utils/request'`
  }

  /**
   * 生成API函数
   */
  generateFunctions() {
    const functions = []
    
    // 获取列表
    functions.push(this.generateGetListFunction())
    
    // 获取详情
    functions.push(this.generateGetDetailFunction())
    
    // 创建
    functions.push(this.generateCreateFunction())
    
    // 更新（全量）
    functions.push(this.generateUpdateFunction())
    
    // 更新（部分）
    functions.push(this.generatePatchFunction())
    
    // 删除
    functions.push(this.generateDeleteFunction())
    
    return functions.join('\n\n')
  }

  /**
   * 生成获取列表函数
   */
  generateGetListFunction() {
    const functionName = `get${this.toPascalCase(this.moduleKey)}List`
    const endpoint = `/${this.moduleKey}`
    
    return `/**
 * 获取${this.moduleName}列表
 * @param {Object} params - 查询参数
 * @param {number} params.page - 页码
 * @param {number} params.size - 每页数量
${this.generateParamComments()}
 * @returns {Promise} 返回${this.moduleName}列表数据
 */
export function ${functionName}(params) {
  return request({
    url: '${endpoint}',
    method: 'get',
    params
  })
}`
  }

  /**
   * 生成获取详情函数
   */
  generateGetDetailFunction() {
    const functionName = `get${this.toPascalCase(this.moduleKey)}Detail`
    const endpoint = `/${this.moduleKey}`
    
    return `/**
 * 获取${this.moduleName}详情
 * @param {number|string} id - ${this.moduleName}ID
 * @returns {Promise} 返回${this.moduleName}详情数据
 */
export function ${functionName}(id) {
  return request({
    url: \`${endpoint}/\${id}\`,
    method: 'get'
  })
}`
  }

  /**
   * 生成创建函数
   */
  generateCreateFunction() {
    const functionName = `create${this.toPascalCase(this.moduleKey)}`
    const endpoint = `/${this.moduleKey}`
    
    return `/**
 * 创建${this.moduleName}
 * @param {Object} data - ${this.moduleName}数据
${this.generateDataComments()}
 * @returns {Promise} 返回创建结果
 */
export function ${functionName}(data) {
  return request({
    url: '${endpoint}',
    method: 'post',
    data
  })
}`
  }

  /**
   * 生成更新函数（全量）
   */
  generateUpdateFunction() {
    const functionName = `update${this.toPascalCase(this.moduleKey)}`
    const endpoint = `/${this.moduleKey}`
    
    return `/**
 * 更新${this.moduleName}（全量更新）
 * @param {number|string} id - ${this.moduleName}ID
 * @param {Object} data - ${this.moduleName}数据
${this.generateDataComments()}
 * @returns {Promise} 返回更新结果
 */
export function ${functionName}(id, data) {
  return request({
    url: \`${endpoint}/\${id}\`,
    method: 'put',
    data
  })
}`
  }

  /**
   * 生成更新函数（部分）
   */
  generatePatchFunction() {
    const functionName = `patch${this.toPascalCase(this.moduleKey)}`
    const endpoint = `/${this.moduleKey}`
    
    return `/**
 * 更新${this.moduleName}（部分更新）
 * @param {number|string} id - ${this.moduleName}ID
 * @param {Object} data - 要更新的${this.moduleName}数据字段
 * @returns {Promise} 返回更新结果
 */
export function ${functionName}(id, data) {
  return request({
    url: \`${endpoint}/\${id}\`,
    method: 'patch',
    data
  })
}`
  }

  /**
   * 生成删除函数
   */
  generateDeleteFunction() {
    const functionName = `delete${this.toPascalCase(this.moduleKey)}`
    const endpoint = `/${this.moduleKey}`
    
    return `/**
 * 删除${this.moduleName}
 * @param {number|string} id - ${this.moduleName}ID
 * @returns {Promise} 返回删除结果
 */
export function ${functionName}(id) {
  return request({
    url: \`${endpoint}/\${id}\`,
    method: 'delete'
  })
}`
  }

  /**
   * 生成查询参数注释
   */
  generateParamComments() {
    const searchableFields = this.fields.filter(field => field.searchable)
    if (searchableFields.length === 0) return ''
    
    return searchableFields.map(field => {
      const type = this.getJSDocType(field.type)
      return ` * @param {${type}} [params.${field.key}] - ${field.label}`
    }).join('\n')
  }

  /**
   * 生成数据字段注释
   */
  generateDataComments() {
    const formFields = this.fields.filter(field => field.showInForm && field.key !== 'id')
    if (formFields.length === 0) return ''
    
    return formFields.map(field => {
      const type = this.getJSDocType(field.type)
      const required = field.required ? '' : '?'
      return ` * @param {${type}} ${required}data.${field.key} - ${field.label}`
    }).join('\n')
  }

  /**
   * 获取JSDoc类型
   */
  getJSDocType(fieldType) {
    const typeMap = {
      string: 'string',
      number: 'number',
      select: 'string|number',
      switch: 'number|boolean',
      date: 'string',
      daterange: 'Array<string>',
      textarea: 'string'
    }
    return typeMap[fieldType] || 'string'
  }

  /**
   * 生成导出语句
   */
  generateExports() {
    const functionNames = [
      `get${this.toPascalCase(this.moduleKey)}List`,
      `get${this.toPascalCase(this.moduleKey)}Detail`,
      `create${this.toPascalCase(this.moduleKey)}`,
      `update${this.toPascalCase(this.moduleKey)}`,
      `patch${this.toPascalCase(this.moduleKey)}`,
      `delete${this.toPascalCase(this.moduleKey)}`
    ]
    
    return `// 默认导出所有API函数
export default {
  ${functionNames.join(',\n  ')}
}`
  }

  /**
   * 转换为PascalCase
   */
  toPascalCase(str) {
    return str.replace(/(?:^|_)([a-z])/g, (_, char) => char.toUpperCase())
  }
}

/**
 * 生成RESTful API接口文档
 */
class ApiDocGenerator {
  constructor(moduleConfig) {
    this.config = moduleConfig
    this.fields = moduleConfig.fields
    this.moduleName = moduleConfig.moduleName
    this.moduleKey = moduleConfig.moduleKey
  }

  /**
   * 生成API文档
   */
  generate() {
    const overview = this.generateOverview()
    const endpoints = this.generateEndpoints()
    const models = this.generateModels()
    
    return `# ${this.moduleName}管理 API 文档

${overview}

## API 端点

${endpoints}

## 数据模型

${models}`
  }

  /**
   * 生成概览
   */
  generateOverview() {
    return `## 概览

本文档描述了${this.moduleName}管理相关的API接口，包括增删改查等基本操作。

**基础URL**: \`/api/${this.moduleKey}\`

**认证方式**: Bearer Token

**响应格式**: JSON`
  }

  /**
   * 生成端点文档
   */
  generateEndpoints() {
    const endpoints = []
    
    // 获取列表
    endpoints.push(this.generateListEndpoint())
    
    // 获取详情
    endpoints.push(this.generateDetailEndpoint())
    
    // 创建
    endpoints.push(this.generateCreateEndpoint())
    
    // 更新
    endpoints.push(this.generateUpdateEndpoint())
    
    // 部分更新
    endpoints.push(this.generatePatchEndpoint())
    
    // 删除
    endpoints.push(this.generateDeleteEndpoint())
    
    return endpoints.join('\n\n')
  }

  /**
   * 生成列表端点文档
   */
  generateListEndpoint() {
    const searchableFields = this.fields.filter(field => field.searchable)
    
    let doc = `### 获取${this.moduleName}列表

**请求**
\`\`\`
GET /${this.moduleKey}
\`\`\`

**查询参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| page | number | 否 | 页码，默认1 |
| size | number | 否 | 每页数量，默认10 |`
    
    searchableFields.forEach(field => {
      const type = this.getDocType(field.type)
      doc += `\n| ${field.key} | ${type} | 否 | ${field.label} |\n`
    })
    
    doc += `\n\n**响应示例**
\`\`\`json
{
  "code": 200,
  "message": "success",
  "data": {
    "list": [${this.generateSampleData()}],
    "total": 100,
    "page": 1,
    "size": 10
  }
}
\`\`\``
    
    return doc
  }

  /**
   * 生成详情端点文档
   */
  generateDetailEndpoint() {
    return `### 获取${this.moduleName}详情

**请求**
\`\`\`
GET /${this.moduleKey}/{id}
\`\`\`

**路径参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| id | number | 是 | ${this.moduleName}ID |

**响应示例**
\`\`\`json
{
  "code": 200,
  "message": "success",
  "data": ${this.generateSampleData()}
}
\`\`\``
  }

  /**
   * 生成创建端点文档
   */
  generateCreateEndpoint() {
    const formFields = this.fields.filter(field => field.showInForm && field.key !== 'id')
    
    let doc = `### 创建${this.moduleName}

**请求**
\`\`\`
POST /${this.moduleKey}
\`\`\`

**请求体参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|`
    
    formFields.forEach(field => {
      const type = this.getDocType(field.type)
      const required = field.required ? '是' : '否'
      doc += `\n| ${field.key} | ${type} | ${required} | ${field.label} |\n`
    })
    
    const sampleData = this.generateSampleRequestData()
    doc += `\n\n**请求示例**
\`\`\`json
${sampleData}
\`\`\`

**响应示例**
\`\`\`json
{
  "code": 200,
  "message": "创建成功",
  "data": ${this.generateSampleData()}
}
\`\`\``
    
    return doc
  }

  /**
   * 生成更新端点文档
   */
  generateUpdateEndpoint() {
    const formFields = this.fields.filter(field => field.showInForm && field.key !== 'id')
    
    let doc = `### 更新${this.moduleName}（全量）

**请求**
\`\`\`
PUT /${this.moduleKey}/{id}
\`\`\`

**路径参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| id | number | 是 | ${this.moduleName}ID |

**请求体参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|`
    
    formFields.forEach(field => {
      const type = this.getDocType(field.type)
      const required = field.required ? '是' : '否'
      doc += `\n| ${field.key} | ${type} | ${required} | ${field.label} |\n`
    })
    
    const sampleData = this.generateSampleRequestData()
    doc += `\n\n**请求示例**
\`\`\`json
${sampleData}
\`\`\`

**响应示例**
\`\`\`json
{
  "code": 200,
  "message": "更新成功",
  "data": ${this.generateSampleData()}
}
\`\`\``
    
    return doc
  }

  /**
   * 生成部分更新端点文档
   */
  generatePatchEndpoint() {
    return `### 更新${this.moduleName}（部分）

**请求**
\`\`\`
PATCH /${this.moduleKey}/{id}
\`\`\`

**路径参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| id | number | 是 | ${this.moduleName}ID |

**请求体参数**

可以只传递需要更新的字段，支持部分更新。

**请求示例**
\`\`\`json
{
  "status": 1,
  "remark": "更新备注"
}
\`\`\`

**响应示例**
\`\`\`json
{
  "code": 200,
  "message": "更新成功",
  "data": ${this.generateSampleData()}
}
\`\`\``
  }

  /**
   * 生成删除端点文档
   */
  generateDeleteEndpoint() {
    return `### 删除${this.moduleName}

**请求**
\`\`\`
DELETE /${this.moduleKey}/{id}
\`\`\`

**路径参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| id | number | 是 | ${this.moduleName}ID |

**响应示例**
\`\`\`json
{
  "code": 200,
  "message": "删除成功",
  "data": null
}
\`\`\``
  }

  /**
   * 生成数据模型文档
   */
  generateModels() {
    let doc = `### ${this.moduleName}模型

| 字段名 | 类型 | 必填 | 说明 |
|--------|------|------|------|`
    
    this.fields.forEach(field => {
      const type = this.getDocType(field.type)
      const required = field.required ? '是' : '否'
      doc += `\n| ${field.key} | ${type} | ${required} | ${field.label} |\n`
    })
    
    return doc
  }

  /**
   * 生成示例数据
   */
  generateSampleData() {
    const data = {}
    this.fields.forEach(field => {
      data[field.key] = this.getSampleValue(field)
    })
    return JSON.stringify(data, null, 2)
  }

  /**
   * 生成请求示例数据
   */
  generateSampleRequestData() {
    const data = {}
    const formFields = this.fields.filter(field => field.showInForm && field.key !== 'id')
    formFields.forEach(field => {
      data[field.key] = this.getSampleValue(field)
    })
    return JSON.stringify(data, null, 2)
  }

  /**
   * 获取示例值
   */
  getSampleValue(field) {
    switch (field.type) {
      case 'string':
        return `示例${field.label}`
      case 'number':
        return field.key === 'id' ? 1 : 100
      case 'select':
        return field.options && field.options.length > 0 ? field.options[0].value : 1
      case 'switch':
        return field.activeValue
      case 'date':
        return '2024-01-01'
      case 'daterange':
        return ['2024-01-01', '2024-01-31']
      case 'textarea':
        return `这是${field.label}的示例内容`
      default:
        return `示例${field.label}`
    }
  }

  /**
   * 获取文档类型
   */
  getDocType(fieldType) {
    const typeMap = {
      string: 'string',
      number: 'number',
      select: 'string/number',
      switch: 'number',
      date: 'string',
      daterange: 'array',
      textarea: 'string'
    }
    return typeMap[fieldType] || 'string'
  }
}

export { ApiTemplateGenerator, ApiDocGenerator }
export default ApiTemplateGenerator