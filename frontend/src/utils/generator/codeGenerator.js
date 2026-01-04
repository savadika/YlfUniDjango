/**
 * 通用CRUD模块代码生成器
 * 基于部门管理模块的完整功能，自动生成标准化的管理模块
 */

class CodeGenerator {
  /**
   * 字段类型映射
   */
  static FIELD_TYPES = {
    string: {
      component: 'el-input',
      props: { clearable: true },
      validator: 'string'
    },
    number: {
      component: 'el-input-number',
      props: { style: 'width: 100%' },
      validator: 'number'
    },
    select: {
      component: 'el-select',
      props: { clearable: true, style: 'width: 100%' },
      validator: 'string'
    },
    switch: {
      component: 'el-switch',
      props: { activeValue: 1, inactiveValue: 0 },
      validator: 'number'
    },
    date: {
      component: 'el-date-picker',
      props: { 
        type: 'date',
        format: 'yyyy-MM-dd',
        valueFormat: 'yyyy-MM-dd',
        style: 'width: 100%'
      },
      validator: 'string'
    },
    datetime: {
      component: 'el-date-picker',
      props: { 
        type: 'datetime',
        format: 'yyyy-MM-dd HH:mm:ss',
        valueFormat: 'yyyy-MM-dd HH:mm:ss',
        style: 'width: 100%'
      },
      validator: 'string'
    },
    daterange: {
      component: 'el-date-picker',
      props: {
        type: 'daterange',
        rangeSeparator: '至',
        startPlaceholder: '开始日期',
        endPlaceholder: '结束日期',
        format: 'yyyy-MM-dd',
        valueFormat: 'yyyy-MM-dd',
        style: 'width: 100%'
      },
      validator: 'array'
    },
    textarea: {
      component: 'el-input',
      props: { type: 'textarea', rows: 3 },
      validator: 'string'
    }
  }

  /**
   * 生成Vue组件模板
   * @param {Object} config - 模块配置
   * @param {string} config.moduleName - 模块名称（中文）
   * @param {string} config.moduleKey - 模块标识（英文）
   * @param {Array} config.fields - 字段配置
   * @param {Object} config.options - 其他选项
   */
  static generateVueComponent(config) {
    const {
      moduleName,
      moduleKey,
      fields,
      options = {}
    } = config

    const {
      enableSearch = true,
      enableExport = true,
      enablePagination = true,
      pageSize = 10
    } = options

    // 生成模板、脚本和样式
    const template = this.generateTemplate(config)
    const script = this.generateScript(config)
    const style = this.generateStyle()

    return `<template>
${template}
</template>

<script>
${script}
</script>

<style lang="scss" scoped>
${style}
</style>`
  }

  /**
   * 生成模板部分
   */
  static generateTemplate(config) {
    const { moduleName, fields, options = {} } = config
    const { enableSearch = true, enableExport = true } = options

    return `  <div class="app-container">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>${moduleName}</span>
      </div>
      
      ${enableSearch ? this.generateSearchSection(fields, enableExport) : ''}
      
      <!-- 操作按钮区域 -->
      <div class="filter-container">
        <el-button type="primary" icon="el-icon-plus" @click="handleCreate">新增</el-button>
      </div>
      
      ${this.generateTable(fields)}
      
      ${this.generatePagination()}
    </el-card>

    ${this.generateDialog(fields)}
  </div>`
  }

