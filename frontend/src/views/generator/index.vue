<template>
  <div class="app-container">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>代码生成器</span>
        <el-button 
          style="float: right; margin-left: 10px;" 
          type="primary" 
          size="mini"
          @click="showDjangoModelDialog = true"
        >
          从Django模型导入
        </el-button>
        <el-button 
          style="float: right; padding: 3px 0" 
          type="text" 
          @click="resetForm"
        >
          重置
        </el-button>
      </div>
      
      <div class="generator-container">
        <!-- 配置区域 -->
        <el-card shadow="never" class="config-card">
          <div slot="header">
            <span>模块配置</span>
          </div>
          
          <!-- 基本信息 -->
          <el-form ref="moduleForm" :model="moduleConfig" :rules="rules" label-width="100px">
            <el-row :gutter="20">
              <el-col :span="12">
                <el-form-item label="模块名称" prop="moduleName">
                  <el-input v-model="moduleConfig.moduleName" placeholder="请输入模块名称，如：用户管理" />
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="模块标识" prop="moduleKey">
                  <el-input v-model="moduleConfig.moduleKey" placeholder="请输入模块标识，如：user" />
                </el-form-item>
              </el-col>
            </el-row>
            
            <el-row :gutter="20">
              <el-col :span="12">
                <el-form-item label="作者">
                  <el-input v-model="moduleConfig.author" placeholder="请输入作者名称" />
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="描述">
                  <el-input v-model="moduleConfig.description" placeholder="请输入模块描述" />
                </el-form-item>
              </el-col>
            </el-row>

            <!-- 功能选项已按要求移除 -->
          </el-form>
          
          <!-- 字段配置 -->
          <div class="field-config">
            <div class="field-header">
              <span>字段配置</span>
              <div>
                <el-button type="primary" size="mini" @click="addField">添加字段</el-button>
              </div>
            </div>
            
            <el-table :data="moduleConfig.fields" border style="width: 100%" class="field-table" :header-cell-style="{ textAlign: 'center' }" :cell-style="{ textAlign: 'center' }">
              <el-table-column prop="key" label="字段名" min-width="120" align="center">
                <template slot-scope="scope">
                  <el-input 
                    v-model="scope.row.key" 
                    placeholder="字段名" 
                    size="mini"
                    :disabled="false"
                    @input="handleFieldKeyInput(scope.row, $event)"
                  />
                </template>
              </el-table-column>
              <el-table-column prop="label" label="显示名" min-width="120" align="center">
                <template slot-scope="scope">
                  <el-input v-model="scope.row.label" placeholder="显示名" size="mini" />
                </template>
              </el-table-column>
              <el-table-column prop="type" label="类型" min-width="100" align="center">
                <template slot-scope="scope">
                  <el-select v-model="scope.row.type" placeholder="类型" size="mini" @change="handleTypeChange(scope.row)">
                    <el-option label="文本" value="string" />
                    <el-option label="数字" value="number" />
                    <el-option label="日期" value="date" />
                    <el-option label="布尔" value="boolean" />
                    <el-option label="选择" value="select" />
                    <el-option label="外键" value="foreignkey" />
                  </el-select>
                </template>
              </el-table-column>
              <el-table-column prop="required" label="必填" width="60" align="center">
                <template slot-scope="scope">
                  <el-checkbox v-model="scope.row.required" />
                </template>
              </el-table-column>
              <el-table-column prop="searchable" label="可搜索" width="70" align="center">
                <template slot-scope="scope">
                  <el-checkbox v-model="scope.row.searchable" />
                </template>
              </el-table-column>
              <el-table-column prop="showInTable" label="表格显示" width="80" align="center">
                <template slot-scope="scope">
                  <el-checkbox v-model="scope.row.showInTable" />
                </template>
              </el-table-column>
              <el-table-column prop="showInForm" label="表单显示" width="80" align="center">
                <template slot-scope="scope">
                  <el-checkbox v-model="scope.row.showInForm" />
                </template>
              </el-table-column>
              <!-- 外键API配置（仅外键类型展示） -->
              <el-table-column prop="apiModule" label="API模块" min-width="120" align="center">
                <template slot-scope="scope">
                  <el-input
                    v-if="scope.row.type === 'foreignkey'"
                    v-model="scope.row.apiModule"
                    placeholder="如：department"
                    size="mini"/>
                </template>
              </el-table-column>
              <el-table-column prop="apiMethod" label="方法名" min-width="160" align="center">
                <template slot-scope="scope">
                  <el-input
                    v-if="scope.row.type === 'foreignkey'"
                    v-model="scope.row.apiMethod"
                    placeholder="如：getDepartmentOptions"
                    size="mini"/>
                </template>
              </el-table-column>
              <el-table-column prop="displayFieldCallback" label="显示回调字段" min-width="220" align="center">
                <template slot-scope="scope">
                  <el-input
                    v-if="scope.row.type === 'foreignkey'"
                    v-model="scope.row.displayFieldCallback"
                    placeholder="示例：(option, value, row) => option.name"
                    size="mini"/>
                </template>
              </el-table-column>
              <!-- 选项（仅选择类型展示） -->
              <el-table-column prop="options" label="选项" min-width="220" align="center">
                <template slot-scope="scope">
                  <el-input
                    v-if="scope.row.type === 'select'"
                    v-model="scope.row.optionsText"
                    placeholder="标签:值, 标签2:值2"
                    size="mini"/>
                </template>
              </el-table-column>
              <el-table-column label="操作" width="80" align="center">
                <template slot-scope="scope">
                  <el-button type="danger" size="mini" @click="removeField(scope.$index)">删除</el-button>
                </template>
              </el-table-column>
            </el-table>
          </div>
        </el-card>
        
        <!-- 代码预览区域 -->
        <el-card shadow="never" class="preview-card">
          <div slot="header">
            <span>代码预览</span>
            <el-button 
              style="float: right; padding: 3px 0" 
              type="text" 
              @click="generateCode"
            >
              生成代码
            </el-button>
          </div>
          
          <el-tabs v-model="activePreviewTab" type="card">
            <el-tab-pane label="Vue组件" name="vue">
              <div class="code-preview-container">
                <div class="code-preview">
                  <pre><code>{{ previewCode.vue }}</code></pre>
                  <div class="copy-button" @click="copyCode('vue')" title="复制代码">
                    <i class="el-icon-document-copy"></i>
                  </div>
                </div>
              </div>
            </el-tab-pane>
            <el-tab-pane label="API接口" name="api">
              <div class="code-preview-container">
                <div class="code-preview">
                  <pre><code>{{ previewCode.api }}</code></pre>
                  <div class="copy-button" @click="copyCode('api')" title="复制代码">
                    <i class="el-icon-document-copy"></i>
                  </div>
                </div>
              </div>
            </el-tab-pane>
          </el-tabs>
        </el-card>
        
        <!-- 操作按钮 -->
        <div class="action-buttons">
          <el-button @click="resetForm">重置</el-button>
          <el-button type="primary" @click="generateCode">生成代码</el-button>
          <el-button type="success" @click="downloadCode" :disabled="!hasGeneratedCode">下载代码</el-button>
          <el-button type="warning" @click="handlePreviewCode">预览代码</el-button>
        </div>
      </div>
    </el-card>

    <!-- Django模型导入对话框 -->
    <el-dialog
      title="从Django模型导入"
      :visible.sync="showDjangoModelDialog"
      width="60%"
      :before-close="handleDialogClose"
    >
      <div class="django-model-import">
        <p class="import-tip">请输入Django模型代码，系统将自动解析字段配置</p>
        <el-input
          type="textarea"
          :rows="10"
          placeholder="请输入Django模型代码，例如：\nclass User(models.Model):\n    name = models.CharField(max_length=100, verbose_name='姓名')\n    email = models.EmailField(verbose_name='邮箱')"
          v-model="djangoModelCode"
        ></el-input>
        
        <div class="dialog-footer" style="margin-top: 20px;">
          <el-button @click="showDjangoModelDialog = false">取消</el-button>
          <el-button type="primary" @click="importFromDjangoModel">导入</el-button>
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import ModuleGenerator from '@/utils/generator/moduleGenerator.js'
import DjangoModelParser from '@/utils/generator/djangoModelParser.js'

