<template>
  <div class="app-container">
    <!-- 页面标题 -->
    <div class="page-header">
      <h2>用户管理</h2>
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
                <el-checkbox label="department">部门</el-checkbox>
                <el-checkbox label="username">用户名</el-checkbox>
                <el-checkbox label="avatar">头像</el-checkbox>
                <el-checkbox label="email">电子邮件</el-checkbox>
                <el-checkbox label="phone">电话号码</el-checkbox>
                <el-checkbox label="login_date">最后登录时间</el-checkbox>
                <el-checkbox label="status">状态</el-checkbox>
                <el-checkbox label="create_time">创建时间</el-checkbox>
                <el-checkbox label="update_time">更新时间</el-checkbox>
                <el-checkbox label="remark">备注</el-checkbox>
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
                <el-col :span="8" v-if="searchFields.includes('department')">
                   <el-form-item label="部门" prop="department">
                    <el-select v-model="searchForm.department" placeholder="请选择部门" clearable filterable style="width: 100%" size="small">
                      <el-option label="全部" value="" />
                      <el-option
                        v-for="item in departmentOptions"
                        :key="item.id"
                        :label="item.dep_name"
                        :value="item.id"
                      />
                    </el-select>
                  </el-form-item>
                </el-col>
                <el-col :span="8" v-if="searchFields.includes('username')">
                   <el-form-item label="用户名" prop="username">
                    <el-input v-model="searchForm.username" placeholder="请输入用户名" clearable size="small" />
                  </el-form-item>
                </el-col>
                <el-col :span="8" v-if="searchFields.includes('avatar')">
                   <el-form-item label="头像" prop="avatar">
                    <el-input v-model="searchForm.avatar" placeholder="请输入头像" clearable size="small" />
                  </el-form-item>
                </el-col>
                <el-col :span="8" v-if="searchFields.includes('email')">
                   <el-form-item label="电子邮件" prop="email">
                    <el-input v-model="searchForm.email" type="email" placeholder="请输入电子邮件" clearable size="small" />
                  </el-form-item>
                </el-col>
                <el-col :span="8" v-if="searchFields.includes('phone')">
                   <el-form-item label="电话号码" prop="phone">
                    <el-input v-model="searchForm.phone" placeholder="请输入电话号码" clearable size="small" />
                  </el-form-item>
                </el-col>
                <el-col :span="8" v-if="searchFields.includes('status')">
                   <el-form-item label="状态" prop="status">
                    <el-select v-model="searchForm.status" placeholder="请选择状态" clearable filterable style="width: 100%" size="small">
                      <el-option label="全部" value="" />
                      <el-option label="正常" value="1" />
                      <el-option label="禁用" value="0" />
                    </el-select>
                  </el-form-item>
                </el-col>
                <el-col :span="8" v-if="searchFields.includes('remark')">
                   <el-form-item label="备注" prop="remark">
                    <el-input v-model="searchForm.remark" placeholder="请输入备注" clearable size="small" />
                  </el-form-item>
                </el-col>
              </el-row>
              <el-row :gutter="16" class="time-search-row">
                <el-col :span="8" v-if="searchFields.includes('login_date')">
                   <el-form-item label="最后登录时间" prop="login_date">
                    <el-date-picker v-model="searchForm.login_date" type="daterange" range-separator="至" start-placeholder="开始日期" end-placeholder="结束日期" style="width: 100%" value-format="yyyy-MM-dd" clearable unlink-panels size="small" />
                  </el-form-item>
                </el-col>
                <el-col :span="8" v-if="searchFields.includes('create_time')">
                   <el-form-item label="创建时间" prop="create_time">
                    <el-date-picker v-model="searchForm.create_time" type="daterange" range-separator="至" start-placeholder="开始日期" end-placeholder="结束日期" style="width: 100%" value-format="yyyy-MM-dd" clearable unlink-panels size="small" />
                  </el-form-item>
                </el-col>
                <el-col :span="8" v-if="searchFields.includes('update_time')">
                   <el-form-item label="更新时间" prop="update_time">
                    <el-date-picker v-model="searchForm.update_time" type="daterange" range-separator="至" start-placeholder="开始日期" end-placeholder="结束日期" style="width: 100%" value-format="yyyy-MM-dd" clearable unlink-panels size="small" />
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
      <el-button type="primary" icon="el-icon-plus" v-permission="['system:user:add']" @click="handleCreate">新增</el-button>
      <el-button type="danger" icon="el-icon-delete" v-permission="['system:user:deleteall']" @click="handleBatchDelete" :disabled="multipleSelection.length === 0">批量删除</el-button>

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
      <el-table-column prop="username" label="用户名" align="center" />
      <el-table-column prop="avatar" label="头像" align="center">
        <template slot-scope="{ row }">
          <el-image 
            v-if="row.avatar" 
            :src="getAvatarUrl(row.avatar)" 
            :preview-src-list="[getAvatarUrl(row.avatar)]" 
            style="width: 40px; height: 40px; border-radius: 50%" 
            fit="cover"
          >
            <div slot="error" class="image-slot">
              <i class="el-icon-user-solid" style="font-size: 20px; line-height: 40px; color: #909399"></i>
            </div>
          </el-image>
          <span v-else>无</span>
        </template>
      </el-table-column>
      <el-table-column label="角色" align="center">
        <template slot-scope="{ row }">
          {{ getRoleName(row) }}
        </template>
      </el-table-column>
      <el-table-column prop="department" label="部门" align="center">
        <template slot-scope="{ row }">
          {{ getOptionLabel('department', row.department, row) }}
        </template>
      </el-table-column>
      <el-table-column prop="email" label="电子邮件" align="center" />
      <el-table-column prop="phone" label="电话号码" align="center" />
      <el-table-column prop="login_date" label="最后登录时间" align="center" />
      <el-table-column prop="status" label="状态" align="center">
        <template slot-scope="{ row }">
          {{ getOptionLabel('status', row.status, row) }}
        </template>
      </el-table-column>
      <el-table-column prop="create_time" label="创建时间" align="center" />
      <el-table-column prop="update_time" label="更新时间" align="center" />
      <el-table-column label="操作" width="180" align="center" fixed="right">
        <template slot-scope="{ row }">
          <el-button type="text" size="small" v-permission="['system:user:update']" @click="handleEdit(row)">编辑</el-button>
          <el-button type="text" size="small" style="color: #f56c6c" v-permission="['system:user:delete']" @click="handleDelete(row)">删除</el-button>
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
        <el-form-item label="部门" prop="department">
          <el-select v-model="form.department" placeholder="请选择部门" style="width: 100%">
            <el-option
              v-for="item in departmentOptions"
              :key="item.id"
              :label="item.dep_name"
              :value="item.id"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="角色" prop="roles">
          <el-select 
            v-model="form.roles" 
            placeholder="请选择角色" 
            style="width: 100%"
            @change="$forceUpdate()"
          >
            <el-option
              v-for="item in roleOptions"
              :key="item.id"
              :label="item.remark || item.name"
              :value="item.id"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="用户名" prop="username">
          <el-input v-model="form.username" placeholder="请输入用户名" />
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="form.password" placeholder="请输入密码" />
        </el-form-item>
        <el-form-item label="头像" prop="avatar">
          <el-upload
            class="avatar-uploader"
            action=""
            :show-file-list="false"
            :http-request="uploadAvatar"
            :before-upload="beforeAvatarUpload">
            <img v-if="form.avatar" :key="form.avatar" :src="getAvatarUrl(form.avatar)" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-form-item>
        <el-form-item label="电子邮件" prop="email">
          <el-input v-model="form.email" type="email" placeholder="请输入电子邮件" />
        </el-form-item>
        <el-form-item label="电话号码" prop="phone">
          <el-input v-model="form.phone" placeholder="请输入电话号码" />
        </el-form-item>
        <el-form-item label="最后登录时间" prop="login_date">
          <el-date-picker v-model="form.login_date" type="date" placeholder="请选择最后登录时间" style="width: 100%" value-format="yyyy-MM-dd" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="form.status" placeholder="请选择状态" style="width: 100%">
            <el-option label="正常" value="1" />
            <el-option label="禁用" value="0" />
          </el-select>
        </el-form-item>
        <el-form-item label="创建时间" prop="create_time">
          <el-date-picker v-model="form.create_time" type="date" placeholder="请选择创建时间" style="width: 100%" value-format="yyyy-MM-dd" />
        </el-form-item>
        <el-form-item label="更新时间" prop="update_time">
          <el-date-picker v-model="form.update_time" type="date" placeholder="请选择更新时间" style="width: 100%" value-format="yyyy-MM-dd" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" placeholder="请输入备注" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleSubmit" :loading="submitLoading">确定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { getUserList, createUser, updateUser, deleteUser, patchUser, getUserDetail } from '@/api/user'