  /**
   * 生成搜索区域
   */
  static generateSearchSection(fields, enableExport = true) {
    const searchableFields = fields.filter(field => field.searchable)
    if (searchableFields.length === 0) return ''

    const fieldCheckboxes = searchableFields.map(field => 
      `                  <el-checkbox label="${field.key}">${field.label}</el-checkbox>`
    ).join('\n')

    const searchFormItems = searchableFields.map(field => {
      // 对于日期字段，在搜索时使用日期范围选择器
       let fieldType, component, props, placeholder
       if (field.type === 'date' || field.type === 'datetime') {
         fieldType = this.FIELD_TYPES.daterange
         component = fieldType.component
         props = this.generateProps(fieldType.props, field)
         placeholder = ''
       } else {
        fieldType = this.FIELD_TYPES[field.type] || this.FIELD_TYPES.string
        component = fieldType.component
        props = this.generateProps(fieldType.props, field)
        placeholder = `placeholder="请输入${field.label}"`
      }
      
      return `                  <!-- ${field.label} -->
                  <el-col :span="8" v-if="searchFields.includes('${field.key}')">
                    <el-form-item label="${field.label}">
                      <${component} 
                        v-model="searchForm.${field.key}" 
                        ${placeholder}
                        ${props}
                      ${field.type === 'select' ? `>
                        <el-option label="全部" value=""></el-option>
                        ${this.generateSelectOptions(field)}
                      </${component}>` : '/>'}
                    </el-form-item>
                  </el-col>`
    }).join('\n\n')

    return `      <!-- 高级搜索模块 -->
      <div class="search-container">
        <el-card class="search-card" shadow="never">
          <div slot="header" class="search-header">
            <span class="search-title">
              <i class="el-icon-search"></i>
              高级搜索
            </span>
            <div class="search-actions">
              <el-button 
                type="text" 
                size="small" 
                @click="toggleSearchExpand"
                class="expand-btn"
              >
                {{ searchExpanded ? '收起' : '展开' }}
                <i :class="searchExpanded ? 'el-icon-arrow-up' : 'el-icon-arrow-down'"></i>
              </el-button>
            </div>
          </div>
          
          <el-collapse-transition>
            <div v-show="searchExpanded" class="search-content">
              <!-- 搜索字段选择器 -->
              <div class="field-selector">
                <span class="selector-label">搜索字段：</span>
                <el-checkbox-group v-model="searchFields" class="field-checkboxes">
${fieldCheckboxes}
                </el-checkbox-group>
              </div>
              
              <!-- 搜索表单 -->
              <el-form :model="searchForm" class="search-form" label-width="100px">
                <el-row :gutter="20">
${searchFormItems}
                </el-row>
                
                <!-- 搜索按钮组 -->
                <div class="search-buttons">
                  <el-button 
                    type="primary" 
                    icon="el-icon-search" 
                    @click="handleSearch"
                    :loading="loading"
                  >
                    搜索
                  </el-button>
                  <el-button 
                    icon="el-icon-refresh" 
                    @click="handleReset"
                  >
                    重置
                  </el-button>
                  ${enableExport ? '<ExportButton\n                    :api-function="exportGetList"\n                    :search-params="getSearchParams()"\n                    :export-options="exportOptions"\n                    @export-success="onExportSuccess"\n                    @export-error="onExportError"\n                  />' : ''}
                </div>
              </el-form>
            </div>
          </el-collapse-transition>
        </el-card>
      </div>`
  }

  /**
   * 生成导出按钮
   */
  static generateExportButton() {
    return `
        <export-button
          :api-function="exportGetList"
          :search-params="getSearchParams()"
          :export-options="exportOptions"
          @export-success="onExportSuccess"
          @export-error="onExportError"
        />`
  }

  /**
   * 生成表格
   */
  static generateTable(fields) {
    const tableColumns = fields.filter(field => field.showInTable).map(field => {
      if (field.type === 'switch') {
        return `        <el-table-column
          prop="${field.key}"
          label="${field.label}"
          min-width="80"
        >
          <template slot-scope="scope">
            <el-tag v-if="scope.row.${field.key} === 1" type="success">${field.activeText || '是'}</el-tag>
            <el-tag v-else type="danger">${field.inactiveText || '否'}</el-tag>
          </template>
        </el-table-column>`
      } else {
        return `        <el-table-column
          prop="${field.key}"
          label="${field.label}"
          min-width="${field.width || 120}"
        />`
      }
    }).join('\n')

    return `      <el-table
        :data="tableData"
        style="width: 100%"
        border
        row-key="id"
        :cell-style="{ textAlign: 'center' }"
        :header-cell-style="{ textAlign: 'center' }"
        :loading="loading"
      >
${tableColumns}
        <el-table-column
          label="操作"
          min-width="120"
          fixed="right"
        >
          <template slot-scope="scope">
            <el-button type="text" size="small" icon="el-icon-edit" @click="handleEdit(scope.row)">编辑</el-button>
            <el-button type="text" size="small" icon="el-icon-delete" style="color: #F56C6C" @click="handleDelete(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>`
  }

  /**
   * 生成分页组件
   */
  static generatePagination() {
    return `      <!-- 分页组件 -->
      <div class="pagination-container">
        <el-pagination
          background
          layout="total, sizes, prev, pager, next, jumper"
          :total="total"
          :page-sizes="[5, 10, 20, 50]"
          :page-size="listQuery.page_size"
          :current-page="listQuery.page"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>`
  }