export default {
  name: 'CodeGenerator',
  data() {
    return {
      activePreviewTab: 'vue',
      hasGeneratedCode: false,
      showDjangoModelDialog: false,
      djangoModelCode: '',
      moduleConfig: {
        moduleName: '',
        moduleKey: '',
        author: '',
        description: '',
        // options 保持移除
        fields: [
          {
            key: 'id',
            label: 'ID',
            type: 'number',
            required: false,
            searchable: false, // ID字段默认不可搜索
            defaultSearch: false, // ID字段默认不显示在搜索中
            showInTable: true,
            showInForm: true, // ID字段默认在表单中显示
            width: 80,
            optionsText: '',
            apiModule: '',
            apiMethod: '',
            displayFieldCallback: ''
          },
          {
            key: 'name',
            label: '名称',
            type: 'string',
            required: true,
            searchable: true,
            defaultSearch: true, // 默认显示在搜索中
            showInTable: true,
            showInForm: true,
            width: 120,
            placeholder: '请输入名称',
            optionsText: '',
            apiModule: '',
            apiMethod: '',
            displayFieldCallback: ''
          },
          {
            key: 'status',
            label: '状态',
            type: 'select',
            required: false,
            searchable: true,
            defaultSearch: true, // 默认显示在搜索中
            showInTable: true,
            showInForm: true,
            width: 100,
            placeholder: '请选择状态',
            optionsText: 'active:激活\ninactive:非激活',
            apiModule: '',
            apiMethod: '',
            displayFieldCallback: ''
          },
          {
            key: 'created_at',
            label: '创建时间',
            type: 'date',
            required: false,
            searchable: true,
            defaultSearch: false, // 时间字段默认不搜索，让用户手动选择
            showInTable: true,
            showInForm: true,
            width: 140,
            placeholder: '请选择创建时间',
            optionsText: '',
            apiModule: '',
            apiMethod: '',
            displayFieldCallback: ''
          },
          {
            key: 'updated_at',
            label: '更新时间',
            type: 'date',
            required: false,
            searchable: true,
            defaultSearch: false, // 时间字段默认不搜索，让用户手动选择
            showInTable: true,
            showInForm: true,
            width: 140,
            placeholder: '请选择更新时间',
            optionsText: '',
            apiModule: '',
            apiMethod: '',
            displayFieldCallback: ''
          }
        ]
      },
      previewCode: {
        vue: '',
        api: ''
      },
      generatedFiles: [],
      rules: {
        moduleName: [
          { required: true, message: '请输入模块名称', trigger: 'blur' }
        ],
        moduleKey: [
          { required: true, message: '请输入模块标识', trigger: 'blur' },
          { pattern: /^[a-zA-Z][a-zA-Z0-9]*$/, message: '模块标识只能包含字母和数字，且以字母开头', trigger: 'blur' }
        ]
      }
    }
  },
  methods: {
    toPascalCase(str = '') {
      return String(str).replace(/(?:^|_)([a-z])/g, (_, c) => c.toUpperCase())
    },
    addField() {
      this.moduleConfig.fields.push({
        key: '',
        label: '',
        type: 'string',
        required: false,
        searchable: true, // 默认启用搜索
        showInTable: true,
        showInForm: true,
        width: 120,
        placeholder: '',
        optionsText: '',
        apiModule: '', // 外键API模块
        apiMethod: '', // 外键API方法
        displayFieldCallback: '' // 外键显示字段回调
      })
    },
    removeField(index) {
      this.moduleConfig.fields.splice(index, 1)
    },
    resetForm() {
      this.$refs.moduleForm && this.$refs.moduleForm.resetFields && this.$refs.moduleForm.resetFields()
      this.moduleConfig = {
        moduleName: '',
        moduleKey: '',
        author: '',
        description: '',
        fields: [
          {
            key: 'id',
            label: 'ID',
            type: 'number',
            required: false,
            searchable: false,
            showInTable: true,
            showInForm: false,
            width: 80,
            optionsText: '',
            apiModule: '',
            apiMethod: '',
            displayFieldCallback: ''
          },
          {
            key: 'name',
            label: '名称',
            type: 'string',
            required: true,
            searchable: true,
            showInTable: true,
            showInForm: true,
            width: 120,
            placeholder: '请输入名称',
            optionsText: '',
            apiModule: '',
            apiMethod: '',
            displayFieldCallback: ''
          }
        ]
      }
      this.previewCode = {
        vue: '',
        api: ''
      }
      this.hasGeneratedCode = false
    },
    // 解析“标签:值, 标签2:值2”到 [{label,value}] 数组
    parseOptionsText(text = '') {
      if (!text || typeof text !== 'string') return []
      return text
        .split(',')
        .map(s => s.trim())
        .filter(Boolean)
        .map(pair => {
          const [label, value] = pair.split(':').map(x => (x || '').trim())
          return label && value ? { label, value } : null
        })
        .filter(Boolean)
    },
    // 构建并校验规范化配置
    buildNormalizedConfig() {
      const errors = []
      const keyPattern = /^[a-zA-Z][a-zA-Z0-9]*$/

      if (!this.moduleConfig.moduleKey || !keyPattern.test(this.moduleConfig.moduleKey)) {
        errors.push('模块标识必须以字母开头，只能包含字母和数字')
      }

      const normalizedFields = this.moduleConfig.fields.map((f, idx) => {
        const key = f.key || f.name
        if (!key) errors.push(`第${idx + 1}行字段：字段名不能为空`)
        const label = f.label
        if (!label) errors.push(`第${idx + 1}行字段：显示名不能为空`)
        const type = f.type || 'string'
        const nf = { ...f, key, label, type }
        if (type === 'select') {
          // 跳过外键字段的选项验证（外键字段通过API动态获取选项）
          if (nf.hasStaticOptions !== false && !nf.needsApiOptions) {
            if (!Array.isArray(nf.options) || nf.options.length === 0) {
              const parsed = this.parseOptionsText(f.optionsText)
              if (parsed.length === 0) {
                errors.push(`选择类型字段"${label || key}"需要配置选项（示例：状态:enabled, 禁用:disabled）`)
              } else {
                nf.options = parsed
              }
            }
          }
        }
        return nf
      })

      const keys = normalizedFields.map(f => f.key)
      const duplicates = keys.filter((k, i) => keys.indexOf(k) !== i)
      if (duplicates.length > 0) {
        errors.push(`存在重复字段：${[...new Set(duplicates)].join(', ')}`)
      }
      if (!keys.includes('id')) {
        errors.push('必须包含 id 字段')
      }

      if (errors.length > 0) {
        throw new Error(errors[0])
      }

      return {
        ...this.moduleConfig,
        fields: normalizedFields
      }
    },
    async generateCode() {
      try {
        await (this.$refs.moduleForm && this.$refs.moduleForm.validate ? this.$refs.moduleForm.validate() : Promise.resolve())

        const normalizedConfig = this.buildNormalizedConfig()
        
        const generator = new ModuleGenerator()
        generator.setConfig(normalizedConfig)
        
        const result = generator.generateAll()
        
        if (result.success) {
          this.generatedFiles = result.files
          this.updatePreviewCode()
          this.hasGeneratedCode = true
          this.$message.success('代码生成成功！')
        } else {
          this.$message.error('代码生成失败：' + result.errors.join(', '))
        }
      } catch (error) {
        this.$message.error(error && error.message ? error.message : '请完善表单信息')
      }
    },
    updatePreviewCode() {
      const vueFile = this.generatedFiles.find(f => f.type === 'vue')
      const apiFile = this.generatedFiles.find(f => f.type === 'api')
      
      this.previewCode = {
        vue: vueFile ? vueFile.content : '',
        api: apiFile ? apiFile.content : ''
      }
    },
    handlePreviewCode() {
      if (!this.hasGeneratedCode) {
        this.generateCode()
      }
    },

    // Django模型导入相关方法
    handleDialogClose(done) {
      this.djangoModelCode = ''
      done()
    },

    importFromDjangoModel() {
      if (!this.djangoModelCode.trim()) {
        this.$message.warning('请输入Django模型代码')
        return
      }
      
      try {
        const parser = new DjangoModelParser()
        const modelInfo = parser.parseModel(this.djangoModelCode)
        const frontendConfig = parser.generateFrontendConfig(this.djangoModelCode)
        
        if (!frontendConfig || !frontendConfig.fields || frontendConfig.fields.length === 0) {
          this.$message.error('解析失败：未能识别有效的字段')
          return
        }
        
        if (frontendConfig.moduleName) {
          this.moduleConfig.moduleName = frontendConfig.moduleName
        }
        
        if (frontendConfig.moduleKey) {
          this.moduleConfig.moduleKey = frontendConfig.moduleKey
        }
        
        // 设置描述
        if (frontendConfig.description) {
          this.moduleConfig.description = frontendConfig.description
        }
        
        // 设置默认作者
        if (!this.moduleConfig.author) {
          this.moduleConfig.author = 'ylf'
        }
        
        this.moduleConfig.fields = frontendConfig.fields.map(field => {
          let optionsText = ''
          if (field.type === 'select' && field.options && field.options.length > 0) {
            optionsText = field.options.map(opt => `${opt.label}:${opt.value}`).join(', ')
          }
          
          if (field.key === 'id' && field.isPrimaryKey) {
            return {
              ...field,
              optionsText,
              showInForm: false,
              showInTable: true,
              searchable: true,
              sortable: true,
              apiModule: field.apiModule || '',
              apiMethod: field.apiMethod || '',
              displayFieldCallback: field.displayFieldCallback || ''
            }
          }
          
          const isForeign = field.type === 'foreignkey'
          const defaultModule = field.relatedModel || field.key
          const defaultMethod = `get${this.toPascalCase(defaultModule)}Options`
          return {
            ...field,
            optionsText,
            // 外键字段初始化显示回调，默认使用 option.name
            displayFieldCallback: field.displayFieldCallback || (isForeign ? '(option) => option.name' : ''),
            // 外键初始化API模块和方法名（如果未提供）
            apiModule: isForeign ? (field.apiModule || defaultModule) : (field.apiModule || ''),
            apiMethod: isForeign ? (field.apiMethod || defaultMethod) : (field.apiMethod || '')
          }
        })
        
        this.$message.success('Django模型导入成功')
        this.showDjangoModelDialog = false
        
      } catch (error) {
         console.error('Django模型解析错误:', error)
         this.$message.error('解析失败：' + (error.message || '未知错误'))
       }
     },

     // 复制代码方法
     copyCode(type) {
       const code = this.previewCode[type]
       if (!code) {
         this.$message.warning('暂无代码可复制')
         return
       }
       
       const textarea = document.createElement('textarea')
       textarea.value = code
       document.body.appendChild(textarea)
       textarea.select()
       
       try {
         document.execCommand('copy')
         this.$message.success('代码已复制到剪贴板')
       } catch (err) {
         console.error('复制失败:', err)
         this.$message.error('复制失败，请手动复制')
       } finally {
         document.body.removeChild(textarea)
       }
     },
    downloadCode() {
      if (!this.hasGeneratedCode) {
        this.$message.warning('请先生成代码')
        return
      }
      
      this.generatedFiles.forEach(file => {
        const blob = new Blob([file.content], { type: 'text/plain' })
        const url = window.URL.createObjectURL(blob)
        const link = document.createElement('a')
        link.href = url
        link.download = file.path.split('/').pop()
        document.body.appendChild(link)
        link.click()
        document.body.removeChild(link)
        window.URL.revokeObjectURL(url)
      })
      
      this.$message.success('代码文件下载完成！')
    },
    
    // 处理字段类型变化
    handleTypeChange(field) {
      // 如果是外键类型，设置默认值（使用Vue.set确保响应式）
      if (field.type === 'foreignkey') {
        const key = field.key || ''
        if (!field.apiModule && key) {
          this.$set(field, 'apiModule', key)
        }
        if (!field.apiMethod && (field.apiModule || key)) {
          const moduleName = field.apiModule || key
          this.$set(field, 'apiMethod', `get${this.toPascalCase(moduleName)}Options`)
        }
        if (!field.displayFieldCallback) {
          this.$set(field, 'displayFieldCallback', '(option) => option.name')
        }
      }
    },
    
    // 处理字段名输入
    handleFieldKeyInput(field, value) {
      // 确保字段名可以正常输入
      field.key = value
      // 如果是外键类型且有字段名，更新API模块与方法名
      if (field.type === 'foreignkey' && value) {
        field.apiModule = value
        field.apiMethod = `get${this.toPascalCase(value)}Options`
      }
    },
    
    // 处理显示回调字段输入
    handleDisplayFieldInput(field, event) {
      // 从事件对象中获取输入值
      const value = event && event.target ? event.target.value : event
      // 使用Vue.set确保显示字段为响应式（此处改为显示回调字段）
      this.$set(field, 'displayFieldCallback', value)
      // 强制触发Vue的响应式更新
      this.$forceUpdate()
      console.log('显示回调字段已更新:', field.key, '=', value)
    }
  }
}
</script>

