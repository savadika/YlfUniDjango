/**
 * 字段配置数据结构定义和验证规则
 * 为代码生成器提供标准化的字段配置格式
 */

/**
 * 字段配置类
 */
class FieldConfig {
  constructor(config) {
    this.validateConfig(config)
    Object.assign(this, this.getDefaultConfig(), config)
  }

  /**
   * 获取默认配置
   */
  getDefaultConfig() {
    return {
      key: '',              // 字段标识（英文）
      label: '',            // 字段显示名称（中文）
      type: 'string',       // 字段类型
      required: false,      // 是否必填
      searchable: false,    // 是否可搜索
      defaultSearch: false, // 是否默认搜索字段
      showInTable: true,    // 是否在表格中显示
      showInForm: true,     // 是否在表单中显示
      width: 120,           // 表格列宽
      placeholder: '',      // 输入框占位符
      defaultValue: null,   // 默认值
      options: [],          // 选择框选项（仅select类型）
      activeText: '是',     // switch激活状态文本
      inactiveText: '否',   // switch非激活状态文本
      activeValue: 1,       // switch激活状态值
      inactiveValue: 0,     // switch非激活状态值
      validator: null,      // 自定义验证规则
      props: {}             // 组件额外属性
    }
  }

  /**
   * 验证配置
   */
  validateConfig(config) {
    if (!config || typeof config !== 'object') {
      throw new Error('字段配置必须是一个对象')
    }

    if (!config.key || typeof config.key !== 'string') {
      throw new Error('字段key是必需的，且必须是字符串')
    }

    if (!config.label || typeof config.label !== 'string') {
      throw new Error('字段label是必需的，且必须是字符串')
    }

    if (config.type && !FieldConfig.SUPPORTED_TYPES.includes(config.type)) {
      throw new Error(`不支持的字段类型: ${config.type}。支持的类型: ${FieldConfig.SUPPORTED_TYPES.join(', ')}`)
    }

    // 对于select类型字段，检查是否需要options数组
    // 外键字段（hasStaticOptions为false或needsApiOptions为true）不需要静态options
    if (config.type === 'select' && 
        config.hasStaticOptions !== false && 
        !config.needsApiOptions && 
        (!config.options || !Array.isArray(config.options))) {
      throw new Error('select类型字段必须提供options数组')
    }

    if (config.options && Array.isArray(config.options)) {
      config.options.forEach((option, index) => {
        if (!option || typeof option !== 'object' || !option.label || option.value === undefined) {
          throw new Error(`options[${index}]必须包含label和value属性`)
        }
      })
    }
  }

  /**
   * 支持的字段类型
   */
  static SUPPORTED_TYPES = [
    'string',      // 文本输入
    'number',      // 数字输入
    'email',       // 邮箱输入
    'select',      // 下拉选择
    'multiselect', // 多选下拉
    'switch',      // 开关
    'boolean',     // 布尔值
    'date',        // 日期选择
    'datetime',    // 日期时间选择
    'time',        // 时间选择
    'daterange',   // 日期范围
    'textarea',    // 多行文本
    'file',        // 文件上传
    'image',       // 图片上传
    'url',         // URL输入
    'radio',       // 单选按钮
    'checkbox',    // 多选框
    'foreignkey'   // 外键字段
  ]

  /**
   * 字段类型描述
   */
  static TYPE_DESCRIPTIONS = {
    string: '文本输入框',
    number: '数字输入框',
    email: '邮箱输入框',
    select: '下拉选择框',
    multiselect: '多选下拉框',
    switch: '开关切换',
    boolean: '布尔值',
    date: '日期选择器',
    datetime: '日期时间选择器',
    time: '时间选择器',
    daterange: '日期范围选择器',
    textarea: '多行文本输入框',
    file: '文件上传',
    image: '图片上传',
    url: 'URL输入框',
    radio: '单选按钮组',
    checkbox: '多选框组',
    foreignkey: '外键关联字段'
  }

  /**
   * 创建字段配置
   */
  static create(config) {
    return new FieldConfig(config)
  }

  /**
   * 批量创建字段配置
   */
  static createBatch(configs) {
    if (!Array.isArray(configs)) {
      throw new Error('configs必须是数组')
    }
    return configs.map(config => new FieldConfig(config))
  }

  /**
   * 验证模块配置
   */
  static validateModuleConfig(moduleConfig) {
    if (!moduleConfig || typeof moduleConfig !== 'object') {
      throw new Error('模块配置必须是一个对象')
    }

    const { moduleName, moduleKey, fields } = moduleConfig

    if (!moduleName || typeof moduleName !== 'string') {
      throw new Error('moduleName是必需的，且必须是字符串')
    }

    if (!moduleKey || typeof moduleKey !== 'string') {
      throw new Error('moduleKey是必需的，且必须是字符串')
    }

    if (!/^[a-zA-Z][a-zA-Z0-9]*$/.test(moduleKey)) {
      throw new Error('moduleKey必须是有效的标识符（字母开头，只包含字母和数字）')
    }

    if (!fields || !Array.isArray(fields) || fields.length === 0) {
      throw new Error('fields是必需的，且必须是非空数组')
    }

    // 验证字段配置
    fields.forEach((field, index) => {
      try {
        new FieldConfig(field)
      } catch (error) {
        throw new Error(`字段配置[${index}]错误: ${error.message}`)
      }
    })

    // 检查字段key的唯一性
    const keys = fields.map(f => f.key)
    const duplicateKeys = keys.filter((key, index) => keys.indexOf(key) !== index)
    if (duplicateKeys.length > 0) {
      throw new Error(`字段key重复: ${duplicateKeys.join(', ')}`)
    }

    // 检查必须有id字段
    if (!fields.some(f => f.key === 'id')) {
      throw new Error('必须包含id字段')
    }

    return true
  }
}

