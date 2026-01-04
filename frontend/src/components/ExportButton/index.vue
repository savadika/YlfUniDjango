<template>
  <el-dropdown @command="handleExport" :style="{ marginLeft: marginLeft }">
    <el-button 
      :type="buttonType" 
      :size="buttonSize"
      :loading="exportLoading"
      :disabled="disabled"
    >
      <i class="el-icon-download"></i> {{ buttonText }}
      <i class="el-icon-arrow-down el-icon--right"></i>
    </el-button>
    <el-dropdown-menu slot="dropdown">
      <el-dropdown-item command="excel">
        <i class="el-icon-document"></i> 导出Excel
      </el-dropdown-item>
      <el-dropdown-item command="csv">
        <i class="el-icon-tickets"></i> 导出CSV
      </el-dropdown-item>
    </el-dropdown-menu>
  </el-dropdown>
</template>

<script>
import ExportUtil from '@/utils/export'

export default {
  name: 'ExportButton',
  props: {
    // API调用函数
    apiFunction: {
      type: Function,
      required: true
    },
    // 搜索参数
    searchParams: {
      type: Object,
      default: () => ({})
    },
    // 导出选项
    exportOptions: {
      type: Object,
      required: true,
      validator(value) {
        return value.filename && value.headers
      }
    },
    // 按钮样式
    buttonType: {
      type: String,
      default: 'success'
    },
    buttonSize: {
      type: String,
      default: 'medium'
    },
    buttonText: {
      type: String,
      default: '导出'
    },
    marginLeft: {
      type: String,
      default: '10px'
    },
    disabled: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      exportLoading: false
    }
  },
  methods: {
    async handleExport(format) {
      this.exportLoading = true
      this.$emit('export-start', format)
      
      try {
        // 调用导出工具
        const result = await ExportUtil.exportWithSearch(
          this.apiFunction,
          this.searchParams,
          this.exportOptions,
          format
        )
        
        if (result.success) {
          this.$message.success(`${result.message}：${result.filename}`)
          this.$emit('export-success', { format, result })
        } else {
          this.$message.error(result.message)
          this.$emit('export-error', { format, error: result.error })
        }
      } catch (error) {
        console.error('导出失败:', error)
        this.$message.error('导出失败，请稍后重试')
        this.$emit('export-error', { format, error: error.message })
      } finally {
        this.exportLoading = false
        this.$emit('export-end', format)
      }
    }
  }
}
</script>

<style scoped>
/* 可以添加自定义样式 */
</style>