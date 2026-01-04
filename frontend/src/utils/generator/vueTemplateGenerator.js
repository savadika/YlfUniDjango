/**
 * Vue组件模板生成器
 * 基于字段配置生成标准的CRUD页面组件
 */

class VueTemplateGenerator {
  constructor(config) {
    // 兼容旧的调用方式和新的config对象方式
    if (typeof config === 'object' && config.fields && config.moduleKey) {
      // 新的config对象方式
      this.fields = config.fields
      this.moduleKey = config.moduleKey
      this.moduleName = config.moduleName
      this.options = {
        enablePagination: true,
        enableExport: true,
        enableBatchDelete: true,
        ...config.options
      }
    } else {
      // 兼容旧的调用方式 (fields, moduleKey, options)
      this.fields = arguments[0]
      this.moduleKey = arguments[1]
      this.options = {
        enablePagination: true,
        enableExport: true,
        enableBatchDelete: true,
        ...arguments[2]
      }
    }
  }

  /**
   * 生成完整的Vue组件
   */
  generate() {
    const template = this.generateTemplate()
    const script = this.generateScript()
    const style = this.generateStyle()

    return `<template>
${template}
</template>

<script>
${script}
</script>

<style scoped>
${style}
</style>`
  }

  /**
   * 生成模板部分
   */
  generateTemplate() {
    const searchSection = this.generateSearchSection()
    const tableSection = this.generateTableSection()
    const paginationSection = this.options.enablePagination ? this.generatePaginationSection() : ''
    const dialogSection = this.generateDialogSection()

    return `  <div class="app-container">
    <!-- 页面标题 -->
    <div class="page-header">
      <h2>${this.getModuleTitle()}</h2>
    </div>

${searchSection}

${tableSection}

${paginationSection}

${dialogSection}
  </div>`
  }

  /**
   * 获取模块标题
   */
  getModuleTitle() {
    const titleMap = {
      user: '用户管理',
      role: '角色管理',
      menu: '菜单管理',
      department: '部门管理'
    }
    return titleMap[this.moduleKey] || this.toPascalCase(this.moduleKey) + '管理'
  }

  /**
   * 生成搜索区域
   */
  generateSearchSection() {
    const searchFields = this.fields.filter(field => field.searchable)
    if (searchFields.length === 0) return ''

    // 将搜索字段分为 非时间 和 时间 两类，时间字段单独占一行
    const timeTypes = ['date', 'datetime', 'daterange']
    const timeFields = searchFields.filter(field => timeTypes.includes(field.type))
    const nonTimeFields = searchFields.filter(field => !timeTypes.includes(field.type))

    const nonTimeItems = nonTimeFields.map(field => this.generateSearchFormItem(field)).join('\n')
    const timeItems = timeFields.map(field => this.generateSearchFormItem(field)).join('\n')

    return `    <!-- 搜索区域 -->
    <div class="search-container">
      <el-card class="search-card">
        <div slot="header" class="search-header">
          <span class="search-title">
            <i class="el-icon-search"></i>
            搜索条件
          </span>
          <div class="search-actions">
            <el-button type="text" class="expand-btn" @click="toggleSearchExpand">
              {{ searchExpanded ? '收起' : '展开' }}
              <i :class="searchExpanded ? 'el-icon-arrow-up' : 'el-icon-arrow-down'"></i>
            </el-button>
          </div>
        </div>
        
        <div class="search-content" v-show="searchExpanded">
          <!-- 搜索字段选择器 -->
          <div class="field-selector">
            <span class="selector-label">搜索字段：</span>
            <div class="field-checkboxes">
              <el-checkbox-group v-model="searchFields">
${searchFields.map(field => `                <el-checkbox label="${field.key}">${field.label}</el-checkbox>`).join('\n')}
              </el-checkbox-group>
            </div>
          </div>
          
          <!-- 动态搜索表单 -->
          <div class="dynamic-search-form" v-if="searchFields.length > 0">
            <el-form :model="searchForm" class="search-form" label-width="100px" label-position="right" size="small">
              <el-row :gutter="16">
${nonTimeItems}
              </el-row>
${timeFields.length > 0 ? `              <el-row :gutter="16" class="time-search-row">
${timeItems}
              </el-row>` : ''}
            </el-form>
          </div>
          
          <!-- 搜索按钮 -->
          <div class="search-buttons">
            <el-button type="primary" icon="el-icon-search" @click="handleSearch" size="small">搜索</el-button>
            <el-button icon="el-icon-refresh" @click="handleResetSearch" size="small">重置</el-button>
          </div>
        </div>
      </el-card>
    </div>`
  }