  /**
   * 生成对话框
   */
  static generateDialog(fields) {
    const formItems = fields.filter(field => field.showInForm).map(field => {
      const fieldType = this.FIELD_TYPES[field.type] || this.FIELD_TYPES.string
      const component = fieldType.component
      const props = this.generateProps(fieldType.props, field)
      
      // 构建额外属性，如创建/更新时间禁用
      const extra = (field.key === 'create_time' || field.key === 'update_time') && (field.type === 'date' || field.type === 'datetime')
        ? ' :disabled="true"'
        : ''
      
      return `        <el-form-item label="${field.label}" prop="${field.key}">
          <${component} v-model="form.${field.key}" placeholder="${field.placeholder || '请输入' + field.label}" ${props}${extra}${field.type === 'select' ? `>
            ${field.hasStaticOptions !== false ? this.generateSelectOptions(field) : this.generateForeignKeyOptions(field)}
          </${component}>` : '/>'}
        </el-form-item>`
    }).join('\n')

    return `    <!-- 新增/编辑弹窗 -->
    <el-dialog :title="isEdit ? '编辑' : '新增'" :visible.sync="dialogVisible" width="520px">
      <el-form :model="form" :rules="rules" ref="formRef" label-width="100px">
${formItems}
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" :loading="submitting" @click="submitForm">保 存</el-button>
      </span>
    </el-dialog>`
  }

  /**
   * 生成组件属性
   */
  static generateProps(props, field) {
    if (!props) return ''
    
    return Object.entries(props).map(([key, value]) => {
      if (key === 'activeValue' && field.activeValue !== undefined) {
        value = field.activeValue
      }
      if (key === 'inactiveValue' && field.inactiveValue !== undefined) {
        value = field.inactiveValue
      }
      
      if (typeof value === 'string') {
        return `${key}="${value}"`
      } else if (typeof value === 'number') {
        return `:${key}="${value}"`
      } else {
        return `:${key}="${JSON.stringify(value)}"`
      }
    }).join(' ')
  }

  /**
   * 生成选择框选项
   */
  static generateSelectOptions(field) {
    if (!field.options) return ''
    
    return field.options.map(option => 
      `            <el-option label="${option.label}" :value="${option.value}"></el-option>`
    ).join('\n')
  }

  /**
   * 生成外键字段选项（通过API动态加载）
   */
  static generateForeignKeyOptions(field) {
    const optionsVar = `${field.key}Options`
    return `            <el-option 
              v-for="option in ${optionsVar}" 
              :key="option.value || option.id" 
              :label="option.label || option.name" 
              :value="option.value || option.id">
            </el-option>`
  }

  /**
   * 生成脚本部分
   */
  static generateScript(config) {
    const { moduleName, moduleKey, fields } = config
    
    return `import { get${this.capitalize(moduleKey)}List, delete${this.capitalize(moduleKey)}, create${this.capitalize(moduleKey)}, get${this.capitalize(moduleKey)}Detail, patch${this.capitalize(moduleKey)} } from '@/api/${moduleKey}'
import ExportButton from '@/components/ExportButton'

const defaultForm = () => ({
${this.generateDefaultForm(fields)}
})

export default {
  name: '${this.capitalize(moduleKey)}',
  components: {
    ExportButton
  },
  data() {
    return {
      tableData: [],
      total: 0,
      loading: false,
      dialogVisible: false,
      isEdit: false,
      form: defaultForm(),
      submitting: false,
      listQuery: {
        page: 1,
        page_size: 10
      },
      // 搜索相关
      searchExpanded: true,
      searchFields: ${JSON.stringify(fields.filter(f => f.searchable && f.defaultSearch).map(f => f.key))},
      searchForm: {
${this.generateSearchForm(fields)}
      },
      // 导出相关
      exportOptions: {
        filename: '${moduleName}列表',
        headers: {
${this.generateExportHeaders(fields)}
        },
        sheetName: '${moduleName}数据'
      },
      rules: {
${this.generateValidationRules(fields)}
      },
      // 外键字段选项数据
${this.generateForeignKeyOptionsData(fields)}
    }
  },
  created() {
    this.fetchData()
${this.generateLoadForeignKeyOptionsCalls(fields)}
  },
  methods: {
${this.generateMethods(moduleKey, fields)}
  }
}`
  }

