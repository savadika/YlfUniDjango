<template>
  <div class="app-container">
    <!-- 页面标题 -->
    <div class="page-header">
      <h2>角色管理</h2>
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
                <el-checkbox label="name">角色名称</el-checkbox>
                <el-checkbox label="code">角色编码</el-checkbox>
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
                <el-col :span="8" v-if="searchFields.includes('name')">
                   <el-form-item label="角色名称" prop="name">
                    <el-input v-model="searchForm.name" placeholder="请输入角色名称" clearable size="small" style="width: 100%" />
                  </el-form-item>
                </el-col>
                <el-col :span="8" v-if="searchFields.includes('code')">
                   <el-form-item label="角色编码" prop="code">
                    <el-input v-model="searchForm.code" placeholder="请输入角色编码" clearable size="small" style="width: 100%" />
                  </el-form-item>
                </el-col>
                <el-col :span="8" v-if="searchFields.includes('remark')">
                   <el-form-item label="备注" prop="remark">
                    <el-input v-model="searchForm.remark" placeholder="请输入备注" clearable size="small" style="width: 100%" />
                  </el-form-item>
                </el-col>
              </el-row>
              <el-row :gutter="16" class="time-search-row">
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
      <el-button type="primary" icon="el-icon-plus" v-permission="['system:role:create']" @click="handleCreate">新增</el-button>
      <el-button type="danger" icon="el-icon-delete" v-permission="['system:role:deleteall']" @click="handleBatchDelete" :disabled="multipleSelection.length === 0">批量删除</el-button>
      <export-button :api-function="exportRoleList" :search-params="searchParams" :export-options="getExportOptions()" v-permission="['system:role:export']" @export-success="onExportSuccess" @export-error="onExportError" />
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
      <el-table-column prop="name" label="角色名称" align="center" />
      <el-table-column prop="code" label="角色编码" align="center" />
      <el-table-column prop="create_time" label="创建时间" align="center" />
      <el-table-column prop="update_time" label="更新时间" align="center" />
      <el-table-column prop="remark" label="备注" align="center" />
      <el-table-column label="操作" width="180" align="center" fixed="right">
        <template slot-scope="{ row }">
          <el-button type="text" size="small" v-permission="['system:role:edit']" @click="handleEdit(row)">编辑</el-button>
          <el-button type="text" size="small" v-permission="['system:role:delete']" style="color: #f56c6c" @click="handleDelete(row)">删除</el-button>
          <el-button type="text" size="small" v-permission="['system:role:permission']" @click="handleAssignPermissions(row)">权限分配</el-button>
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
        <el-form-item label="角色名称" prop="name">
          <el-input v-model="form.name" placeholder="请输入角色名称" />
        </el-form-item>
        <el-form-item label="角色编码" prop="code">
          <el-input v-model="form.code" placeholder="请输入角色编码" />
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

    <!-- 权限分配对话框 -->
    <el-dialog
      title="权限分配"
      :visible.sync="permissionDialogVisible"
      width="800px"
    >
      <div v-loading="permissionLoading">
        <el-tree
          ref="permissionTree"
          :data="permissionTreeData"
          node-key="id"
          show-checkbox
          :props="{ children: 'children', label: 'name' }"
          default-expand-all
        />
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button @click="permissionDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="saveRolePermissions" :loading="permissionSaving">保存</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { getRoleList, createRole, updateRole, deleteRole, getRoleDetail, updateRolePermissions, getRoleMenus } from '@/api/role'
import { getAllMenus } from '@/api/menu'
import exportMixin from '@/utils/exportMixin'
import ExportButton from '@/components/ExportButton'
import request from '@/utils/request'