  /**
   * 生成搜索表单项
   */
  generateSearchFormItem(field) {
    // 统一每列占比，保证对齐
    const span = 8
     let formItem = `                <el-col :span="${span}" v-if="searchFields.includes('${field.key}')">
                   <el-form-item label="${field.label}" prop="${field.key}">
`
     switch (field.type) {
       case 'string':
         formItem += `                    <el-input v-model="searchForm.${field.key}" placeholder="请输入${field.label}" clearable size="small" style="width: 100%" />
`
         break
       case 'email':
         formItem += `                    <el-input v-model="searchForm.${field.key}" type="email" placeholder="请输入${field.label}" clearable size="small" style="width: 100%" />
`
         break
       case 'number':
         formItem += `                    <el-input-number v-model="searchForm.${field.key}" placeholder="请输入${field.label}" style="width: 100%" size="small" />\n`
         break
       case 'select':
         formItem += `                    <el-select v-model="searchForm.${field.key}" placeholder="请选择${field.label}" clearable filterable style="width: 100%" size="small">\n`
        // 默认增加"全部"选项
        formItem += `                      <el-option label="全部" value="" />\n`
         if (field.options && field.options.length > 0) {
           field.options.forEach(option => {
             formItem += `                      <el-option label="${option.label}" value="${option.value}" />\n`
           })
         }
         formItem += `                    </el-select>\n`
         break
       case 'foreignkey':
         // 外键字段在搜索中生成下拉选择框
         const searchModuleKey = (() => {
           let mk = (field.relatedModel || field.key || '').toLowerCase()
           if (field.apiModule) {
             mk = String(field.apiModule).toLowerCase()
           } else if (field.optionConfig && field.optionConfig.apiConfig && field.optionConfig.apiConfig.url) {
             const url = String(field.optionConfig.apiConfig.url).trim()
             const match = url.match(/^\/?api\/(\w+)\/(\w+)$/i) || url.match(/^\/?(\w+)\/(\w+)$/i) || []
             mk = (match[1] || mk).toLowerCase()
           } else if (field.apiUrl) {
             const url = String(field.apiUrl).trim()
             const match = url.match(/^\/?api\/(\w+)\/(\w+)$/i) || url.match(/^\/?(\w+)\/(\w+)$/i) || []
             mk = (match[1] || mk).toLowerCase()
           }
           return mk
         })()
         formItem += `                    <el-select v-model="searchForm.${field.key}" placeholder="请选择${field.label}" clearable filterable style="width: 100%" size="small">\n`
         formItem += `                      <el-option label="全部" value="" />\n`
         formItem += `                      <el-option\n`
         formItem += `                        v-for="item in ${searchModuleKey}Options"\n`
         formItem += `                        :key="item.id"\n`
         formItem += `                        :label="item.${field.displayFieldCallback || 'name'}"\n`
         formItem += `                        :value="item.id"\n`
         formItem += `                      />\n`
         formItem += `                    </el-select>\n`
         break
       case 'date':
        // 搜索使用日期范围
        formItem += `                    <el-date-picker v-model="searchForm.${field.key}" type="daterange" range-separator="至" start-placeholder="开始日期" end-placeholder="结束日期" style="width: 100%" value-format="yyyy-MM-dd" clearable unlink-panels size="small" />\n`
         break
       case 'daterange':
         formItem += `                    <el-date-picker v-model="searchForm.${field.key}" type="daterange" range-separator="至" start-placeholder="开始日期" end-placeholder="结束日期" style="width: 100%" value-format="yyyy-MM-dd" clearable unlink-panels size="small" />\n`
         break
       case 'datetime':
        // 搜索使用日期时间范围
        formItem += `                    <el-date-picker v-model="searchForm.${field.key}" type="datetimerange" range-separator="至" start-placeholder="开始时间" end-placeholder="结束时间" style="width: 100%" value-format="yyyy-MM-dd HH:mm:ss" clearable unlink-panels size="small" />\n`
         break
       default:
         formItem += `                    <el-input v-model="searchForm.${field.key}" placeholder="请输入${field.label}" clearable size="small" style="width: 100%" />\n`
     }
     formItem += `                  </el-form-item>\n                </el-col>`
     return formItem
   }

  /**
   * 生成表格区域
   */
  generateTableSection() {
    const tableColumns = this.fields.filter(field => field.showInTable)
    const operationButtons = this.generateOperationButtons()
    const tableColumnsHtml = tableColumns.map(field => {
      return this.generateTableColumn(field)
    }).join('\n')

    return `    <!-- 操作按钮 -->
    <div class="operation-buttons">
      <el-button type="primary" icon="el-icon-plus" @click="handleCreate">新增</el-button>
${this.options.enableBatchDelete ? '      <el-button type="danger" icon="el-icon-delete" @click="handleBatchDelete" :disabled="multipleSelection.length === 0">批量删除</el-button>' : ''}
${this.options.enableExport ? '      <export-button :api-function="export' + this.toPascalCase(this.moduleKey) + 'List" :search-params="searchParams" :export-options="getExportOptions()" @export-success="onExportSuccess" @export-error="onExportError" />' : ''}
    </div>

    <!-- 数据表格 -->
    <el-table
      ref="multipleTable"
      :data="tableData"
      v-loading="loading"
      border
      stripe
      row-key="id"
      @selection-change="handleSelectionChange"
    >
${this.options.enableBatchDelete ? '      <el-table-column type="selection" width="55" align="center" />' : ''}
${tableColumnsHtml}
      <el-table-column label="操作" width="180" align="center" fixed="right">
        <template slot-scope="{ row }">
          <el-button type="text" size="small" @click="handleEdit(row)">编辑</el-button>
          <el-button type="text" size="small" style="color: #f56c6c" @click="handleDelete(row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>`
  }

  /**
   * 生成表格列
   */
  generateTableColumn(field) {
    let column = `      <el-table-column prop="${field.key}" label="${field.label}" align="center"`
    
    if (field.width) {
      column += ` width="${field.width}"`
    }
    
    if (field.type === 'select' && field.options) {
      column += `>
        <template slot-scope="{ row }">
          {{ getOptionLabel('${field.key}', row.${field.key}, row) }}
        </template>
      </el-table-column>`
    } else if (field.needsApiOptions || field.isForeignKey) {
      // 外键字段显示名称而不是ID
      column += `>
        <template slot-scope="{ row }">
          {{ getOptionLabel('${field.key}', row.${field.key}, row) }}
        </template>
      </el-table-column>`
    } else if (field.type === 'switch') {
      column += `>
        <template slot-scope="{ row }">
          <el-tag :type="row.${field.key} ? 'success' : 'danger'">
            {{ row.${field.key} ? '${field.activeText || '是'}' : '${field.inactiveText || '否'}' }}
          </el-tag>
        </template>
      </el-table-column>`
    } else {
      column += ` />`
    }
    
    return column
  }

  /**
   * 生成操作按钮
   */
  generateOperationButtons() {
    let buttons = '      <el-button type="primary" icon="el-icon-plus" @click="handleCreate">新增</el-button>\n'
    
    if (this.options.enableBatchDelete) {
      buttons += '      <el-button type="danger" icon="el-icon-delete" @click="handleBatchDelete" :disabled="multipleSelection.length === 0">批量删除</el-button>\n'
    }
    
    if (this.options.enableExport) {
      buttons += `      <export-button 
        :api-function="export${this.toPascalCase(this.moduleKey)}List" 
        :search-params="searchParams" 
        :export-options="getExportOptions()"
        @export-success="onExportSuccess" 
        @export-error="onExportError" 
      />\n`
    }
    
    return buttons
  }

