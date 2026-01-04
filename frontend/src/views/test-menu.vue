<template>
  <div class="test-container">
    <h2>菜单调试页面</h2>
    
    <el-card class="box-card" style="margin-bottom: 20px;">
      <div slot="header" class="clearfix">
        <span>用户菜单数据 (menus)</span>
      </div>
      <pre>{{ JSON.stringify(menus, null, 2) }}</pre>
    </el-card>
    
    <el-card class="box-card" style="margin-bottom: 20px;">
      <div slot="header" class="clearfix">
        <span>权限路由 (permission_routes)</span>
      </div>
      <pre>{{ JSON.stringify(permissionRoutes, null, 2) }}</pre>
    </el-card>
    
    <el-card class="box-card" style="margin-bottom: 20px;">
      <div slot="header" class="clearfix">
        <span>添加的路由 (addRoutes)</span>
      </div>
      <pre>{{ JSON.stringify(addRoutes, null, 2) }}</pre>
    </el-card>
    
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>生成状态</span>
      </div>
      <p>Generated: {{ generated }}</p>
      <p>当前路由: {{ $route.path }}</p>
      <p>用户名: {{ name }}</p>
    </el-card>
    
    <el-card class="box-card" style="margin-top: 20px;">
      <div slot="header" class="clearfix">
        <span>手动测试</span>
      </div>
      <el-button @click="goToGenerator" type="primary">跳转到代码生成器</el-button>
      <el-button @click="refreshUserInfo" type="success">重新获取用户信息</el-button>
    </el-card>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'TestMenu',
  computed: {
    ...mapGetters([
      'menus',
      'permission_routes',
      'name'
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
    goToGenerator() {
      this.$router.push('/system/generator')
    },
    async refreshUserInfo() {
      try {
        await this.$store.dispatch('user/getInfo')
        this.$message.success('用户信息刷新成功')
      } catch (error) {
        this.$message.error('刷新失败: ' + error.message)
      }
    }
  }
}
</script>

<style scoped>
.test-container {
  padding: 20px;
}

pre {
  background-color: #f5f5f5;
  padding: 10px;
  border-radius: 4px;
  overflow-x: auto;
  max-height: 300px;
  font-size: 12px;
}
</style>