<style scoped>
.generator-container {
  padding: 20px;
}

.config-card {
  margin-bottom: 20px;
}

.preview-card {
  margin-top: 20px;
}

.field-config {
  margin-top: 20px;
}

.field-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
  font-weight: bold;
}

.field-table {
  margin-top: 10px;
}

.code-preview {
  position: relative;
  min-height: 300px;
  max-height: 600px;
  overflow-y: auto;
  background-color: #f5f5f5;
  padding: 10px;
  border-radius: 4px;
}

.copy-button {
  position: absolute;
  top: 10px;
  right: 10px;
  width: 32px;
  height: 32px;
  background: rgba(64, 158, 255, 0.8);
  border-radius: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  color: white;
  font-size: 14px;
  transition: all 0.3s;
  opacity: 0.7;
}

.copy-button:hover {
  opacity: 1;
  background: rgba(64, 158, 255, 1);
  transform: scale(1.1);
}

.code-preview pre {
  margin: 0;
  white-space: pre-wrap;
  word-wrap: break-word;
}

.code-preview code {
  font-family: 'Courier New', Courier, monospace;
  font-size: 12px;
  line-height: 1.4;
}

.action-buttons {
  text-align: center;
  margin-top: 20px;
  padding: 20px 0;
  border-top: 1px solid #ebeef5;
}

.action-buttons .el-button {
  margin: 0 10px;
}

/* Django模型导入样式 */
.django-model-import {
  padding: 0 20px;
}

.import-tip {
  color: #606266;
  margin-bottom: 15px;
  font-size: 14px;
}

.el-textarea >>> .el-textarea__inner {
  font-family: 'Courier New', Courier, monospace;
  line-height: 1.5;
}

/* 代码预览容器样式 */
.code-preview-container {
  position: relative;
}

</style>utton { margin-right: 10px; }
.pagination-container { margin-top: 20px; text-align: left; }
.dialog-footer { text-align: right; }
.dialog-footer .el-button { margin-left: 10px; }
@media (max-width: 768px) {
  .search-form .el-row { margin: 0; }
  .search-form .el-col { margin-bottom: 10px; }
  .field-checkboxes .el-checkbox { display: block; margin-bottom: 8px; }
  .search-buttons { text-align: left; }
}
</style>