  /**
   * 生成分页区域
   */
  generatePaginationSection() {
    return `      <!-- 分页 -->
      <div class="pagination-container" v-if="pagination.total > 0">
        <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="pagination.currentPage"
          :page-sizes="pagination.pageSizeOptions.map(size => parseInt(size))"
          :page-size="pagination.pageSize"
          :total="pagination.total"
          :layout="'total, sizes, prev, pager, next, jumper'"
          :show-total="pagination.showTotal"
          :show-size-changer="pagination.showSizeChanger"
          :show-quick-jumper="pagination.showQuickJumper"
          background
        >
        </el-pagination>
      </div>`
  }

  /**
   * 生成对话框区域
   */
  generateDialogSection() {
    const formFields = this.fields.filter(field => field.showInForm && field.key !== 'id')
    
    let dialogSection = `    <!-- 新增/编辑对话框 -->
    <el-dialog
      :title="dialogTitle"
      :visible.sync="dialogVisible"
      width="600px"
      @close="handleDialogClose"
    >
      <el-form
        :model="form"
        :rules="rules"
        ref="form"
        label-width="100px"
      >
`

    formFields.forEach(field => {
      dialogSection += this.generateFormItem(field)
    })

    dialogSection += `      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleSubmit" :loading="submitLoading">确定</el-button>
      </div>
    </el-dialog>`

    return dialogSection
  }

  /**
   * 生成表单项
   */
  generateFormItem(field) {
    let formItem = `        <el-form-item label="${field.label}" prop="${field.key}">
`
    
    switch (field.type) {
      case 'string':
        formItem += `          <el-input v-model="form.${field.key}" placeholder="${field.placeholder || '请输入' + field.label}" />
`
        break
      case 'email':
        formItem += `          <el-input v-model="form.${field.key}" type="email" placeholder="${field.placeholder || '请输入' + field.label}" />
`
        break
      case 'number':
        formItem += `          <el-input-number v-model="form.${field.key}" placeholder="${field.placeholder || '请输入' + field.label}" style="width: 100%" />
`
        break
      case 'textarea':
        formItem += `          <el-input v-model="form.${field.key}" type="textarea" :rows="3" placeholder="${field.placeholder || '请输入' + field.label}" />
`
        break
      case 'select':
        formItem += `          <el-select v-model="form.${field.key}" placeholder="${field.placeholder || '请选择' + field.label}" style="width: 100%">\n`
        if (field.options && field.options.length > 0) {
          field.options.forEach(option => {
            formItem += `            <el-option label="${option.label}" value="${option.value}" />\n`
          })
        }
        formItem += `          </el-select>\n`
        break
      case 'foreignkey':
        // 外键字段生成下拉选择框（支持显示回调，通过 getOptionLabel 统一处理）
        const modelKeyForForm = (() => {
          let mk = (field.relatedModel || field.key || '').toLowerCase()
          if (field.apiModule) {
            mk = String(field.apiModule).toLowerCase()
          } else if (field.optionConfig && field.optionConfig.apiConfig && field.optionConfig.apiConfig.url) {
            const url = String(field.optionConfig.apiConfig.url).trim()
            const match = url.match(/^\/?api\/(\w+)\/(\w+)$/i) || url.match(/^\/?(\w+)\/(\w+)$/i) || []
            mk = (match[1] || mk).toLowerCase()
          } else if (field.apiUrl) {
            const url = String(field.apiUrl).trim()
            const match = url.match(/^\/?api\/(\w+)\/(\w+)$/i) || url.match(/^\/?(\w+)\/(\w+)$/i) || []
            mk = (match[1] || mk).toLowerCase()
          }
          return mk
        })()
        formItem += `          <el-select v-model="form.${field.key}" placeholder="${field.placeholder || '请选择' + field.label}" style="width: 100%">\n`
        formItem += `            <el-option\n`
        formItem += `              v-for="item in ${modelKeyForForm}Options"\n`
        formItem += `              :key="item.id"\n`
        formItem += `              :label="item.${field.displayFieldCallback || 'name'}"\n`
        formItem += `              :value="item.id"\n`
        formItem += `            />\n`
        formItem += `          </el-select>\n`
        break
      case 'switch':
        formItem += `          <el-switch\n            v-model="form.${field.key}"\n            :active-text="'${field.activeText}'"\n            :inactive-text="'${field.inactiveText}'"\n            :active-value="${field.activeValue}"\n            :inactive-value="${field.inactiveValue}"\n          />\n`
        break
      case 'date':
        formItem += `          <el-date-picker v-model="form.${field.key}" type="date" placeholder="${field.placeholder || '请选择' + field.label}" style="width: 100%" value-format="yyyy-MM-dd" />
`
        break
      case 'daterange':
        formItem += `          <el-date-picker v-model="form.${field.key}" type="datetimerange" start-placeholder="开始日期时间" end-placeholder="结束日期时间" style="width: 100%" value-format="yyyy-MM-dd HH:mm:ss" />
`
        break
      case 'datetime':
        formItem += `          <el-date-picker v-model="form.${field.key}" type="datetime" placeholder="${field.placeholder || '请选择' + field.label}" style="width: 100%" value-format="yyyy-MM-dd HH:mm:ss" />
`
        break
      default:
        formItem += `          <el-input v-model="form.${field.key}" placeholder="${field.placeholder || '请输入' + field.label}" />\n`
    }
    
    formItem += `        </el-form-item>\n`
    return formItem
  }

  /**
   * 生成脚本部分
   */
  generateScript() {
    const imports = this.generateImports()
    const data = this.generateData()
    const computed = this.generateComputed()
    const methods = this.generateMethods()
    const mounted = this.generateMounted()

    return `${imports}

export default {
  name: '${this.toPascalCase(this.moduleKey)}',
  mixins: [exportMixin],
  components: {
${this.options.enableExport ? '    ExportButton' : ''}
  },
  data() {
    return {
${data}
    }
  },
${computed}
  mounted() {
${mounted}
  },
  methods: {
${methods}
  }
}`
  }

