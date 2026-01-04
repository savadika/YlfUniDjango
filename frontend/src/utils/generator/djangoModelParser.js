/**
 * Django模型解析器
 * 用于解析Django模型字段定义并转换为前端字段配置
 */

class DjangoModelParser {
  constructor() {
    // Django字段类型到前端字段类型的映射
    this.fieldTypeMapping = {
      // 自增字段
      'AutoField': 'number',
      'BigAutoField': 'number',
      
      // 整数字段
      'IntegerField': 'number',
      'BigIntegerField': 'number',
      'SmallIntegerField': 'number',
      'PositiveIntegerField': 'number',
      'PositiveSmallIntegerField': 'number',
      'PositiveBigIntegerField': 'number',
      
      // 浮点数字段
      'FloatField': 'number',
      'DecimalField': 'number',
      
      // 文本字段
      'CharField': 'string',
      'TextField': 'textarea',
      'SlugField': 'string',
      
      // 布尔字段
      'BooleanField': 'boolean',
      'NullBooleanField': 'boolean', // 已废弃，但仍需支持
      
      // 日期时间字段
      'DateField': 'date',
      'DateTimeField': 'datetime',
      'TimeField': 'time',
      'DurationField': 'string',
      
      // 特殊文本字段
      'EmailField': 'email',
      'URLField': 'url',
      'UUIDField': 'string',
      'GenericIPAddressField': 'string',
      
      // 文件字段
      'FileField': 'file',
      'ImageField': 'image',
      'FilePathField': 'select',
      
      // 二进制字段
      'BinaryField': 'textarea',
      
      // JSON字段
      'JSONField': 'textarea',
      
      // 关系字段
      'ForeignKey': 'select',
      'OneToOneField': 'select',
      'ManyToManyField': 'multiselect',
      
      // 通用关系字段
      'GenericForeignKey': 'string',
      'ContentType': 'select'
    }
  }

