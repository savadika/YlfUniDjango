<template>
  <div class="app-container">
    <!-- 页面标题 -->
    <div class="page-header">
      <h2>操作日志</h2>
    </div>

    <!-- 搜索区域 -->
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
                <el-checkbox label="id">ID</el-checkbox>
                <el-checkbox label="user">操作用户</el-checkbox>
                <el-checkbox label="ip">访问IP</el-checkbox>
                <el-checkbox label="method">请求方式</el-checkbox>
                <el-checkbox label="path">请求路径</el-checkbox>
                <el-checkbox label="params">请求参数</el-checkbox>
                <el-checkbox label="status">响应状态码</el-checkbox>
                <el-checkbox label="cost_time">耗时(ms)</el-checkbox>
                <el-checkbox label="create_time">创建时间</el-checkbox>
                <el-checkbox label="log_type">日志类型</el-checkbox>
                <el-checkbox label="error_msg">错误信息</el-checkbox>
                <el-checkbox label="traceback">堆栈详情</el-checkbox>
              </el-checkbox-group>
            </div>
          </div>
          
          <!-- 动态搜索表单 -->
          <div class="dynamic-search-form" v-if="searchFields.length > 0">
            <el-form :model="searchForm" class="search-form" label-width="100px" label-position="right" size="small">
              <el-row :gutter="16">
                <el-col :span="8" v-if="searchFields.includes('id')">
                   <el-form-item label="ID" prop="id">
                    <el-input-number v-model="searchForm.id" placeholder="请输入ID" style="width: 100%" size="small" />
                  </el-form-item>
                </el-col>
                <el-col :span="8" v-if="searchFields.includes('user')">
                   <el-form-item label="操作用户" prop="user">
                    <el-select v-model="searchForm.user" placeholder="请选择操作用户" clearable filterable style="width: 100%" size="small">
                      <el-option label="全部" value="" />
                    </el-select>
                  </el-form-item>
                </el-col>
                <el-col :span="8" v-if="searchFields.includes('ip')">
                   <el-form-item label="访问IP" prop="ip">
                    <el-input v-model="searchForm.ip" placeholder="请输入访问IP" clearable size="small" style="width: 100%" />
                  </el-form-item>
                </el-col>
                <el-col :span="8" v-if="searchFields.includes('method')">
                   <el-form-item label="请求方式" prop="method">
                    <el-input v-model="searchForm.method" placeholder="请输入请求方式" clearable size="small" style="width: 100%" />
                  </el-form-item>
                </el-col>
                <el-col :span="8" v-if="searchFields.includes('path')">
                   <el-form-item label="请求路径" prop="path">
                    <el-input v-model="searchForm.path" placeholder="请输入请求路径" clearable size="small" style="width: 100%" />
                  </el-form-item>
                </el-col>
                <el-col :span="8" v-if="searchFields.includes('params')">
                   <el-form-item label="请求参数" prop="params">
                    <el-input v-model="searchForm.params" placeholder="请输入请求参数" clearable size="small" style="width: 100%" />
                  </el-form-item>
                </el-col>
                <el-col :span="8" v-if="searchFields.includes('status')">
                   <el-form-item label="响应状态码" prop="status">
                    <el-input-number v-model="searchForm.status" placeholder="请输入响应状态码" style="width: 100%" size="small" />
                  </el-form-item>
                </el-col>
                <el-col :span="8" v-if="searchFields.includes('cost_time')">
                   <el-form-item label="耗时(ms)" prop="cost_time">
                    <el-input-number v-model="searchForm.cost_time" placeholder="请输入耗时(ms)" style="width: 100%" size="small" />
                  </el-form-item>
                </el-col>
                <el-col :span="8" v-if="searchFields.includes('log_type')">
                   <el-form-item label="日志类型" prop="log_type">
                    <el-input v-model="searchForm.log_type" placeholder="请输入日志类型" clearable size="small" style="width: 100%" />
                  </el-form-item>
                </el-col>
                <el-col :span="8" v-if="searchFields.includes('error_msg')">
                   <el-form-item label="错误信息" prop="error_msg">
                    <el-input v-model="searchForm.error_msg" placeholder="请输入错误信息" clearable size="small" style="width: 100%" />
                  </el-form-item>
                </el-col>
                <el-col :span="8" v-if="searchFields.includes('traceback')">
                   <el-form-item label="堆栈详情" prop="traceback">
                    <el-input v-model="searchForm.traceback" placeholder="请输入堆栈详情" clearable size="small" style="width: 100%" />
                  </el-form-item>
                </el-col>
              </el-row>
              <el-row :gutter="16" class="time-search-row">
                <el-col :span="8" v-if="searchFields.includes('create_time')">
                   <el-form-item label="创建时间" prop="create_time">
                    <el-date-picker v-model="searchForm.create_time" type="datetimerange" range-separator="至" start-placeholder="开始时间" end-placeholder="结束时间" style="width: 100%" value-format="yyyy-MM-dd HH:mm:ss" clearable unlink-panels size="small" />
                  </el-form-item>
                </el-col>
              </el-row>
            </el-form>
          </div>
          
          <!-- 搜索按钮 -->
          <div class="search-buttons">
            <el-button type="primary" icon="el-icon-search" @click="handleSearch" size="small">搜索</el-button>
            <el-button icon="el-icon-refresh" @click="handleResetSearch" size="small">重置</el-button>
          </div>
        </div>
      </el-card>
    </div>

    <!-- 操作按钮 -->
    <div class="operation-buttons">
      <!-- <el-button type="primary" icon="el-icon-plus" @click="handleCreate">新增</el-button> -->
      <!-- <el-button type="danger" icon="el-icon-delete" @click="handleBatchDelete" :disabled="multipleSelection.length === 0">批量删除</el-button> -->
      <export-button :api-function="exportLogList" :search-params="searchParams" :export-options="getExportOptions()" v-permission="['system:log:export']" @export-success="onExportSuccess" @export-error="onExportError" />
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
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column prop="id" label="ID" align="center" />
      <el-table-column prop="user" label="操作用户" align="center">
        <template slot-scope="{ row }">
          {{ row.username  }}
        </template>
      </el-table-column>
      <el-table-column prop="ip" label="访问IP" align="center" />
      <el-table-column prop="method" label="请求方式" align="center" />
      <el-table-column prop="path" label="请求路径" align="center" />
      <el-table-column prop="params" label="请求参数" align="center" :show-overflow-tooltip="true" />
      <el-table-column prop="status" label="响应状态码" align="center" />
      <el-table-column prop="cost_time" label="耗时(ms)" align="center">
        <template slot-scope="{ row }">
          {{ row.cost_time ? Number(row.cost_time).toFixed(3) : row.cost_time }}
        </template>
      </el-table-column>
      <el-table-column prop="create_time" label="创建时间" align="center">
        <template slot-scope="{ row }">
          {{ row.create_time ? parseTime(row.create_time) : '' }}
        </template>
      </el-table-column>
      <el-table-column prop="log_type" label="日志类型" align="center" />
      <el-table-column prop="error_msg" label="错误信息" align="center" :show-overflow-tooltip="true" />
      <el-table-column prop="traceback" label="堆栈详情" align="center" :show-overflow-tooltip="true" />
      <el-table-column label="操作" width="180" align="center" fixed="right">
        <template slot-scope="{ row }">
          <el-button type="text" size="small" v-permission="['system:log:detail']" @click="handleEdit(row)">查看</el-button>
        </template>
      </el-table-column>
    </el-table>

      <!-- 分页 -->
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
      </div>

    <!-- 新增/编辑对话框 -->
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
        <el-form-item label="操作用户" prop="username">
          <el-input v-model="form.username" placeholder="请输入操作用户" />
        </el-form-item>
        <el-form-item label="访问IP" prop="ip">
          <el-input v-model="form.ip" placeholder="请输入访问IP" />
        </el-form-item>
        <el-form-item label="请求方式" prop="method">
          <el-input v-model="form.method" placeholder="请输入请求方式" />
        </el-form-item>
        <el-form-item label="请求路径" prop="path">
          <el-input v-model="form.path" placeholder="请输入请求路径" />
        </el-form-item>
        <el-form-item label="请求参数" prop="params">
          <el-input v-model="form.params" type="textarea" :rows="3" placeholder="请输入请求参数" />
        </el-form-item>
        <el-form-item label="响应状态码" prop="status">
          <el-input-number v-model="form.status" placeholder="请输入响应状态码" style="width: 100%" />
        </el-form-item>
        <el-form-item label="耗时(ms)" prop="cost_time">
          <el-input-number v-model="form.cost_time" placeholder="请输入耗时(ms)" style="width: 100%" />
        </el-form-item>
        <el-form-item label="创建时间" prop="create_time">
          <el-date-picker v-model="form.create_time" type="datetime" placeholder="请选择创建时间" style="width: 100%" value-format="yyyy-MM-dd HH:mm:ss" />
        </el-form-item>
        <el-form-item label="日志类型" prop="log_type">
          <el-input v-model="form.log_type" placeholder="请输入日志类型" />
        </el-form-item>
        <el-form-item label="错误信息" prop="error_msg">
          <el-input v-model="form.error_msg" type="textarea" :rows="3" placeholder="请输入错误信息" />
        </el-form-item>
        <el-form-item label="堆栈详情" prop="traceback">
          <el-input v-model="form.traceback" type="textarea" :rows="3" placeholder="请输入堆栈详情" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <!-- <el-button type="primary" @click="handleSubmit" :loading="submitLoading">确定</el-button> -->
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { getLogList, createLog, updateLog, deleteLog } from '@/api/log'
import { getUserList } from '@/api/user'
import { parseTime } from '@/utils'
import exportMixin from '@/utils/exportMixin'
import ExportButton from '@/components/ExportButton'