  /**
   * 生成导入语句
   */
  generateImports() {
    let imports = `import { get${this.toPascalCase(this.moduleKey)}List, create${this.toPascalCase(this.moduleKey)}, update${this.toPascalCase(this.moduleKey)}, delete${this.toPascalCase(this.moduleKey)} } from '@/api/${this.moduleKey}'`
    
    // 添加外键字段的API导入（基于字段配置的 apiConfig.url 或 apiUrl 解析）
    // 格式示例：/api/department/getDepartmentOptions -> 模块: department 方法: getDepartmentOptions
    const foreignKeyFields = this.fields.filter(f => f.needsApiOptions || f.isForeignKey || f.type === 'foreignkey')
    const fkImportSet = new Set()
    foreignKeyFields.forEach(field => {
      let moduleKey = (field.relatedModel || field.key || '').toLowerCase()
      let methodName = `get${this.toPascalCase(moduleKey)}Options`
      if (field.apiModule && field.apiMethod) {
        moduleKey = (field.apiModule || moduleKey).toLowerCase()
        methodName = field.apiMethod
      } else if (field.optionConfig && field.optionConfig.apiConfig && field.optionConfig.apiConfig.url) {
        const url = String(field.optionConfig.apiConfig.url).trim()
        const match = url.match(/^\/?api\/(\w+)\/(\w+)$/i) || url.match(/^\/?(\w+)\/(\w+)$/i) || []
        moduleKey = (match[1] || moduleKey).toLowerCase()
        methodName = match[2] || `get${this.toPascalCase(moduleKey)}Options`
      } else if (field.apiUrl) {
        const url = String(field.apiUrl).trim()
        const match = url.match(/^\/?api\/(\w+)\/(\w+)$/i) || url.match(/^\/?(\w+)\/(\w+)$/i) || []
        moduleKey = (match[1] || moduleKey).toLowerCase()
        methodName = match[2] || `get${this.toPascalCase(moduleKey)}Options`
      }
      if (moduleKey) {
        fkImportSet.add(`import { ${methodName} } from '@/api/${moduleKey}'`)
      }
    })
    imports += fkImportSet.size ? `\n${Array.from(fkImportSet).join('\n')}` : ''

    // 为API选项字段添加API导入（支持用户填写的apiModule/apiMethod或从URL解析）
    const apiOptionFields = this.fields.filter(f => f.optionConfig && f.optionConfig.source === 'api')
    const apiImportSet = new Set()
    let needRequestImport = false
    apiOptionFields.forEach(field => {
      const apiConfig = field.optionConfig?.apiConfig || {}
      let moduleKey = String(apiConfig.apiModule || '').toLowerCase()
      let methodName = String(apiConfig.apiMethod || '')
      if (!moduleKey || !methodName) {
        const url = String(apiConfig.url || '').trim()
        if (url) {
          const match = url.match(/^\/?api\/(\w+)\/(\w+)$/i) || url.match(/^\/?(\w+)\/(\w+)$/i) || []
          moduleKey = moduleKey || (match[1] || '').toLowerCase()
          methodName = methodName || (match[2] || '')
          if (!methodName) {
            // 需要fallback到直接请求
            needRequestImport = true
          }
        }
      }
      if (moduleKey && methodName) {
        apiImportSet.add(`import { ${methodName} } from '@/api/${moduleKey}'`)
      }
    })
    imports += apiImportSet.size ? `\n${Array.from(apiImportSet).join('\n')}` : ''
    if (needRequestImport) {
      imports += `\nimport request from '@/utils/request'`
    }
    
    // 添加导出功能相关的导入
    imports += `\nimport exportMixin from '@/utils/exportMixin'`
    
    if (this.options.enableExport) {
      imports += `\nimport ExportButton from '@/components/ExportButton'\n`
    }
    
    return imports
  }

