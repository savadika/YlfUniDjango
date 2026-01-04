<template>
  <div class="navbar">
    <hamburger :is-active="sidebar.opened" class="hamburger-container" @toggleClick="toggleSideBar" />

    <breadcrumb class="breadcrumb-container" />

    <div class="right-menu">
      <el-dropdown class="avatar-container" trigger="click">
        <div class="avatar-wrapper">
          <!-- 使用key强制重新渲染 -->
          <img :key="avatar" :src="getAvatarUrl(avatar)" class="user-avatar">
          <span class="user-name">{{ name }}</span>
          <i class="el-icon-caret-bottom" />
        </div>
        <el-dropdown-menu slot="dropdown" class="user-dropdown">
          <el-dropdown-item @click.native="openProfile">
            <span style="display:block;">个人中心</span>
          </el-dropdown-item>
          <el-dropdown-item divided @click.native="logout">
            <span style="display:block;">退出</span>
          </el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </div>

    <!-- 个人中心对话框 -->
    <el-dialog title="个人中心" :visible.sync="dialogVisible" width="500px" append-to-body>
      <el-form ref="profileForm" :model="profileForm" :rules="profileRules" label-width="100px">
        <el-form-item label="头像" prop="avatar">
          <el-upload
            class="avatar-uploader"
            action=""
            :show-file-list="false"
            :http-request="uploadAvatar"
            :before-upload="beforeAvatarUpload">
            <img v-if="profileForm.avatar" :src="getAvatarUrl(profileForm.avatar)" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
          <div class="el-upload__tip">只能上传jpg/png/gif文件，且不超过2MB</div>
        </el-form-item>
        <el-form-item label="新密码" prop="password">
          <el-input v-model="profileForm.password" type="password" placeholder="请输入新密码（留空不修改）" />
        </el-form-item>
        <el-form-item label="确认密码" prop="confirmPassword">
          <el-input v-model="profileForm.confirmPassword" type="password" placeholder="请再次输入新密码" />
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="updateProfile">确认</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Breadcrumb from '@/components/Breadcrumb'
import Hamburger from '@/components/Hamburger'
import { patchUser } from '@/api/user'
import { uploadFile } from '@/api/upload'

export default {
  components: {
    Breadcrumb,
    Hamburger
  },
  computed: {
    ...mapGetters([
      'sidebar',
      'avatar',
      'name',
      'id'
    ])
  },
  data() {
    const validateConfirmPassword = (rule, value, callback) => {
      if (this.profileForm.password && value !== this.profileForm.password) {
        callback(new Error('两次输入的密码不一致'))
      } else {
        callback()
      }
    }
    return {
      dialogVisible: false,
      profileForm: {
        avatar: '',
        password: '',
        confirmPassword: ''
      },
      profileRules: {
        confirmPassword: [
          { validator: validateConfirmPassword, trigger: 'blur' }
        ]
      }
    }
  },
  mounted() {
    
  },
  methods: {
    toggleSideBar() {
      this.$store.dispatch('app/toggleSideBar')
    },
    async logout() {
      await this.$store.dispatch('user/logout')
      this.$router.push(`/login?redirect=${this.$route.fullPath}`)
    },
    openProfile() {
      this.profileForm.avatar = this.avatar
      this.profileForm.password = ''
      this.profileForm.confirmPassword = ''
      this.dialogVisible = true
      this.$nextTick(() => {
        this.$refs.profileForm.clearValidate()
      })
    },
    updateProfile() {
      this.$refs.profileForm.validate(async valid => {
        if (valid) {
          try {
            const data = { avatar: this.profileForm.avatar }
            if (this.profileForm.password) {
              data.password = this.profileForm.password
            }
            
            if (!this.id) {
               this.$message.error('无法获取用户ID，请重新登录')
               return
            }

            await patchUser(this.id, data)
            this.$message.success('修改成功')
            
            // Update local store avatar
            // 注意：因为 Navbar 右上角使用了 getAvatarUrl(avatar) 进行展示
            // 所以这里直接 commit 相对路径即可，页面会自动更新
            this.$store.commit('user/SET_AVATAR', this.profileForm.avatar)
            
            this.dialogVisible = false
          } catch (error) {
            console.error(error)
          }
        }
      })
    },
    getAvatarUrl(url) {
      if (!url) return ''
      if (url.startsWith('http') || url.startsWith('https') || url.startsWith('blob:')) return url
      const baseUrl = process.env.VUE_APP_BASE_IMG_URL || ''
      const cleanPath = url.startsWith('/') ? url.slice(1) : url
      const cleanBase = baseUrl.endsWith('/') ? baseUrl.slice(0, -1) : baseUrl
      return cleanBase ? `${cleanBase}/${cleanPath}` : url
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
          this.profileForm.avatar = response.data.url
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

<style lang="scss" scoped>
.navbar {
  height: 50px;
  overflow: hidden;
  position: relative;
  background: #fff;
  box-shadow: 0 1px 4px rgba(0,21,41,.08);

  .hamburger-container {
    line-height: 46px;
    height: 100%;
    float: left;
    cursor: pointer;
    transition: background .3s;
    -webkit-tap-highlight-color:transparent;

    &:hover {
      background: rgba(0, 0, 0, .025)
    }
  }

  .breadcrumb-container {
    float: left;
  }

  .right-menu {
    float: right;
    height: 100%;
    line-height: 50px;

    &:focus {
      outline: none;
    }

    .right-menu-item {
      display: inline-block;
      padding: 0 8px;
      height: 100%;
      font-size: 18px;
      color: #5a5e66;
      vertical-align: text-bottom;

      &.hover-effect {
        cursor: pointer;
        transition: background .3s;

        &:hover {
          background: rgba(0, 0, 0, .025)
        }
      }
    }

    .avatar-container {
      margin-right: 30px;

      .avatar-wrapper {
        margin-top: 5px;
        position: relative;
        display: flex;
        align-items: center;

        .user-avatar {
          cursor: pointer;
          width: 40px;
          height: 40px;
          border-radius: 50%;
        }

        .user-name {
          display: inline-block;
          margin-left: 8px;
          max-width: 120px;
          vertical-align: middle;
          font-size: 14px;
          color: #333;
          overflow: hidden;
          text-overflow: ellipsis;
          white-space: nowrap;
        }

        .el-icon-caret-bottom {
          cursor: pointer;
          position: static;
          margin-left: 6px;
          font-size: 12px;
          line-height: 1;
          color: #909399;
        }
      }
    }
  }
}

/* 响应式：小屏隐藏用户名，避免与下拉箭头/布局冲突 */
@media (max-width: 768px) {
  .navbar .avatar-container .user-name {
    display: none;
  }
}

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
  border-radius: 6px;
  object-fit: cover;
}
</style>