  /**
   * 解析Django模型代码
   * @param {string} modelCode - Django模型代码
   * @returns {Object} 解析结果
   */
  parseModel(modelCode) {
    const result = {
      modelName: '',
      tableName: '',
      verboseName: '',
      fields: []
    }

    try {
      // 提取模型名称
      const classMatch = modelCode.match(/class\s+(\w+)\s*\(/)
      if (classMatch) {
        result.modelName = classMatch[1]
      }

      // 提取Meta信息
      const metaMatch = modelCode.match(/class\s+Meta:\s*\n([\s\S]*?)(?=\n\s{0,3}\w|\n\s{0,3}$|$)/m)
      if (metaMatch) {
        const metaContent = metaMatch[1]
        
        // 提取db_table
        const dbTableMatch = metaContent.match(/db_table\s*=\s*['"]([^'"]+)['"]/)
        if (dbTableMatch) {
          result.tableName = dbTableMatch[1]
        }
        
        // 提取verbose_name
        const verboseNameMatch = metaContent.match(/verbose_name\s*=\s*['"]([^'"]+)['"]/)
        if (verboseNameMatch) {
          result.verboseName = verboseNameMatch[1]
        }
      }

      // 解析字段
      result.fields = this.parseFields(modelCode)

      return result
    } catch (error) {
      console.error('解析Django模型时出错:', error)
      throw new Error('Django模型解析失败: ' + error.message)
    }
  }

  /**
   * 解析模型字段
   * @param {string} modelCode - Django模型代码
   * @returns {Array} 字段配置数组
   */
  parseFields(modelCode) {
    const fields = []
    
    // 使用更精确的方法来解析字段，处理嵌套括号
    const lines = modelCode.split('\n')
    
    for (const line of lines) {
      const trimmedLine = line.trim()
      if (trimmedLine.includes('= models.')) {
        // 修改正则表达式以处理行尾注释
        const match = trimmedLine.match(/^(\w+)\s*=\s*models\.(\w+)\s*\((.*?)\)\s*(?:#.*)?$/)
        if (match) {
          const [, fieldName, fieldType, fieldParams] = match
          
          // 不再跳过id字段，确保所有字段都能被导入
          // 但为id字段设置特殊属性
          if (fieldName === 'id' && (fieldType === 'AutoField' || fieldType === 'BigAutoField')) {
            const idFieldConfig = {
              key: 'id',
              label: 'ID',
              type: 'number',
              required: false,
              showInTable: true,
              showInForm: true, // ID字段默认在表单中显示
              searchable: false, // ID字段默认不可搜索
              sortable: true,
              isPrimaryKey: true
            }
            fields.push(idFieldConfig)
            continue
          }

          const fieldConfig = this.parseFieldConfig(fieldName, fieldType, fieldParams)
          if (fieldConfig) {
            fields.push(fieldConfig)
          }
        }
      }
    }

    return fields
  }

  /**
   * 解析单个字段配置
   * @param {string} fieldName - 字段名
   * @param {string} fieldType - Django字段类型
   * @param {string} fieldParams - 字段参数
   * @returns {Object} 字段配置
   */
  parseFieldConfig(fieldName, fieldType, fieldParams) {
    const config = {
      key: fieldName,
      label: fieldName,
      type: this.fieldTypeMapping[fieldType] || 'string',
      required: false,
      showInTable: true,
      showInForm: true,
      searchable: false,
      sortable: false
    }

    // 解析字段参数
    const params = this.parseFieldParams(fieldParams)
    
    // 处理verbose_name
    if (params.verbose_name) {
      config.label = params.verbose_name
    }

    // 处理required（Django中null=False表示必填）
    if (params.null === false || (!params.hasOwnProperty('null') && !params.hasOwnProperty('blank'))) {
      config.required = true
    }

    // 处理choices
    if (params.choices) {
      config.type = 'select'
      config.options = this.parseChoices(params.choices)
      config.hasStaticOptions = true // 标记为有静态选项的select
      config.optionsSource = 'choices' // 选项来源：Django choices
    }

    // 为select类型字段添加API选项配置支持
    if (config.type === 'select' || config.type === 'multiselect') {
      // 如果没有静态选项，则支持API选项配置
      if (!config.hasStaticOptions) {
        config.optionsSource = 'api' // 选项来源：API
        config.apiUrl = '' // API地址，需要用户配置
        config.valueField = 'value' // API返回数据中的值字段
        config.labelField = 'label' // API返回数据中的标签字段
        config.needsApiOptions = true // 标记需要通过API获取选项
      }
      
      // 添加选项配置的灵活性
      config.optionConfig = {
        source: config.optionsSource || 'static', // static, api, choices
        staticOptions: config.options || [],
        apiConfig: {
          url: config.apiUrl || '',
          valueField: config.valueField || 'value',
          labelField: config.labelField || 'label',
          method: 'GET',
          params: {}
        }
      }
    }

    // 处理max_length
    if (params.max_length) {
      config.maxLength = parseInt(params.max_length)
    }

    // 处理default值
    if (params.default !== undefined) {
      config.defaultValue = params.default
    }

    // 根据字段类型设置特殊属性
    this.setFieldTypeSpecificProps(config, fieldType, params)

    // 设置搜索和排序属性
    this.setSearchAndSortProps(config, fieldType)

    return config
  }

  /**
   * 解析字段参数
   * @param {string} paramsStr - 参数字符串
   * @returns {Object} 参数对象
   */
  parseFieldParams(paramsStr) {
    const params = {}
    
    // 解析各种参数
    const patterns = {
      max_length: /max_length\s*=\s*(\d+)/,
      null: /null\s*=\s*(True|False)/,
      blank: /blank\s*=\s*(True|False)/,
      default: /default\s*=\s*([^,)]+)/,
      verbose_name: /verbose_name\s*=\s*['"]([^'"]+)['"]/,
      choices: /choices\s*=\s*(\[.*?\])/s,
      primary_key: /primary_key\s*=\s*(True|False)/,
      unique: /unique\s*=\s*(True|False)/,
      on_delete: /on_delete\s*=\s*models\.(\w+)/,
      related_name: /related_name\s*=\s*['"]([^'"]+)['"]/
    }

    for (const [key, pattern] of Object.entries(patterns)) {
      const match = paramsStr.match(pattern)
      if (match) {
        if (key === 'null' || key === 'blank' || key === 'primary_key' || key === 'unique') {
          params[key] = match[1] === 'True'
        } else if (key === 'max_length') {
          params[key] = parseInt(match[1])
        } else if (key === 'choices') {
          params[key] = match[1]
        } else if (key === 'default') {
          // 处理默认值，去除多余的空格和逗号
          params[key] = match[1].trim().replace(/,$/, '')
        } else {
          params[key] = match[1]
        }
      }
    }

    // 解析外键关联模型（第一个参数）
    if (paramsStr.trim()) {
      const firstParamMatch = paramsStr.match(/^\s*([^,\s]+)/)
      if (firstParamMatch) {
        params.relatedModel = firstParamMatch[1].replace(/['"`]/g, '')
      }
    }

    return params
  }

  /**
   * 解析Django choices为前端选项
   * @param {string} choicesStr - choices字符串
   * @returns {Array} 选项数组
   */
  parseChoices(choicesStr) {
    try {
      // 移除外层的方括号
      const cleanStr = choicesStr.replace(/^\[|\]$/g, '').trim()
      
      // 支持多种Django choices格式
      // 格式1: [(value, 'label'), ...]
      // 格式2: [('value', 'label'), ...]
      // 格式3: 常量定义格式，如 STATUS_CHOICES = [...]
      
      // 匹配 (value, 'label') 格式的选项
      const tupleMatches = cleanStr.match(/\([^)]+\)/g)
      if (tupleMatches) {
        return tupleMatches.map(match => {
          // 解析每个选项 (value, 'label')
          const content = match.slice(1, -1) // 移除括号
          const parts = content.split(',').map(part => part.trim())
          
          if (parts.length >= 2) {
            let value = parts[0].replace(/^['"]/g, '').replace(/['"]$/g, '')
            const label = parts[1].replace(/^['"]/g, '').replace(/['"]$/g, '')
            
            // 智能类型转换
            // 尝试转换为数字
            const numValue = Number(value)
            if (!isNaN(numValue) && isFinite(numValue)) {
              value = numValue
            }
            // 尝试转换为布尔值
            else if (value.toLowerCase() === 'true') {
              value = true
            } else if (value.toLowerCase() === 'false') {
              value = false
            }
            
            return {
              value: value,
              label: label
            }
          }
          return null
        }).filter(Boolean)
      }
      
      // 如果没有匹配到元组格式，尝试解析其他格式
      // 例如: ['option1', 'option2'] 或 {"key": "value"}
      try {
        const evaluated = eval(`[${cleanStr}]`)
        if (Array.isArray(evaluated)) {
          return evaluated.map((item, index) => {
            if (typeof item === 'string') {
              return { value: item, label: item }
            } else if (typeof item === 'object' && item !== null) {
              const keys = Object.keys(item)
              if (keys.length > 0) {
                return { value: keys[0], label: item[keys[0]] }
              }
            }
            return { value: index, label: String(item) }
          }).filter(Boolean)
        }
      } catch (evalError) {
        console.warn('无法解析choices格式:', evalError)
      }
      
      return []
    } catch (error) {
      console.warn('解析choices失败:', error)
      return []
    }
  }

  /**
   * 设置字段类型特定属性
   * @param {Object} config - 字段配置
   * @param {string} fieldType - Django字段类型
   * @param {Object} params - 字段参数
   */
  setFieldTypeSpecificProps(config, fieldType, params) {
    switch (fieldType) {
      case 'TextField':
        config.rows = 4
        break
      case 'EmailField':
        config.pattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
        break
      case 'URLField':
        config.pattern = /^https?:\/\/.+/
        break
      case 'DateField':
      case 'DateTimeField':
        config.format = fieldType === 'DateField' ? 'YYYY-MM-DD' : 'YYYY-MM-DD HH:mm:ss'
        break
      case 'BooleanField':
        config.defaultValue = false
        config.type = 'switch'
        break
      case 'ForeignKey':
        // 外键字段特殊处理
        config.relatedModel = params.relatedModel
        config.required = !params.null // 如果null=True则不必填
        config.isForeignKey = true
        // 外键字段默认不在表单中必填，而是通过API动态加载选项
        config.loadOptionsFromApi = true
        config.hasStaticOptions = false // 外键字段不需要静态选项配置
        config.needsApiOptions = true // 标记需要通过API获取选项
        break
      case 'ManyToManyField':
        // 多对多字段特殊处理
        config.relatedModel = params.relatedModel
        config.required = false // 多对多字段通常不必填
        config.isManyToMany = true
        config.loadOptionsFromApi = true
        config.hasStaticOptions = false // 多对多字段不需要静态选项配置
        config.needsApiOptions = true // 标记需要通过API获取选项
        break
    }
  }

  /**
   * 设置搜索和排序属性
   * @param {Object} config - 字段配置
   * @param {string} fieldType - Django字段类型
   */
  setSearchAndSortProps(config, fieldType) {
    // 文本类型字段通常可搜索，并且是默认搜索字段
    if (['CharField', 'TextField', 'EmailField', 'URLField', 'SlugField'].includes(fieldType)) {
      config.searchable = true
      config.defaultSearch = true
    }

    // 所有时间类型字段都应该可搜索（用于日期范围搜索）
    if (['DateField', 'DateTimeField', 'TimeField'].includes(fieldType)) {
      config.searchable = true
      config.searchType = 'daterange' // 设置为日期范围搜索
      // 时间字段默认不作为默认搜索字段，让用户手动选择后进行搜索
      config.defaultSearch = false
    }

    // 数字类型字段也可以搜索
    if (['IntegerField', 'BigIntegerField', 'SmallIntegerField', 
         'PositiveIntegerField', 'PositiveSmallIntegerField', 'PositiveBigIntegerField',
         'FloatField', 'DecimalField', 'AutoField', 'BigAutoField'].includes(fieldType)) {
      config.searchable = true
      config.searchType = 'range' // 数字字段支持范围搜索
    }

    // 布尔字段可搜索
    if (['BooleanField', 'NullBooleanField'].includes(fieldType)) {
      config.searchable = true
      config.searchType = 'select' // 布尔字段使用选择搜索
    }

    // 数字、日期类型字段通常可排序
    if (['IntegerField', 'BigIntegerField', 'SmallIntegerField', 
         'PositiveIntegerField', 'PositiveSmallIntegerField', 'PositiveBigIntegerField',
         'FloatField', 'DecimalField', 'DateField', 'DateTimeField', 'TimeField', 
         'AutoField', 'BigAutoField'].includes(fieldType)) {
      config.sortable = true
    }

    // 选择类型字段也应该可搜索，状态字段作为默认搜索
    if (config.type === 'select' || config.type === 'multiselect') {
      config.searchable = true
      config.sortable = true
      config.searchType = 'select' // 选择字段使用选择搜索
      if (config.key === 'status' || config.key === 'state') {
        config.defaultSearch = true
      }
    }

    // 外键和多对多字段可搜索
    if (['ForeignKey', 'OneToOneField', 'ManyToManyField'].includes(fieldType)) {
      config.searchable = true
      config.searchType = 'select' // 关系字段使用选择搜索
      if (config.key === 'department' || config.key === 'category' || config.key === 'user') {
        config.defaultSearch = true
      }
    }
  }

  /**
   * 生成前端字段配置
   * @param {string} modelCode - Django模型代码
   * @returns {Object} 前端配置对象
   */
  generateFrontendConfig(modelCode) {
    const modelInfo = this.parseModel(modelCode)
    
    // 优先使用db_table作为模块标识，如果没有则使用模型名称的小写
    let moduleKey = modelInfo.tableName || modelInfo.modelName.toLowerCase()
    
    // 模块名称优先使用db_table，如果没有则使用verbose_name或模型名
    let moduleName = modelInfo.tableName || modelInfo.verboseName || modelInfo.modelName
    
    // 如果表名以sys_开头，则去掉sys_前缀
    if (moduleKey && moduleKey.startsWith('sys_')) {
      moduleKey = moduleKey.substring(4) // 去掉'sys_'前缀
    }
    
    if (moduleName && moduleName.startsWith('sys_')) {
      moduleName = moduleName.substring(4) // 去掉'sys_'前缀
    }
    
    return {
      moduleName: moduleName,
      moduleKey: moduleKey,
      description: `${moduleName}管理模块`,
      fields: modelInfo.fields,
      options: {
        enableSearch: true,
        enablePagination: true,
        enableExport: true,
        enableAdd: true,
        enableEdit: true,
        enableDelete: true
      }
    }
  }
}

export default DjangoModelParser