  /**
   * 生成data数据
   */
  generateData() {
    const searchFields = this.fields.filter(field => field.searchable)
    const formFields = this.fields.filter(field => field.showInForm)
    const selectFields = this.fields.filter(field => field.type === 'select' && field.options)
    
    // 计算默认搜索字段
    const defaultSearchFields = (() => {
      const defaults = searchFields.filter(field => field.defaultSearch).map(field => field.key)
      return defaults.length > 0 ? defaults : searchFields.slice(0, 3).map(field => field.key)
    })()
    
    let data = `      // 表格数据
      tableData: [],
      loading: false,
      multipleSelection: [],

      // 搜索相关
      searchForm: {`
    
    searchFields.forEach(field => {
      // 时间类搜索字段默认使用区间（空数组表示未选择）
      let defaultValueCode
      if (field.defaultValue !== null && field.defaultValue !== undefined) {
        defaultValueCode = JSON.stringify(field.defaultValue)
      } else if (['date','datetime','daterange'].includes(field.type)) {
        defaultValueCode = '[]'
      } else if (field.type === 'number') {
        defaultValueCode = 'null'
      } else {
        defaultValueCode = "''"
      }
      data += `\n        ${field.key}: ${defaultValueCode},\n`
    })
    
    data += `
      },
      searchParams: {},
      searchFields: [], // 当前选中的搜索字段，将在 mounted 中初始化
      defaultSearchFields: ${JSON.stringify(defaultSearchFields)}, // 默认搜索字段常量
      searchExpanded: false, // 搜索区域展开状态`
    
    if (this.options.enablePagination) {
      data += `,

      // 分页相关
      pagination: {
        currentPage: 1,
        pageSize: 5,
        total: 0,
        pageSizeOptions: ['5', '10', '20', '50', '100'],
        showTotal: true,
        showSizeChanger: true,
        showQuickJumper: true
      }`
    }
    
    data += `,

      // 对话框相关
      dialogVisible: false,
      dialogType: 'add', // add | edit
      submitLoading: false,
      form: {${this.generateFormFieldsInit()}
      },
      rules: {`
    
    // 生成表单验证规则
    const requiredFields = formFields.filter(field => field.required)
    requiredFields.forEach(field => {
      data += `\n        ${field.key}: [{ required: true, message: '请输入${field.label}', trigger: 'blur' }],\n`
    })
    
    data += `\n      }`
    
    // 生成选择框选项数据
    if (selectFields.length > 0) {
      data += `,\n\n      // 选择框选项`
      selectFields.forEach(field => {
        data += `\n      ${field.key}Options: ${JSON.stringify(field.options || [])},\n`
      })
    }
    
    // 生成API选项字段数据
    const apiOptionFields = this.fields.filter(f => f.optionConfig && f.optionConfig.source === 'api')
    if (apiOptionFields.length > 0) {
      if (selectFields.length === 0) {
        data += `,\n\n      // API选项`
      } else {
        data += `\n\n      // API选项`
      }
      // 计算外键模块的moduleKey集合，用于与API选项字段重名时去重
      const fkModuleKeysForDedup = new Set()
      this.fields.filter(f => f.needsApiOptions || f.isForeignKey || f.type === 'foreignkey').forEach(field => {
        let mk = (field.relatedModel || field.key || '').toLowerCase()
        if (field.apiModule) {
          mk = String(field.apiModule).toLowerCase()
        } else if (field.optionConfig && field.optionConfig.apiConfig && field.optionConfig.apiConfig.url) {
          const url = String(field.optionConfig.apiConfig.url).trim()
          const match = url.match(/^\/?api\/(\w+)\/(\w+)$/i) || url.match(/^\/?(\w+)\/(\w+)$/i) || []
          mk = (match[1] || mk).toLowerCase()
        } else if (field.apiUrl) {
          const url = String(field.apiUrl).trim()
          const match = url.match(/^\/?api\/(\w+)\/(\w+)$/i) || url.match(/^\/?(\w+)\/(\w+)$/i) || []
          mk = (match[1] || mk).toLowerCase()
        }
        fkModuleKeysForDedup.add(mk)
      })
      apiOptionFields.forEach(field => {
        // 如果该字段名与外键模块名冲突，则跳过，避免重复定义同名Options
        if (!fkModuleKeysForDedup.has(String(field.key).toLowerCase())) {
          data += `\n      ${field.key}Options: [],\n`
        }
      })
    }
    
    // 生成外键字段选项数据
    const foreignKeyFields = this.fields.filter(f => f.needsApiOptions || f.isForeignKey || f.type === 'foreignkey')
    if (foreignKeyFields.length > 0) {
      if (selectFields.length === 0 && apiOptionFields.length === 0) {
        data += `,\n\n      // 外键选项`
      } else {
        data += `\n\n      // 外键选项`
      }
      // 使用Set去重，避免重复的选项定义
      const uniqueModuleKeys = new Set()
      foreignKeyFields.forEach(field => {
        // 统一使用 moduleKeyOptions 命名
        let mk = (field.relatedModel || field.key || '').toLowerCase()
        if (field.apiModule) {
          mk = String(field.apiModule).toLowerCase()
        } else if (field.optionConfig && field.optionConfig.apiConfig && field.optionConfig.apiConfig.url) {
          const url = String(field.optionConfig.apiConfig.url).trim()
          const match = url.match(/^\/?api\/(\w+)\/(\w+)$/i) || url.match(/^\/?(\w+)\/(\w+)$/i) || []
          mk = (match[1] || mk).toLowerCase()
        } else if (field.apiUrl) {
          const url = String(field.apiUrl).trim()
          const match = url.match(/^\/?api\/(\w+)\/(\w+)$/i) || url.match(/^\/?(\w+)\/(\w+)$/i) || []
          mk = (match[1] || mk).toLowerCase()
        }
        uniqueModuleKeys.add(mk)
      })
      uniqueModuleKeys.forEach(mk => {
        data += `\n      ${mk}Options: [],`
      })
    }
    
    return data
  }

  /**
   * 生成computed计算属性
   */
  generateComputed() {
    return `  computed: {
    dialogTitle() {
      return this.dialogType === 'add' ? '新增${this.getModuleTitle()}' : '编辑${this.getModuleTitle()}'
    }
  },`
  }

  /**
   * 生成表单字段初始化代码的辅助方法
   */
  generateFormFieldsInit() {
    const formFields = this.fields.filter(field => field.showInForm && field.key !== 'id')
    let fieldsInit = ''
    formFields.forEach(field => {
      if (field.key === 'status') return // 跳过status字段的初始化
      const defaultValue = field.defaultValue !== null ? field.defaultValue : (field.type === 'number' ? 'null' : "''")
      fieldsInit += `\n        ${field.key}: ${typeof defaultValue === 'string' ? "'" + defaultValue + "'" : defaultValue},`
    })
    return fieldsInit
  }