  /**
   * 生成样式部分
   */
  static generateStyle() {
    return `/* 搜索模块样式 */
.search-container {
  margin-bottom: 16px;
}

.search-card {
  border: 1px solid #e4e7ed;
  border-radius: 8px;
  overflow: hidden;
}

.search-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0;
}

.search-title {
  font-size: 14px;
  font-weight: 500;
  color: #303133;
  display: flex;
  align-items: center;
}

.search-title i {
  margin-right: 8px;
  color: #409eff;
}

.expand-btn {
  color: #409eff;
  font-size: 12px;
  padding: 0;
}

.expand-btn:hover {
  color: #66b1ff;
}

.search-content {
  padding-top: 16px;
}

.field-selector {
  margin-bottom: 20px;
  padding: 12px 16px;
  background: #f8f9fa;
  border-radius: 6px;
  border-left: 3px solid #409eff;
}

.selector-label {
  font-size: 13px;
  color: #606266;
  margin-right: 12px;
  font-weight: 500;
}

.field-checkboxes {
  display: inline-flex;
  flex-wrap: wrap;
  gap: 16px;
}

.field-checkboxes .el-checkbox {
  margin-right: 0;
}

.search-form {
  margin-top: 16px;
}

.search-form .el-form-item {
  margin-bottom: 16px;
}

.search-form .el-form-item__label {
  font-size: 13px;
  color: #606266;
  font-weight: 500;
}

.search-buttons {
  text-align: center;
  padding: 16px 0 8px;
  border-top: 1px solid #f0f0f0;
  margin-top: 16px;
}

.search-buttons .el-button {
  margin: 0 8px;
  padding: 8px 20px;
  border-radius: 6px;
}

/* 原有样式 */
.filter-container {
  padding-bottom: 10px;
}

.pagination-container {
  padding: 32px 16px;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .search-form .el-col {
    margin-bottom: 8px;
  }
  
  .field-checkboxes {
    flex-direction: column;
    gap: 8px;
  }
  
  .search-buttons {
    text-align: left;
  }
  
  .search-buttons .el-button {
    margin: 4px 8px 4px 0;
  }
}`
  }

  // 辅助方法
  static capitalize(str) {
    return str.charAt(0).toUpperCase() + str.slice(1)
  }

  static generateDefaultForm(fields) {
    return fields.map(field => {
      let defaultValue = 'undefined'
      if (field.type === 'string' || field.type === 'textarea') defaultValue = "''"
      else if (field.type === 'number') defaultValue = '0'
      else if (field.type === 'switch') defaultValue = field.defaultValue || '1'
      else if (field.type === 'date') defaultValue = "''"
      else if (field.type === 'daterange') defaultValue = 'null'
      
      return `  ${field.key}: ${defaultValue}`
    }).join(',\n')
  }

  static generateSearchForm(fields) {
    return fields.filter(f => f.searchable).map(field => {
      let defaultValue = "''"
      // 日期字段在搜索时使用日期范围，默认值为null
       if (field.type === 'date' || field.type === 'datetime' || field.type === 'daterange') defaultValue = 'null'
      
      return `        ${field.key}: ${defaultValue}`
    }).join(',\n')
  }

  static generateExportHeaders(fields) {
    return fields.filter(f => f.showInTable).map(field => 
      `          ${field.key}: '${field.label}'`
    ).join(',\n')
  }

  static generateValidationRules(fields) {
    return fields.filter(f => f.required).map(field => 
      `        ${field.key}: [{ required: true, message: '请输入${field.label}', trigger: 'blur' }]`
    ).join(',\n')
  }

  /**
   * 生成外键字段选项数据
   */
  static generateForeignKeyOptionsData(fields) {
    const foreignKeyFields = fields.filter(f => f.needsApiOptions)
    if (foreignKeyFields.length === 0) return ''
    
    return foreignKeyFields.map(field => 
      `      ${field.key}Options: []`
    ).join(',\n')
  }

  /**
   * 生成加载外键选项的方法调用
   */
  static generateLoadForeignKeyOptionsCalls(fields) {
    const foreignKeyFields = fields.filter(f => f.needsApiOptions)
    if (foreignKeyFields.length === 0) return ''
    
    return foreignKeyFields.map(field => 
      `    this.load${this.capitalize(field.key)}Options()`
    ).join('\n')
  }

  /**
   * 生成外键字段选项加载方法
   */
  static generateForeignKeyOptionsMethods(fields) {
    const foreignKeyFields = fields.filter(f => f.needsApiOptions)
    if (foreignKeyFields.length === 0) return ''
    
    return foreignKeyFields.map(field => {
      const methodName = `load${this.capitalize(field.key)}Options`
      const relatedModel = field.relatedModel || this.capitalize(field.key)
      return `    async ${methodName}() {
      try {
        const res = await get${relatedModel}List({ page_size: 1000 })
        this.${field.key}Options = res.results || res.data || []
      } catch (error) {
        console.error('加载${field.label}选项失败:', error)
      }
    }`
    }).join(',\n\n')
  }