/**
 * 预定义的常用字段配置
 */
const CommonFields = {
  // ID字段（必需）
  id: {
    key: 'id',
    label: 'ID',
    type: 'number',
    required: false,
    searchable: false, // ID字段默认不可搜索
    defaultSearch: false,
    showInTable: true,
    showInForm: true, // ID字段默认在表单中显示
    width: 80
  },

  // 名称字段
  name: {
    key: 'name',
    label: '名称',
    type: 'string',
    required: true,
    searchable: true,
    defaultSearch: true,
    showInTable: true,
    showInForm: true,
    width: 120,
    placeholder: '请输入名称'
  },

  // 状态字段
  status: {
    key: 'status',
    label: '状态',
    type: 'switch',
    required: false,
    searchable: true,
    defaultSearch: true,
    showInTable: true,
    showInForm: true,
    width: 80,
    activeText: '正常',
    inactiveText: '停用',
    activeValue: 1,
    inactiveValue: 0,
    defaultValue: 0
  },

  // 备注字段
  remark: {
    key: 'remark',
    label: '备注',
    type: 'textarea',
    required: false,
    searchable: true,
    defaultSearch: true,
    showInTable: true,
    showInForm: true,
    width: 150,
    placeholder: '请输入备注'
  },

  // 创建时间字段
  createTime: {
    key: 'create_time',
    label: '创建时间',
    type: 'date',
    required: false,
    searchable: true,
    defaultSearch: false, // 时间字段默认不搜索，让用户手动选择
    showInTable: true,
    showInForm: true,
    width: 140
  },

  // 更新时间字段
  updateTime: {
    key: 'update_time',
    label: '更新时间',
    type: 'date',
    required: false,
    searchable: true,
    defaultSearch: false, // 时间字段默认不搜索，让用户手动选择
    showInTable: true,
    showInForm: true,
    width: 140
  },

  // 排序字段
  sort: {
    key: 'sort',
    label: '排序',
    type: 'number',
    required: false,
    searchable: false,
    showInTable: true,
    showInForm: true,
    width: 80,
    placeholder: '请输入排序值',
    defaultValue: 0
  }
}

/**
 * 预定义的模块配置模板
 */
const ModuleTemplates = {
  // 基础管理模块
  basic: {
    fields: [
      CommonFields.id,
      CommonFields.name,
      CommonFields.status,
      CommonFields.remark,
      CommonFields.createTime,
      CommonFields.updateTime
    ],
    options: {
      enableSearch: true,
      enableExport: true,
      enablePagination: true,
      pageSize: 10
    }
  },

  // 带排序的管理模块
  withSort: {
    fields: [
      CommonFields.id,
      CommonFields.name,
      CommonFields.status,
      CommonFields.sort,
      CommonFields.remark,
      CommonFields.createTime,
      CommonFields.updateTime
    ],
    options: {
      enableSearch: true,
      enableExport: true,
      enablePagination: true,
      pageSize: 10
    }
  }
}

/**
 * 配置构建器
 */
class ConfigBuilder {
  constructor() {
    this.config = {
      moduleName: '',
      moduleKey: '',
      fields: [],
      options: {
        enableSearch: true,
        enableExport: true,
        enablePagination: true,
        pageSize: 10
      }
    }
  }

  /**
   * 设置模块信息
   */
  setModule(moduleName, moduleKey) {
    this.config.moduleName = moduleName
    this.config.moduleKey = moduleKey
    return this
  }

  /**
   * 添加字段
   */
  addField(fieldConfig) {
    this.config.fields.push(new FieldConfig(fieldConfig))
    return this
  }

  /**
   * 批量添加字段
   */
  addFields(fieldConfigs) {
    fieldConfigs.forEach(config => this.addField(config))
    return this
  }

  /**
   * 使用模板
   */
  useTemplate(templateName) {
    const template = ModuleTemplates[templateName]
    if (!template) {
      throw new Error(`未找到模板: ${templateName}`)
    }
    this.config.fields = [...template.fields]
    this.config.options = { ...this.config.options, ...template.options }
    return this
  }

  /**
   * 设置选项
   */
  setOptions(options) {
    this.config.options = { ...this.config.options, ...options }
    return this
  }

  /**
   * 构建配置
   */
  build() {
    FieldConfig.validateModuleConfig(this.config)
    return { ...this.config }
  }

  /**
   * 重置构建器
   */
  reset() {
    this.config = {
      moduleName: '',
      moduleKey: '',
      fields: [],
      options: {
        enableSearch: true,
        enableExport: true,
        enablePagination: true,
        pageSize: 10
      }
    }
    return this
  }
}

export {
  FieldConfig,
  CommonFields,
  ModuleTemplates,
  ConfigBuilder
}

export default FieldConfig