  /**
   * 生成methods方法
   */
  generateMethods() {
    // 计算默认搜索字段，用于重置时恢复初始选择
    const searchFields = this.fields.filter(field => field.searchable)
    const defaultSearchFields = (() => {
      const defaults = searchFields.filter(field => field.defaultSearch).map(field => field.key)
      return defaults.length > 0 ? defaults : searchFields.slice(0, 3).map(field => field.key)
    })()
    
    let methods = `    // 获取列表数据
    async getList() {
      try {
        this.loading = true
        const params = { ...this.searchParams }`
    
    if (this.options.enablePagination) {
      methods += `
        params.page = this.pagination.currentPage
        params.page_size = this.pagination.pageSize`
    }
    
    methods += `
        const response = await get${this.toPascalCase(this.moduleKey)}List(params)
        const rows = response.results || response.data?.results || response.data || response.list || []
        this.tableData = Array.isArray(rows) ? rows.map(row => this.normalizeRow(row)) : []`
    
    if (this.options.enablePagination) {
      methods += `
        this.pagination.total = response.count || response.data?.count || response.total || response.data?.total || 0`
    }
    
    methods += `
      } catch (error) {
        this.$message.error('获取数据失败')
      } finally {
        this.loading = false
      }
    },

    // 切换搜索展开状态
    toggleSearchExpand() {
      this.searchExpanded = !this.searchExpanded
    },

    // 获取搜索参数
    getSearchParams() {
      const params = {}
      
      // 只包含选中的搜索字段
      this.searchFields.forEach(fieldKey => {
        const value = this.searchForm[fieldKey]
        if (value !== '' && value !== null && value !== undefined) {
          if (Array.isArray(value)) {
            if (value.length === 2) {
              params[fieldKey + '_start'] = value[0]
              params[fieldKey + '_end'] = value[1]
            }
          } else {
            params[fieldKey] = value
          }
        }
      })
      
      return params
    },

    // 搜索
    handleSearch() {
      this.searchParams = this.getSearchParams()`
    
    if (this.options.enablePagination) {
      methods += `
      this.pagination.currentPage = 1`
    }
    
    methods += `
      this.getList()
    },

    // 获取导出列头配置
    getExportHeaders() {
      return {${this.generateExportHeaders()}
      }
    },

    // 重置搜索
    handleResetSearch() {
      // 重置搜索表单
      Object.keys(this.searchForm).forEach(key => {
        if (Array.isArray(this.searchForm[key])) {
          this.searchForm[key] = []
        } else {
          this.searchForm[key] = ''
        }
      })
      
      // 重置搜索参数
      this.searchParams = {}
      // 重置搜索字段到默认选择
      this.searchFields = [...this.defaultSearchFields]`
    
    if (this.options.enablePagination) {
      methods += `
      this.pagination.currentPage = 1`
    }
    
    methods += `
      this.getList()
    },`
    
    if (this.options.enableExport) {
      methods += `

    // 导出成功回调
    onExportSuccess() {
      this.$message.success('导出成功')
    },

    // 导出失败回调
    onExportError(error) {
      console.error('导出失败:', error)
      this.$message.error('导出失败')
    },`
    }
    
    methods += `

    // 新增
    handleCreate() {
      this.dialogType = 'add'
      this.form = {${this.generateFormFieldsInit()}
      }
      this.dialogVisible = true
    },\n\n    // 编辑\n    handleEdit(row) {\n      this.dialogType = 'edit'\n      this.form = { ...row }\n      this.dialogVisible = true\n    },\n\n    // 删除\n    async handleDelete(row) {\n      try {\n        await this.$confirm('确定要删除这条记录吗？', '提示', {\n          confirmButtonText: '确定',\n          cancelButtonText: '取消',\n          type: 'warning'\n        })\n        await delete${this.toPascalCase(this.moduleKey)}(row.id)\n        this.$message.success('删除成功')\n        this.getList()\n      } catch (error) {\n        if (error !== 'cancel') {\n          this.$message.error('删除失败')\n        }\n      }\n    },\n\n    // 批量删除\n    async handleBatchDelete() {\n      if (this.multipleSelection.length === 0) {\n        this.$message.warning('请选择要删除的记录')\n        return\n      }\n      try {\n        await this.$confirm('确定要删除选中的记录吗？', '提示', {\n          confirmButtonText: '确定',\n          cancelButtonText: '取消',\n          type: 'warning'\n        })\n        const ids = this.multipleSelection.map(item => item.id)\n        // 这里需要根据实际API调整批量删除逻辑\n        await Promise.all(ids.map(id => delete${this.toPascalCase(this.moduleKey)}(id)))\n        this.$message.success('删除成功')\n        this.getList()\n      } catch (error) {\n        if (error !== 'cancel') {\n          this.$message.error('删除失败')\n        }\n      }\n    },\n\n    // 提交表单\n    async handleSubmit() {\n      try {\n        await this.$refs.form.validate()\n        this.submitLoading = true\n        \n        const payload = this.transformPayload(this.form)\n        if (this.dialogType === 'add') {\n          await create${this.toPascalCase(this.moduleKey)}(payload)\n          this.$message.success('新增成功')\n        } else {\n          await update${this.toPascalCase(this.moduleKey)}(this.form.id, payload)\n          this.$message.success('更新成功')\n        }\n        \n        this.dialogVisible = false\n        this.getList()\n      } catch (error) {\n        this.$message.error(this.dialogType === 'add' ? '新增失败' : '更新失败')\n      } finally {\n        this.submitLoading = false\n      }\n    },\n\n    // 对话框关闭\n    handleDialogClose() {\n      this.$refs.form.resetFields()\n    },\n\n    // 表格选择变化\n    handleSelectionChange(selection) {
      this.multipleSelection = selection
    },

    // 归一化列表数据，处理 name 与 *_name 的别名映射
    normalizeRow(row) {
      if (!row || typeof row !== 'object') return row
      // 若没有 name，但存在 *_name，则补充 name
      if (row.name === undefined) {
        const aliasKey = Object.keys(row).find(k => /_name$/.test(k) && row[k] !== undefined)
        if (aliasKey) row.name = row[aliasKey]
      }
      // 若存在 name，而表单包含 *_name 字段但该字段缺失，则补充到别名字段，便于表格显示
      if (row.name !== undefined && this.form) {
        Object.keys(this.form).forEach(k => {
          if (k !== 'name' && /_name$/.test(k) && row[k] === undefined) {
            row[k] = row.name
          }
        })
      }
      return row
    },

    // 将表单数据转换为后端所需 payload（去除审计字段并处理 name 映射）
    transformPayload(form) {
      const payload = { ...form }
      // 清理空值，避免发送空字符串/空数组/undefined
      Object.keys(payload).forEach((k) => {
        const v = payload[k]
        if (v === '' || v === undefined || v === null) {
          delete payload[k]
        } else if (Array.isArray(v) && v.length === 0) {
          delete payload[k]
        }
      })
      return payload
    }`
    
    if (this.options.enablePagination) {
      methods += `,\n\n    // 分页大小变化\n    handleSizeChange(size) {\n      this.pagination.pageSize = size\n      this.pagination.currentPage = 1\n      this.getList()\n    },\n\n    // 当前页变化\n    handleCurrentChange(page) {\n      this.pagination.currentPage = page\n      this.getList()\n    }`
    }
    
    if (this.options.enableExport) {
      methods += `,

    // 导出数据获取方法
    export${this.toPascalCase(this.moduleKey)}List(params) {
      return get${this.toPascalCase(this.moduleKey)}List(params)
    },

    // 获取导出配置
    getExportOptions() {
      return {
        filename: '${this.moduleKey}_export',
        headers: {${this.fields.filter(f => f.exportable !== false).map(f => `
          ${f.key}: '${f.label}'`).join(',')}
        },
        sheetName: '${this.moduleKey}数据'
      }
    }`
    }
    
    // 生成外键选项加载方法
    const foreignKeyMethods = this.generateForeignKeyOptionsMethods()
    if (foreignKeyMethods) {
      methods += foreignKeyMethods
    }
    
    // 生成getOptionLabel方法，用于处理选择框选项的显示
    methods += this.generateGetOptionLabelMethod()
    
    // 结束 methods 生成并返回
    return methods
  }