export default {
  name: 'Role',
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
        name: '',

        code: '',

        create_time: [],

        update_time: [],

        remark: '',

      },
      searchParams: {},
      searchFields: [], // 当前选中的搜索字段，将在 mounted 中初始化
      defaultSearchFields: ["name","code","remark"], // 默认搜索字段常量
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
        name: undefined,
        code: undefined,
        create_time: undefined,
        update_time: undefined,
        remark: undefined,
      },
      rules: {
      }
      ,
      // 权限分配
      permissionDialogVisible: false,
      permissionLoading: false,
      permissionSaving: false,
      permissionTreeData: [],
      checkedPermissions: [],
      currentRoleId: null
    }
  },
  computed: {
    dialogTitle() {
      return this.dialogType === 'add' ? '新增角色管理' : '编辑角色管理'
    }
  },
  mounted() {

    this.searchFields = [...this.defaultSearchFields]
    this.getList()
  },
  methods: {
    // 获取列表数据
    async getList() {
      try {
        this.loading = true
        const params = { ...this.searchParams }
        params.page = this.pagination.currentPage
        params.page_size = this.pagination.pageSize
        const response = await getRoleList(params)
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
        'name': '角色名称',
        'code': '角色编码',
        'create_time': '创建时间',
        'update_time': '更新时间',
        'remark': '备注'
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
        name: undefined,
        code: undefined,
        create_time: undefined,
        update_time: undefined,
        remark: undefined,
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
        await deleteRole(row.id)
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
        await Promise.all(ids.map(id => deleteRole(id)))
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
          await createRole(payload)
          this.$message.success('新增成功')
        } else {
          await updateRole(this.form.id, payload)
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
    exportRoleList(params) {
      return getRoleList(params)
    },

    // 获取导出配置
    getExportOptions() {
      return {
        filename: 'role_export',
        headers: {
          id: 'ID',
          name: '角色名称',
          code: '角色编码',
          create_time: '创建时间',
          update_time: '更新时间',
          remark: '备注'
        },
        sheetName: 'role数据'
      }
    },

    // 获取选择框选项标签
    getOptionLabel(fieldKey, value, row) {
      const optionsMap = {
      }
      const options = optionsMap[fieldKey] || []
      const option = options.find(opt => opt.value === value || opt.id === value)
      
      // 对于外键字段，优先使用配置的显示回调字段
      if (option) {
        return option.label || option.name || value
      }
      return value
    },

    // 权限分配：打开对话框并加载数据
    async handleAssignPermissions(row) {
      if (row && row.id) {
        this.currentRoleId = row.id
      } else {
        if (this.multipleSelection.length !== 1) {
          this.$message.warning('请选择一个角色进行权限分配')
          return
        }
        this.currentRoleId = this.multipleSelection[0].id
      }
      this.permissionDialogVisible = true
      await this.loadPermissions()
    },

    // 从已生成的路由构造系统管理模块的权限树
    buildPermissionTreeFromRoutes(routes) {
      const toNode = (route) => {
        if (route.hidden) return null
        const node = {
          id: route.name || route.path,
          label: (route.meta && route.meta.title) || route.name || route.path,
          children: []
        }
        if (Array.isArray(route.children) && route.children.length) {
          node.children = route.children.map(toNode).filter(Boolean)
        }
        return node
      }
      // 仅提取系统管理相关模块（路径包含 /system 或名称包含 system）
      const systemRoutes = routes.filter(r => (r.path && r.path.indexOf('/system') === 0) || /system/i.test(String(r.name || '')))
      const tree = systemRoutes.map(toNode).filter(Boolean)
      return tree
    },

    // 辅助方法：获取树的所有叶子节点 ID
    getAllLeafIds(treeData) {
      const leafIds = []
      const traverse = (nodes) => {
        nodes.forEach(node => {
          if (!node.children || node.children.length === 0) {
            leafIds.push(node.id)
          } else {
            traverse(node.children)
          }
        })
      }
      traverse(treeData)
      return leafIds
    },

    // 加载权限选项与角色已分配的权限
    async loadPermissions() {
      try {
        this.permissionLoading = true
        
        // 并行请求：获取全量菜单（树骨架）和角色已有权限
        const [allMenusRes, roleMenusRes] = await Promise.all([
          getAllMenus(),
          getRoleMenus(this.currentRoleId)
        ])

        // 1. 处理全量菜单树
        // 兼容后端可能返回 { code: 200, data: [...] } 或直接 [...] 的情况
        const allMenusData = allMenusRes.data || allMenusRes
        this.permissionTreeData = allMenusData
        
        // 2. 处理角色已有权限
        const roleData = roleMenusRes.data || roleMenusRes
        // 后端返回结构为 { menus: [...], permissions: [...] }
        // 树形结构的勾选状态应该完全基于 menus 字段中的 ID
        const ownedMenus = roleData.menus || []

        // 3. 计算需要打钩的叶子节点
        // 提取所有已拥有菜单的ID (包括目录、菜单、按钮)
        const ownedMenuIds = []
        const extractIds = (list) => {
          if (!Array.isArray(list)) return
          list.forEach(item => {
            ownedMenuIds.push(item.id)
            if (item.children && item.children.length) {
              extractIds(item.children)
            }
          })
        }
        extractIds(ownedMenus)

        // Element UI Tree 的机制：如果勾选了父节点，所有子节点都会被自动勾选
        // 因此，我们只需要设置“真正选中的叶子节点”的ID
        // 如果后端返回了父节点ID，但子节点没有全选，我们不能把父节点ID设置进去，否则子节点会变成全选状态
        
        // 1. 获取所有叶子节点ID
        const allLeafIds = this.getAllLeafIds(this.permissionTreeData)
        
        // 2. 筛选出 用户拥有的 且是 叶子节点 的ID
        // 关键修正：checkedLeafIds 必须使用 treeData 中的原始 ID 值（包括类型），否则 el-tree 无法匹配
        const checkedLeafIds = []
        allLeafIds.forEach(leafId => {
          // 使用宽松比较或统一转字符串比较来判断是否存在
          const exists = ownedMenuIds.some(ownedId => String(ownedId) === String(leafId))
          if (exists) {
            checkedLeafIds.push(leafId) // push 的是 leafId，保证类型与树节点一致
          }
        })
        
        this.checkedPermissions = checkedLeafIds
        
        // 显式设置选中状态
        this.$nextTick(() => {
          if (this.$refs.permissionTree) {
            this.$refs.permissionTree.setCheckedKeys(checkedLeafIds)
          }
        })

      } catch (e) {
        console.error('获取权限数据失败', e)
        this.$message.error('加载权限数据失败')
        this.checkedPermissions = []
      } finally {
        this.permissionLoading = false
      }
    },

    // 保存角色权限分配（提交选中的权限ID）
    async saveRolePermissions() {
      try {
        this.permissionSaving = true
        const checked = (this.$refs.permissionTree && this.$refs.permissionTree.getCheckedKeys) ? this.$refs.permissionTree.getCheckedKeys() : []
        const halfChecked = (this.$refs.permissionTree && this.$refs.permissionTree.getHalfCheckedKeys) ? this.$refs.permissionTree.getHalfCheckedKeys() : []
        const permissions = Array.from(new Set([ ...checked, ...halfChecked ]))

        await request({
          url: `/role/${this.currentRoleId}/permissions`,
          method: 'put',
          data: { permissions }
        })
        this.$message.success('权限已保存')
        this.permissionDialogVisible = false
      } catch (error) {
        this.$message.error('保存权限失败')
      } finally {
        this.permissionSaving = false
      }
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