  static generateMethods(moduleKey, fields) {
    const capitalizedKey = this.capitalize(moduleKey)
    
    return `    async fetchData() {
      this.loading = true
      try {
        const params = {
          page: this.listQuery.page,
          page_size: this.listQuery.page_size,
          ...this.getSearchParams()
        }
        const res = await get` + capitalizedKey + `List(params)
        
        // 处理分页响应数据
        if (res && typeof res === 'object') {
          if (res.results && Array.isArray(res.results)) {
            this.tableData = res.results
            this.total = res.count || res.total || 0
          } else if (Array.isArray(res.data)) {
            this.tableData = res.data
            this.total = res.total || res.count || res.data.length
          } else if (Array.isArray(res)) {
            this.tableData = res
            this.total = res.length
          } else {
            const rows = res.data || res.results || []
            this.tableData = Array.isArray(rows) ? rows : []
            this.total = res.total || res.count || this.tableData.length
          }
        } else {
          this.tableData = []
          this.total = 0
        }
      } catch (e) {
        this.tableData = []
        this.total = 0
      } finally {
        this.loading = false
      }
    },

    handleCreate() {
      this.isEdit = false
      this.form = defaultForm()
      this.dialogVisible = true
      this.$nextTick(() => this.$refs.formRef && this.$refs.formRef.clearValidate())
    },

    async handleEdit(row) {
      this.isEdit = true
      this.form = defaultForm()
      this.dialogVisible = true
      try {
        const detail = await get` + capitalizedKey + `Detail(row.id)
        const data = Array.isArray(detail) ? detail[0] : (detail.data || detail)
        this.form = { ...defaultForm(), ...data }
      } catch (e) {
        // 已有全局提示
      }
    },

    async submitForm() {
      this.$refs.formRef.validate(async valid => {
        if (!valid) return
        this.submitting = true
        try {
          // 过滤掉空的日期字段
          const formData = { ...this.form }
          Object.keys(formData).forEach(key => {
            if ((key.includes('time') || key.includes('date')) && formData[key] === '') {
              delete formData[key]
            }
          })
          
          if (this.isEdit && this.form.id) {
            await patch` + capitalizedKey + `(this.form.id, formData)
            this.$message.success('更新成功')
          } else {
            await create` + capitalizedKey + `(formData)
            this.$message.success('新增成功')
          }
          this.dialogVisible = false
          this.fetchData()
        } catch (e) {
          // 全局拦截器会提示错误
        } finally {
          this.submitting = false
        }
      })
    },

    async handleDelete(row) {
      try {
        await this.$confirm('确定删除「' + (row.name || row.id) + '」吗？', '提示', {
          type: 'warning'
        })
        await delete` + capitalizedKey + `(row.id)
        this.$message.success('删除成功')
        this.fetchData()
      } catch (e) {
        // 点击取消/接口错误都进入这里，已由全局拦截器提示错误
      }
    },
    
    // 分页相关方法
    handleSizeChange(val) {
      this.listQuery.page_size = val
      this.listQuery.page = 1
      this.fetchData()
    },

    handleCurrentChange(val) {
      this.listQuery.page = val
      this.fetchData()
    },
    
    // 搜索相关方法
    toggleSearchExpand() {
      this.searchExpanded = !this.searchExpanded
    },
    
    getSearchParams() {
      const params = {}
      
      this.searchFields.forEach(field => {
        const value = this.searchForm[field]
        if (value !== null && value !== undefined && value !== '') {
          if (Array.isArray(value)) {
            if (value.length === 2) {
              params[field + '_start'] = value[0]
              params[field + '_end'] = value[1]
            }
          } else {
            params[field] = value
          }
        }
      })
      
      return params
    },
    
    handleSearch() {
      this.listQuery.page = 1
      this.fetchData()
    },
    
    handleReset() {
      this.searchForm = {
` + fields.filter(f => f.searchable).map(field => {
      let defaultValue = "''"
      if (field.type === 'daterange') defaultValue = 'null'
      return `        ${field.key}: ${defaultValue}`
    }).join(',\n') + `
      }
      this.searchFields = ` + JSON.stringify(fields.filter(f => f.searchable && f.defaultSearch).map(f => f.key)) + `
      this.listQuery.page = 1
      this.fetchData()
    },
    
    // 导出专用的API函数
    exportGetList(params) {
      return get` + capitalizedKey + `List(params)
    },
    
    // 导出成功回调
    onExportSuccess(data) {
      console.log('导出成功:', data)
    },
     
    // 导出失败回调
    onExportError(error) {
      console.error('导出失败:', error)
    },

` + this.generateForeignKeyOptionsMethods(fields) + '`'
  }
}

export default CodeGenerator