  // 生成 mounted 钩子内容
  generateMounted() {
    // 计算默认搜索字段，用于初始化
    const searchFields = this.fields.filter(field => field.searchable)
    const defaultSearchFields = (() => {
      const defaults = searchFields.filter(field => field.defaultSearch).map(field => field.key)
      return defaults.length > 0 ? defaults : searchFields.slice(0, 3).map(field => field.key)
    })()
    
    let mounted = ''

    // 初始化搜索字段
    mounted += `\n    this.searchFields = [...this.defaultSearchFields]`
    
    // 初始挂载加载列表数据
    mounted += `\n    this.getList()`

    // 收集需要调用的选项加载方法（API 与 外键），使用 Set 去重
    const loadCalls = new Set()

    // API选项字段
    const apiOptionFields = this.fields.filter(f => f.optionConfig && f.optionConfig.source === 'api')
    if (apiOptionFields.length > 0) {
      // 预先计算可能由外键生成的 loadXxxOptions 方法名，用于冲突规避
      const fkFieldsForApiCheck = this.fields.filter(f => f.needsApiOptions || f.isForeignKey || f.type === 'foreignkey')
      const foreignKeyLoadNames = new Set()
      fkFieldsForApiCheck.forEach(field => {
        let moduleKey = (field.relatedModel || field.key || '').toLowerCase()
        if (field.apiModule) {
          moduleKey = String(field.apiModule).toLowerCase()
        } else if (field.optionConfig && field.optionConfig.apiConfig && field.optionConfig.apiConfig.url) {
          const url = String(field.optionConfig.apiConfig.url).trim()
          const match = url.match(/^\/?api\/(\w+)\/(\w+)$/i) || url.match(/^\/?(\w+)\/(\w+)$/i) || []
          moduleKey = (match[1] || moduleKey).toLowerCase()
        } else if (field.apiUrl) {
          const url = String(field.apiUrl).trim()
          const match = url.match(/^\/?api\/(\w+)\/(\w+)$/i) || url.match(/^\/?(\w+)\/(\w+)$/i) || []
          moduleKey = (match[1] || moduleKey).toLowerCase()
        }
        if (moduleKey) {
          foreignKeyLoadNames.add(`load${this.toPascalCase(moduleKey)}Options`)
        }
      })

      apiOptionFields.forEach(field => {
        const loadMethodNameOnly = `load${this.toPascalCase(field.key)}Options`
        if (foreignKeyLoadNames.has(loadMethodNameOnly)) return
        loadCalls.add(`if (typeof this.${loadMethodNameOnly} === 'function') this.${loadMethodNameOnly}()`)
      })
    }

    // 外键选项字段
    const foreignKeyFields = this.fields.filter(f => f.needsApiOptions || f.isForeignKey || f.type === 'foreignkey')
    if (foreignKeyFields.length > 0) {
      foreignKeyFields.forEach(field => {
        let moduleKey = (field.relatedModel || field.key || '').toLowerCase()
        if (field.apiModule) {
          moduleKey = String(field.apiModule).toLowerCase()
        } else if (field.optionConfig && field.optionConfig.apiConfig && field.optionConfig.apiConfig.url) {
          const url = String(field.optionConfig.apiConfig.url).trim()
          const match = url.match(/\/?api\/([^\/]+)(?:\/([^\/]+))?/i)
          if (match) {
            moduleKey = (match[1] || moduleKey).toLowerCase()
          }
        } else if (field.apiUrl) {
          const url = String(field.apiUrl).trim()
          const match = url.match(/\/?api\/([^\/]+)(?:\/([^\/]+))?/i)
          if (match) {
            moduleKey = (match[1] || moduleKey).toLowerCase()
          }
        }
        if (moduleKey) {
          loadCalls.add(`if (typeof this.load${this.toPascalCase(moduleKey)}Options === 'function') this.load${this.toPascalCase(moduleKey)}Options()`)
        }
      })
    }

    // 插入最终调用列表（天然去重）
    loadCalls.forEach(call => {
      mounted += `\n    ${call}`
    })

    return mounted
  }

  /**
   * 生成样式部分
   */
  generateStyle() {
    return `.app-container { padding: 20px; }
.page-header { margin-bottom: 20px; }
.page-header h2 { margin: 0; color: #303133; }
/* 搜索区域样式 */
.search-container { margin-bottom: 20px; }
.search-card { border: 1px solid #e4e7ed; }
.search-header { display: flex; justify-content: space-between; align-items: center; }
.search-title { font-size: 14px; font-weight: 500; color: #303133; }
.search-title i { margin-right: 5px; color: #409eff; }
.search-actions .expand-btn { padding: 0; font-size: 12px; }
.search-content { padding-top: 10px; }
.field-selector { margin-bottom: 15px; padding: 10px; background-color: #f5f7fa; border-radius: 4px; }
.selector-label { font-size: 13px; color: #606266; margin-right: 10px; }
.field-checkboxes { display: inline-block; }
.field-checkboxes .el-checkbox { margin-right: 15px; margin-bottom: 5px; }
.search-form { margin-bottom: 15px; }
/* 对齐与美观：固定标签宽度，内容占满 */
.search-form .el-form-item { display: flex; align-items: center; }
.search-form .el-form-item__label { width: 100px !important; text-align: right; padding-right: 8px; }
.search-form .el-form-item__content { flex: 1; }
/* 控件统一 100% 宽 */
.search-form .el-select, .search-form .el-input, .search-form .el-input-number, .search-form .el-date-editor { width: 100% !important; }
.search-buttons { text-align: center; padding-top: 10px; border-top: 1px solid #e4e7ed; }
.search-buttons .el-button { margin: 0 5px; }
.advanced-search { margin-top: 15px; padding-top: 15px; border-top: 1px solid #ebeef5; }
.dynamic-search-form { margin-top: 10px; }
.operation-buttons { margin-bottom: 20px; }
.operation-buttons .el-button { margin-right: 10px; }
.pagination-container { margin-top: 20px; text-align: left; }
.dialog-footer { text-align: right; }
.dialog-footer .el-button { margin-left: 10px; }
@media (max-width: 768px) {
  .search-form .el-row { margin: 0; }
  .search-form .el-col { margin-bottom: 10px; }
  .field-checkboxes .el-checkbox { display: block; margin-bottom: 8px; }
  .search-buttons { text-align: left; }
}`
  }

