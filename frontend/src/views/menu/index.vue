<template>
  <div class="app-container">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>菜单管理</span>
      </div>
      <div class="filter-container">
        <el-button type="primary" icon="el-icon-plus" @click="handleAdd">新增</el-button>
      </div>
      <el-table
        :data="tableData"
        style="width: 100%"
        border
        row-key="id"
        :expand-row-keys="expandedRowKeys"
        :tree-props="{ children: 'children', hasChildren: 'hasChildren' }"
        :header-cell-style="{ textAlign: 'center' }"
      >
        <el-table-column
          prop="name"
          label="菜单名称"
          min-width="180"
          align="left"
        />
        <el-table-column
          prop="menu_type"
          label="菜单类型"
          min-width="90"
          align="center"
        >
          <template slot-scope="scope">
            <el-tag v-if="scope.row.menu_type === 'M'">目录</el-tag>
            <el-tag v-else-if="scope.row.menu_type === 'C'" type="success">菜单</el-tag>
            <el-tag v-else-if="scope.row.menu_type === 'F'" type="info">按钮</el-tag>
          </template>
        </el-table-column>
        <el-table-column
          prop="icon"
          label="图标"
          min-width="80"
          align="center"
        >
          <template slot-scope="scope">
            <i :class="scope.row.icon"></i>
          </template>
        </el-table-column>
        <el-table-column
          prop="id"
          label="菜单ID"
          min-width="80"
          align="center"
        />
        <el-table-column
          prop="path"
          label="路由路径"
          min-width="120"
          align="center"
        />
        <el-table-column
          prop="component"
          label="组件路径"
          min-width="140"
          align="center"
        />
        <el-table-column
          prop="perms"
          label="权限标识"
          min-width="120"
          align="center"
        />
        <el-table-column
          prop="order_num"
          label="排序"
          min-width="70"
          align="center"
        />
        <el-table-column
          prop="remark"
          label="备注"
          min-width="150"
          align="center"
        />
        <el-table-column
          label="操作"
          min-width="120"
          fixed="right"
          align="center"
        >
          <template slot-scope="scope">
            <el-button type="text" size="small" icon="el-icon-edit" @click="handleEdit(scope.row)">编辑</el-button>
            <el-button type="text" size="small" icon="el-icon-delete" style="color: #F56C6C" @click="handleDelete(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

    <el-dialog :title="dialogTitle" :visible.sync="dialogVisible" width="600px">
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="上级菜单" prop="parent">
           <el-cascader
            v-model="form.parent"
            :options="tableData"
            :props="{ checkStrictly: true, value: 'id', label: 'name', emitPath: false }"
            clearable
            style="width: 100%"
            placeholder="选择上级菜单，不选则为顶级菜单"
          />
        </el-form-item>
        <el-form-item label="菜单类型" prop="menu_type">
          <el-radio-group v-model="form.menu_type">
            <el-radio label="M">目录</el-radio>
            <el-radio label="C">菜单</el-radio>
            <el-radio label="F">按钮</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="菜单名称" prop="name">
          <el-input v-model="form.name" placeholder="请输入菜单名称" />
        </el-form-item>
        <el-form-item label="路由路径" prop="path" v-if="form.menu_type !== 'F'">
          <el-input v-model="form.path" placeholder="请输入路由路径" />
        </el-form-item>
        <el-form-item label="组件路径" prop="component" v-if="form.menu_type === 'C'">
          <el-input v-model="form.component" placeholder="请输入组件路径" />
        </el-form-item>
        <el-form-item label="权限标识" prop="perms" v-if="form.menu_type !== 'M'">
          <el-input v-model="form.perms" placeholder="请输入权限标识" />
        </el-form-item>
        <el-form-item label="图标" prop="icon" v-if="form.menu_type !== 'F'">
          <el-input v-model="form.icon" placeholder="请输入图标类名" />
        </el-form-item>
        <el-form-item label="排序" prop="order_num">
          <el-input-number v-model="form.order_num" :min="0" :max="999" controls-position="right" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入备注" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="submitForm">确 定</el-button>
      </div>
    </el-dialog>
    </el-card>
  </div>
</template>

<script>
import { getAllMenus, addMenu, updateMenu, deleteMenu } from '@/api/menu'

export default {
  name: 'Menu',
  data() {
    return {
      tableData: [],
      dialogVisible: false,
      dialogTitle: '新增菜单',
      form: {
        name: '',
        icon: '',
        path: '',
        component: '',
        perms: '',
        menu_type: 'M',
        order_num: 0,
        parent: null,
        remark: ''
      },
      rules: {
        name: [{ required: true, message: '请输入菜单名称', trigger: 'blur' }],
        path: [{ required: true, message: '请输入路由路径', trigger: 'blur' }],
        menu_type: [{ required: true, message: '请选择菜单类型', trigger: 'change' }]
      }
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    fetchData() {
      getAllMenus().then(response => {
        this.tableData = response.data
        this.expandedRowKeys = this.getExpandedKeys(this.tableData)
      })
    },
    getExpandedKeys(data) {
      let keys = []
      data.forEach(item => {
        if (item.menu_type === 'M') {
          keys.push(item.id)
          if (item.children && item.children.length > 0) {
            keys = keys.concat(this.getExpandedKeys(item.children))
          }
        }
      })
      return keys
    },
    handleAdd() {
      this.dialogTitle = '新增菜单'
      this.dialogVisible = true
      this.form = {
        name: '',
        icon: '',
        path: '',
        component: '',
        perms: '',
        menu_type: 'M',
        order_num: 0,
        parent: null,
        remark: ''
      }
      this.$nextTick(() => {
        this.$refs.form.clearValidate()
      })
    },
    handleEdit(row) {
      this.dialogTitle = '编辑菜单'
      this.dialogVisible = true
      this.form = { ...row }
      // 处理级联选择器数据回显
      // 注意：这里的parent应该是父级的id，如果后端返回的是对象需要做转换
      // 假设 row.parent 是父级ID或者 null
      this.$nextTick(() => {
        this.$refs.form.clearValidate()
      })
    },
    handleDelete(row) {
      this.$confirm('确认删除该菜单吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteMenu(row.id).then(() => {
          this.$message.success('删除成功')
          this.fetchData()
        })
      }).catch(() => {})
    },
    submitForm() {
      this.$refs.form.validate(valid => {
        if (valid) {
          // 处理空值，避免后端校验失败
          const data = { ...this.form }

          // 按钮类型默认图标
          if (data.menu_type === 'F') {
             data.icon = 'el-icon-mouse'
          }

          if (!data.icon) delete data.icon
          if (!data.path) delete data.path
          if (!data.component) delete data.component
          if (!data.perms) delete data.perms
          
          // 确保 parent 字段正确传递
          if (Array.isArray(data.parent)) {
            data.parent = data.parent[data.parent.length - 1]
          }

          // 如果后端需要 parent_id 字段
          if (data.parent) {
             data.parent_id = data.parent
             delete data.parent
          } else {
             delete data.parent
          }

          if (data.id) {
            updateMenu(data.id, data).then(() => {
              this.$message.success('更新成功')
              this.dialogVisible = false
              this.fetchData()
            })
          } else {
            addMenu(data).then(() => {
              this.$message.success('新增成功')
              this.dialogVisible = false
              this.fetchData()
            })
          }
        }
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.filter-container {
  padding-bottom: 10px;
}
</style>