import { getDepartmentList } from '@/api/department'
import { getRoleList } from '@/api/role'
import request from '@/utils/request'
import { uploadFile } from '@/api/upload'

export default {
  name: 'User',
  components: {
    
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

        department: '',

        username: '',

        avatar: '',

        email: '',

        phone: '',

        login_date: [],

        status: "1",

        create_time: [],

        update_time: [],

        remark: '',

      },
      searchParams: {},
      searchFields: ["department","username","avatar","email","phone","status","remark"], // 当前选中的搜索字段
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
        department: undefined,

        username: undefined,

        password: undefined,

        avatar: undefined,

        email: undefined,

        phone: undefined,

        login_date: undefined,

        create_time: undefined,

        update_time: undefined,

        remark: undefined,

      },
      rules: {
        username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
        password: [{ required: true, message: '请输入密码', trigger: 'blur' }],
        email: [{ required: true, message: '请输入电子邮件', trigger: 'blur' }],
      },

      // 选择框选项
      statusOptions: [{"value":1,"label":"正常"},{"value":0,"label":"禁用"}],


      // API选项

      // 外键选项
      departmentOptions: [],
      roleOptions: [],
    }
  },
  computed: {
    dialogTitle() {
      return this.dialogType === 'add' ? '新增用户管理' : '编辑用户管理'
    }
  },
  mounted() {

    this.getList()
    if (typeof this.loadDepartmentOptions === 'function') this.loadDepartmentOptions()
    this.loadRoleOptions()
  },
  methods: {
    // 获取列表数据
    async getList() {
      try {
        this.loading = true
        const params = { ...this.searchParams }
        params.page = this.pagination.currentPage
        params.page_size = this.pagination.pageSize
        const response = await getUserList(params)
        const rows = response.results || response.data?.results || response.data || response.list || []
        this.tableData = Array.isArray(rows) ? rows.map(row => this.normalizeRow(row)) : []
        this.pagination.total = response.count || response.data?.count || response.total || response.data?.total || 0

        // 补全角色信息：如果列表中没有角色信息，则单独获取详情
        if (this.tableData.length > 0) {
          const promises = this.tableData.map(async (row, index) => {
            // 如果 roles 为空或不存在，尝试获取详情
            if (!row.roles || row.roles.length === 0) {
              try {
                const detail = await getUserDetail(row.id)
                const detailData = detail.data || detail
                // 尝试多种字段名
                const roles = detailData.roles || detailData.role || detailData.role_ids || []
                if (roles && roles.length > 0) {
                  this.$set(this.tableData[index], 'roles', roles)
                }
              } catch (e) {
                // 忽略详情获取失败，避免阻塞列表显示
              }
            }
          })
          // 不阻塞主流程，异步更新
          Promise.all(promises)
        }
      } catch (error) {
        this.$message.error('获取数据失败')
      } finally {
        this.loading = false
      }
    },

    // 获取头像完整URL
    getAvatarUrl(url) {
      if (!url) return ''
      if (url.startsWith('http') || url.startsWith('https') || url.startsWith('blob:')) return url
      const baseUrl = process.env.VUE_APP_BASE_IMG_URL || ''
      const cleanPath = url.startsWith('/') ? url.slice(1) : url
      const cleanBase = baseUrl.endsWith('/') ? baseUrl.slice(0, -1) : baseUrl
      return cleanBase ? `${cleanBase}/${cleanPath}` : url
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
      this.pagination.currentPage = 1
      this.getList()
    },

    // 新增
    handleCreate() {
      this.dialogType = 'add'
      // 新增时密码必填
      this.rules.password = [{ required: true, message: '请输入密码', trigger: 'blur' }]
      this.form = {
        department: undefined,

        username: undefined,

        password: undefined,

        avatar: undefined,

        email: undefined,

        phone: undefined,

        login_date: undefined,

        create_time: undefined,

        update_time: undefined,

        remark: undefined,

        roles: undefined
      }
      this.dialogVisible = true
      // 确保角色列表已加载
      if (this.roleOptions.length === 0) {
        this.loadRoleOptions()
      }
    },

    // 编辑
    handleEdit(row) {
      this.dialogType = 'edit'
      // 编辑时密码非必填（留空不修改）
      this.rules.password = [{ required: false, trigger: 'blur' }]
      // 深度拷贝，避免直接修改 row 引用
      const formData = JSON.parse(JSON.stringify(row))
      // 处理角色数据：提取 ID
      let roleId = null
      if (Array.isArray(formData.roles) && formData.roles.length > 0) {
        // 如果元素是对象，提取ID
        if (typeof formData.roles[0] === 'object') {
          roleId = formData.roles[0].id
        } else {
          // 如果是字符串（角色名），尝试在 roleOptions 中查找对应的 ID
          const roleName = formData.roles[0]
          // 确保 roleOptions 已加载（虽然这里可能还是空的，如果没加载完）
          if (this.roleOptions.length > 0) {
              const matchedRole = this.roleOptions.find(r => r.name === roleName || r.remark === roleName)
              if (matchedRole) {
                  roleId = matchedRole.id
              } else {
                  // 如果找不到，可能就是 ID（虽然看起来像名字），或者数据有问题
                  // 此时保留原值，让用户重新选，或者置空
                  roleId = null 
              }
          } else {
              // 如果 roleOptions 为空，先暂存名字，等 loadRoleOptions 完成后再匹配？
              // 或者直接发请求获取？
              // 这里简化处理：如果是非数字，且不是对象，那多半是名字，我们尝试匹配一下
              // 但由于 roleOptions 是异步加载的，这里最好等待
              // 为简单起见，我们在 mounted 里已经加载了 roleOptions
              // 如果还没加载到，可能需要重新触发一下，但通常此时已加载
              // 假设如果是纯数字字符串，直接用
              if (!isNaN(Number(roleName))) {
                  roleId = Number(roleName)
              }
          }
        }
      }
      
      this.form = formData
      // 使用 $set 显式设置 roles 属性，确保响应式
      this.$set(this.form, 'roles', roleId)

      this.dialogVisible = true
      // 确保角色列表已加载
      if (this.roleOptions.length === 0) {
        this.loadRoleOptions().then(() => {
             // 加载完后再尝试匹配一次
             if (roleId === null && Array.isArray(formData.roles) && formData.roles.length > 0) {
                 const roleName = formData.roles[0]
                 if (typeof roleName !== 'object') {
                      const matchedRole = this.roleOptions.find(r => r.name === roleName || r.remark === roleName)
                      if (matchedRole) {
                          this.$set(this.form, 'roles', matchedRole.id)
                      }
                 }
             }
        })
      }
    },

    // 删除
    async handleDelete(row) {
      try {
        await this.$confirm('确定要删除这条记录吗？', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        })
        await deleteUser(row.id)
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
        await Promise.all(ids.map(id => deleteUser(id)))
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
        
        // 确保 roles 是数组格式（即使用户只选了一个，后端可能期望列表）
        // 如果后端支持直接传单个ID，则不需要这一步，但通常角色是多对多关系，建议包装成数组
        // 由于我们将表单改成了单选，这里手动包装
        const formToSubmit = { ...this.form }
        
        // 关键修复：只有当用户真正修改了角色（即 roles 不为 undefined/null）时，才处理 roles 字段
        // 如果 roles 还是 undefined（例如编辑时未触碰且未正确回显），则不应该包含在提交中，以免覆盖原有角色
        // 但我们在 handleEdit 中已经做了回显，所以这里主要是确保如果有值，转换正确
        if (formToSubmit.roles !== undefined && formToSubmit.roles !== null && formToSubmit.roles !== '') {
             // 确保是数字类型
             const roleId = Number(formToSubmit.roles)
             if (!isNaN(roleId)) {
                formToSubmit.roles = [roleId]
             } else {
                // 如果转换失败，可能是对象或其他非法值，尝试取 id 属性
                if (typeof formToSubmit.roles === 'object' && formToSubmit.roles.id) {
                     formToSubmit.roles = [Number(formToSubmit.roles.id)]
                } else {
                     // 如果无法解析且不为空，可能是异常数据，置为空数组
                     formToSubmit.roles = []
                }
             }
        } else {
            // 如果表单中 roles 为空，说明用户清空了角色或未选择
            // 如果是编辑模式，且原数据有角色，这代表删除角色
            // 如果是新增模式，代表不设角色
            formToSubmit.roles = []
        }

        const payload = this.transformPayload(formToSubmit)
        if (this.dialogType === 'add') {
          const res = await createUser(payload)
          // 尝试补更角色信息（如果后端创建接口未处理角色字段）
          if (payload.roles && payload.roles.length > 0) {
            const newUserId = res.id || (res.data && res.data.id) || (res.results && res.results.id)
            if (newUserId) {
              try {
                // 根据DRF规范，可能需要使用 partial update
                await patchUser(newUserId, { roles: payload.roles })
              } catch (err) {
                console.warn('补更角色失败', err)
              }
            }
          }
          this.$message.success('新增成功')
        } else {
          // 更新时也尝试补更角色（针对PUT可能不处理角色字段的情况）
          await updateUser(this.form.id, payload)
          // 再次检查并更新角色
          // 只有当 payload 中确实包含 roles 字段时才尝试 patch
          if (Object.prototype.hasOwnProperty.call(payload, 'roles')) {
             try {
                await patchUser(this.form.id, { roles: payload.roles })
             } catch (err) {
                console.warn('更新角色失败', err)
             }
          }
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

      // 处理头像路径：如果是完整URL，尝试转为相对路径（参考 Navbar.vue）
      if (payload.avatar) {
        // 主要是处理完整域名的情况
        const baseUrl = process.env.VUE_APP_BASE_IMG_URL || ''
        const cleanBase = baseUrl.endsWith('/') ? baseUrl.slice(0, -1) : baseUrl
        
        // 如果 avatar 包含 baseUrl，则去除 baseUrl
        if (cleanBase && payload.avatar.startsWith(cleanBase)) {
           // payload.avatar = http://localhost:8000/media/avatars/xxx.jpg
           // cleanBase = http://localhost:8000/media
           // replace 后变成 /avatars/xxx.jpg
           payload.avatar = payload.avatar.replace(cleanBase, '')
        }
        
        // 再次确保去除开头的 / (如果 replace 后剩下的路径以 / 开头)
        if (payload.avatar.startsWith('/')) {
            payload.avatar = payload.avatar.slice(1)
        }
      }

      // 清理空值，避免发送空字符串/空数组/undefined
      // 注意：不能删除 roles，即便是空数组也要保留
      Object.keys(payload).forEach((k) => {
        const v = payload[k]
        // 允许 roles 为空数组，不被删除
        if (k === 'roles') return
        
        // 修改逻辑：对于编辑（update）操作，通常只提交变更字段，或者全量提交。
        // 但如果某些字段本身就是 undefined（例如密码在编辑时未填），则应删除。
        // 对于空字符串，视情况而定，这里保持原逻辑删除
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

    // 加载部门选项
    async loadDepartmentOptions() {
      try {
        const response = await getDepartmentList()
        const data = response.results || response.data?.results || response.data || response.list || []
        this.departmentOptions = Array.isArray(data) ? data : []
      } catch (error) {
        console.error('加载部门选项失败:', error)
        this.$message.error('加载部门选项失败')
        this.departmentOptions = []
      }
    },

    // 加载角色选项
    async loadRoleOptions() {
      try {
        // 获取所有角色，不分页
        const response = await getRoleList({ page: 1, size: 1000 }) 
        const data = response.results || response.data?.results || response.data || response.list || []
        this.roleOptions = Array.isArray(data) ? data : []
      } catch (error) {
        console.error('加载角色选项失败:', error)
        this.roleOptions = []
      }
    },

    // 获取角色名称
    getRoleName(row) {
      // 兼容直接传数组的情况，也支持传行对象自动查找字段
      let roles = []
      if (Array.isArray(row)) {
        roles = row
      } else if (row && typeof row === 'object') {
        roles = row.roles || row.role || row.role_ids || []
      }

      if (!roles || roles.length === 0) return '暂无角色'
      
      const roleList = Array.isArray(roles) ? roles : [roles]
      
      const names = roleList.map(role => {
        // 1. 优先使用对象自带的名称 (remark > name)
        if (role && typeof role === 'object') {
           if (role.remark) return role.remark
           if (role.name) return role.name
        }
        
        // 2. 查找 roleOptions
        const roleId = (role && typeof role === 'object') ? role.id : role
        if (this.roleOptions && this.roleOptions.length > 0) {
            const roleOption = this.roleOptions.find(opt => String(opt.id) === String(roleId))
            if (roleOption) return roleOption.remark || roleOption.name
        }
        
        // 3. 降级显示 ID
        return roleId
      })
      
      return names.join(', ')
    },

    // 获取选择框选项标签
    getOptionLabel(fieldKey, value, row) {
      const optionsMap = {
        department: this.departmentOptions,
      }
      const options = optionsMap[fieldKey] || []
      const option = options.find(opt => String(opt.value) === String(value) || String(opt.id) === String(value))
      
      // 对于外键字段，优先使用配置的显示回调字段
      if (option) {
        return option.dep_name || option.name || option.label || value
      }
      return value
    },
    beforeAvatarUpload(file) {
      const isJPG = file.type === 'image/jpeg' || file.type === 'image/png' || file.type === 'image/gif'
      const isLt2M = file.size / 1024 / 1024 < 2

      if (!isJPG) {
        this.$message.error('上传头像图片只能是 JPG/PNG/GIF 格式!')
      }
      if (!isLt2M) {
        this.$message.error('上传头像图片大小不能超过 2MB!')
      }
      return isJPG && isLt2M
    },
    async uploadAvatar(param) {
      const formData = new FormData()
      formData.append('file', param.file)
      try {
        const response = await uploadFile(formData)
        // 简化后的逻辑：直接取 response.data.url
        if (response.data && response.data.url) {
          this.form.avatar = response.data.url
          this.$message.success('头像上传成功')
        } else {
           this.$message.error('无法解析上传返回结果')
        }
      } catch (error) {
        console.error('上传失败:', error)
        this.$message.error('上传失败')
      }
    }
  }
}
</script>

<style scoped>
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
}
.avatar {
  width: 178px;
  height: 178px;
  display: block;
  object-fit: cover;
  border-radius: 6px;
}
</style>

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