  /**
   * 转换为PascalCase
   */
  toPascalCase(str) {
    return str.replace(/(?:^|_)([a-z])/g, (_, char) => char.toUpperCase())
  }

  /**
   * 转换为camelCase
   */
  toCamelCase(str) {
    return str.replace(/_([a-z])/g, (_, char) => char.toUpperCase())
  }

  /**
   * 生成外键选项加载方法
   */
  generateForeignKeyOptionsMethods() {
    const foreignKeyFields = this.fields.filter(f => f.needsApiOptions || f.isForeignKey || f.type === 'foreignkey')
    if (foreignKeyFields.length === 0) {
      return ''
    }

    let methods = ''
    const uniqueModuleKeys = new Set()

    foreignKeyFields.forEach(field => {
      let moduleKey = (field.relatedModel || field.key || '').toLowerCase()
      let apiMethod = ''
      
      // 优先使用配置的apiModule和apiMethod
      if (field.apiModule && field.apiMethod) {
        moduleKey = String(field.apiModule).toLowerCase()
        apiMethod = String(field.apiMethod)
      } else if (field.optionConfig && field.optionConfig.apiConfig && field.optionConfig.apiConfig.url) {
        const url = String(field.optionConfig.apiConfig.url).trim()
        const match = url.match(/^\/?api\/(\w+)\/(\w+)$/i) || url.match(/^\/?(\w+)\/(\w+)$/i) || []
        moduleKey = (match[1] || moduleKey).toLowerCase()
        apiMethod = match[2] || `get${this.toPascalCase(moduleKey)}List`
      } else if (field.apiUrl) {
        const url = String(field.apiUrl).trim()
        const match = url.match(/^\/?api\/(\w+)\/(\w+)$/i) || url.match(/^\/?(\w+)\/(\w+)$/i) || []
        moduleKey = (match[1] || moduleKey).toLowerCase()
        apiMethod = match[2] || `get${this.toPascalCase(moduleKey)}List`
      } else {
        // 默认使用relatedModel生成API方法名
        apiMethod = `get${this.toPascalCase(moduleKey)}List`
      }

      if (moduleKey && !uniqueModuleKeys.has(moduleKey)) {
        uniqueModuleKeys.add(moduleKey)
        
        methods += `,

    // 加载${field.label || field.key}选项
    async load${this.toPascalCase(moduleKey)}Options() {
      try {
        const response = await ${apiMethod}()
        const data = response.results || response.data?.results || response.data || response.list || []
        this.${moduleKey}Options = Array.isArray(data) ? data : []
      } catch (error) {
        console.error('加载${field.label || field.key}选项失败:', error)
        this.$message.error('加载${field.label || field.key}选项失败')
        this.${moduleKey}Options = []
      }
    }`
      }
    })

    return methods
  }

  /**
   * 生成getOptionLabel方法，用于处理选择框选项的显示
   */
  generateGetOptionLabelMethod() {
    let method = `,

    // 获取选择框选项标签
    getOptionLabel(fieldKey, value, row) {
      const optionsMap = {`
    
    // 添加select类型字段的选项映射
    const selectFields = this.fields.filter(f => f.type === 'select' && f.options)
    selectFields.forEach(field => {
      method += `
        ${field.key}: this.${field.key}Options,`
    })
    
    // 添加外键字段的选项映射
    const foreignKeyFields = this.fields.filter(f => f.needsApiOptions || f.isForeignKey || f.type === 'foreignkey')
    const addedModules = new Set()
    foreignKeyFields.forEach(field => {
      let moduleKey = (field.relatedModel || field.key || '').toLowerCase()
      if (field.apiModule) {
        moduleKey = String(field.apiModule).toLowerCase()
      } else if (field.optionConfig && field.optionConfig.apiConfig && field.optionConfig.apiConfig.url) {
        const url = String(field.optionConfig.apiConfig.url).trim()
        const match = url.match(/^\/?api\/(\w+)\/(\w+)$/i) || url.match(/^\/?(\w+)\/(\w+)$/i) || []
        moduleKey = (match[1] || moduleKey).toLowerCase()
      } else if (field.apiUrl) {
        const url = String(field.apiUrl).trim()
        const match = url.match(/^\/?api\/(\w+)\/(\w+)$/i) || url.match(/^\/?(\w+)\/(\w+)$/i) || []
        moduleKey = (match[1] || moduleKey).toLowerCase()
      }
      
      if (moduleKey && !addedModules.has(moduleKey)) {
        method += `
        ${field.key}: this.${moduleKey}Options,`
        addedModules.add(moduleKey)
      }
    })
    
    method += `
      }
      const options = optionsMap[fieldKey] || []
      const option = options.find(opt => opt.value === value || opt.id === value)
      
      // 对于外键字段，优先使用配置的显示回调字段
      if (option) {`
    
    // 为每个外键字段添加显示回调字段的处理
    foreignKeyFields.forEach(field => {
      if (field.displayFieldCallback) {
        method += `
        if (fieldKey === '${field.key}') {
          return option.${field.displayFieldCallback} || option.name || option.label || value
        }`
      }
    })
    
    method += `
        return option.label || option.name || value
      }
      return value
    }`
    
    return method
  }

  /**
   * 生成导出列头配置
   */
  generateExportHeaders() {
    const tableFields = this.fields.filter(field => field.showInTable !== false)
    let headers = ''
    
    tableFields.forEach((field, index) => {
      if (index > 0) headers += ',\n        '
      headers += `'${field.key}': '${field.label}'`
    })
    
    return headers
  }
}

module.exports = VueTemplateGenerator