export default {
  name: 'Log',
  mixins: [exportMixin],
  components: {
    ExportButton
  },
  data() {
    return {
      // 表格数据
      tableData: [],
      loading: false,
      multipleSelection: [],

      // 搜索相关
      searchForm: {
        id: null,

        user: '',

        ip: '',

        method: '',

        path: '',

        params: '',

        status: "200",

        cost_time: null,

        create_time: [],

        log_type: 'INFO',

        error_msg: '',

        traceback: '',

      },
      searchParams: {},
      searchFields: [], // 当前选中的搜索字段，将在 mounted 中初始化
      defaultSearchFields: ["user","ip","method","path","params","log_type","error_msg","traceback"], // 默认搜索字段常量
      searchExpanded: false, // 搜索区域展开状态,

      // 分页相关
      pagination: {
        currentPage: 1,
        pageSize: 5,
        total: 0,
        pageSizeOptions: ['5', '10', '20', '50', '100'],
        showTotal: true,
        showSizeChanger: true,
        showQuickJumper: true
      },

      // 对话框相关
      dialogVisible: false,
      dialogType: 'add', // add | edit
      submitLoading: false,
      form: {
        username: undefined,
        user: undefined,
        ip: undefined,
        method: undefined,
        path: undefined,
        params: undefined,
        cost_time: undefined,
        create_time: undefined,
        log_type: 'INFO',
        error_msg: undefined,
        traceback: undefined,
      },
      rules: {
        status: [{ required: true, message: '请输入响应状态码', trigger: 'blur' }],

        create_time: [{ required: true, message: '请输入创建时间', trigger: 'blur' }],

        log_type: [{ required: true, message: '请输入日志类型', trigger: 'blur' }],

      },

      // API选项
      userOptions: [],


      // 外键选项
      sysuserOptions: [],
    }
  },
  computed: {
    dialogTitle() {
      return this.dialogType === 'add' ? '新增Log管理' : '编辑Log管理'
    }
  },
  mounted() {

    this.searchFields = [...this.defaultSearchFields]
    this.getList()
    if (typeof this.loadUserOptions === 'function') this.loadUserOptions()
    if (typeof this.loadSysuserOptions === 'function') this.loadSysuserOptions()
  },
  methods: {
    parseTime,
    // 获取列表数据
    async getList() {
      try {
        this.loading = true
        const params = { ...this.searchParams }
        params.page = this.pagination.currentPage
        params.page_size = this.pagination.pageSize
        const response = await getLogList(params)
        const rows = response.results || response.data?.results || response.data || response.list || []
        this.tableData = Array.isArray(rows) ? rows.map(row => this.normalizeRow(row)) : []
        this.pagination.total = response.count || response.data?.count || response.total || response.data?.total || 0
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
      this.searchParams = this.getSearchParams()
      this.pagination.currentPage = 1
      this.getList()
    },

    // 获取导出列头配置
    getExportHeaders() {
      return {'id': 'ID',
        'user': '操作用户',
        'ip': '访问IP',
        'method': '请求方式',
        'path': '请求路径',
        'params': '请求参数',
        'status': '响应状态码',
        'cost_time': '耗时(ms)',
        'create_time': '创建时间',
        'log_type': '日志类型',
        'error_msg': '错误信息',
        'traceback': '堆栈详情'
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
      this.searchFields = [...this.defaultSearchFields]
      this.pagination.currentPage = 1
      this.getList()
    },

    // 导出成功回调
    onExportSuccess() {
      this.$message.success('导出成功')
    },

    // 导出失败回调
    onExportError(error) {
      console.error('导出失败:', error)
      this.$message.error('导出失败')
    },

    // 新增
    handleCreate() {
      this.dialogType = 'add'
      this.form = {
        username: undefined,
        user: undefined,
        ip: undefined,
        method: undefined,
        path: undefined,
        params: undefined,
        cost_time: undefined,
        create_time: undefined,
        log_type: 'INFO',
        error_msg: undefined,
        traceback: undefined,
      }
      this.dialogVisible = true
    },

    // 编辑
    handleEdit(row) {
      this.dialogType = 'edit'
      this.form = { ...row }
      this.dialogVisible = true
    },

    // 删除
    async handleDelete(row) {
      try {
        await this.$confirm('确定要删除这条记录吗？', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        })
        await deleteLog(row.id)
        this.$message.success('删除成功')
        this.getList()
      } catch (error) {
        if (error !== 'cancel') {
          this.$message.error('删除失败')
        }
      }
    },

    // 批量删除
    async handleBatchDelete() {
      if (this.multipleSelection.length === 0) {
        this.$message.warning('请选择要删除的记录')
        return
      }
      try {
        await this.$confirm('确定要删除选中的记录吗？', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        })
        const ids = this.multipleSelection.map(item => item.id)
        // 这里需要根据实际API调整批量删除逻辑
        await Promise.all(ids.map(id => deleteLog(id)))
        this.$message.success('删除成功')
        this.getList()
      } catch (error) {
        if (error !== 'cancel') {
          this.$message.error('删除失败')
        }
      }
    },

    // 提交表单
    async handleSubmit() {
      try {
        await this.$refs.form.validate()
        this.submitLoading = true
        
        const payload = this.transformPayload(this.form)
        if (this.dialogType === 'add') {
          await createLog(payload)
          this.$message.success('新增成功')
        } else {
          await updateLog(this.form.id, payload)
          this.$message.success('更新成功')
        }
        
        this.dialogVisible = false
        this.getList()
      } catch (error) {
        this.$message.error(this.dialogType === 'add' ? '新增失败' : '更新失败')
      } finally {
        this.submitLoading = false
      }
    },

    // 对话框关闭
    handleDialogClose() {
      this.$refs.form.resetFields()
    },

    // 表格选择变化
    handleSelectionChange(selection) {
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
    },

    // 分页大小变化
    handleSizeChange(size) {
      this.pagination.pageSize = size
      this.pagination.currentPage = 1
      this.getList()
    },

    // 当前页变化
    handleCurrentChange(page) {
      this.pagination.currentPage = page
      this.getList()
    },

    // 导出数据获取方法
    exportLogList(params) {
      return getLogList(params)
    },

    // 获取导出配置
    getExportOptions() {
      return {
        filename: 'log_export',
        headers: {
          id: 'ID',
          user: '操作用户',
          ip: '访问IP',
          method: '请求方式',
          path: '请求路径',
          params: '请求参数',
          status: '响应状态码',
          cost_time: '耗时(ms)',
          create_time: '创建时间',
          log_type: '日志类型',
          error_msg: '错误信息',
          traceback: '堆栈详情'
        },
        sheetName: 'log数据'
      }
    },

    // 加载操作用户选项
    async loadSysuserOptions() {
      try {
        const response = await getUserList()
        const data = response.results || response.data?.results || response.data || response.list || []
        this.sysuserOptions = Array.isArray(data) ? data : []
      } catch (error) {
        console.error('加载操作用户选项失败:', error)
        this.$message.error('加载操作用户选项失败')
        this.sysuserOptions = []
      }
    },

    // 获取选择框选项标签
    getOptionLabel(fieldKey, value, row) {
      const optionsMap = {
        user: this.sysuserOptions,
      }
      const options = optionsMap[fieldKey] || []
      const option = options.find(opt => String(opt.value) === String(value) || String(opt.id) === String(value))
      
      // 对于外键字段，优先使用配置的显示回调字段
      if (option) {
        return option.username || option.name || option.label || value
      }
      return value
    }
  }
}
</script>

<style scoped>
.app-container { padding: 20px; }
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
}
</style>