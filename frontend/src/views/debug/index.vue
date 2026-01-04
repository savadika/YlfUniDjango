<template>
  <div class="debug-container">
    <h2>调试信息</h2>
    
    <el-card class="box-card" style="margin-bottom: 20px;">
      <div slot="header" class="clearfix">
        <span>用户菜单数据</span>
      </div>
      <pre>{{ JSON.stringify(menus, null, 2) }}</pre>
    </el-card>
    
    <el-card class="box-card" style="margin-bottom: 20px;">
      <div slot="header" class="clearfix">
        <span>Permission Routes</span>
      </div>
      <pre>{{ JSON.stringify(permissionRoutes, null, 2) }}</pre>
    </el-card>
    
    <el-card class="box-card" style="margin-bottom: 20px;">
      <div slot="header" class="clearfix">
        <span>Add Routes</span>
      </div>
      <pre>{{ JSON.stringify(addRoutes, null, 2) }}</pre>
    </el-card>
    
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>Generated Status</span>
      </div>
      <p>Generated: {{ generated }}</p>
    </el-card>
    
    <el-card class="box-card" style="margin-top: 20px;">
      <div slot="header" class="clearfix">
        <span>测试菜单数据生成</span>
      </div>
      <el-button @click="testMenuGeneration" type="primary">测试生成用户管理菜单</el-button>
    </el-card>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'Debug',
  computed: {
    ...mapGetters([
      'menus',
      'permission_routes'
    ]),
    permissionRoutes() {
      return this.permission_routes
    },
    addRoutes() {
      return this.$store.state.permission.addRoutes
    },
    generated() {
      return this.$store.state.permission.generated
    }
  },
  methods: {
    async testMenuGeneration() {
      // 模拟正确的菜单数据格式
      const testMenus = [
        {
          path: '/system',
          name: 'System',
          component: 'Layout',
          meta: {
            title: '系统管理',
            icon: 'el-icon-setting'
          },
          children: [
            {
              path: 'user',
              name: 'User',
              component: 'system/user/index',
              meta: {
                title: '用户管理',
                icon: 'user'
              }
            },
            {
              path: 'role',
              name: 'Role',
              component: 'system/role/index',
              meta: {
                title: '角色管理',
                icon: 'peoples'
              }
            },
            {
              path: 'menu',
              name: 'Menu',
              component: 'system/menu/index',
              meta: {
                title: '菜单管理',
                icon: 'tree'
              }
            }
          ]
        }
      ]
      
      console.log('测试菜单数据:', testMenus)
      
      // 手动触发路由生成
      try {
        await this.$store.dispatch('permission/generateRoutes', testMenus)
        console.log('路由生成成功')
        this.$message.success('测试菜单生成成功，请查看侧边栏')
      } catch (error) {
        console.error('路由生成失败:', error)
        this.$message.error('菜单生成失败: ' + error.message)
      }
    }
  }
}
</script>

<style scoped>
.debug-container {
  padding: 20px;
}

pre {
  background-color: #f5f5f5;
  padding: 10px;
  border-radius: 4px;
  overflow-x: auto;
  max-height: 300px;
}
</style>