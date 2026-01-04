/**
 * 导出功能混入
 * 为页面组件提供通用的导出功能
 */
import ExportUtil from './export'

export default {
  data() {
    return {
      exportLoading: false
    }
  },
  methods: {
    /**
     * 通用导出方法
     * @param {Function} apiFunction - API调用函数
     * @param {Object} searchParams - 搜索参数
     * @param {Object} exportOptions - 导出选项
     * @param {string} format - 导出格式 'excel' | 'csv'
     */
    async exportData(apiFunction, searchParams = {}, exportOptions = {}, format = 'excel') {
      this.exportLoading = true
      try {
        const result = await ExportUtil.exportWithSearch(
          apiFunction,
          searchParams,
          exportOptions,
          format
        )
        
        if (result.success) {
          this.$message.success(`${result.message}：${result.filename}`)
          return result
        } else {
          this.$message.error(result.message)
          throw new Error(result.error)
        }
      } catch (error) {
        console.error('导出失败:', error)
        this.$message.error('导出失败，请稍后重试')
        throw error
      } finally {
        this.exportLoading = false
      }
    },

    /**
     * 导出Excel
     * @param {Function} apiFunction - API调用函数
     * @param {Object} searchParams - 搜索参数
     * @param {Object} exportOptions - 导出选项
     */
    async exportExcel(apiFunction, searchParams = {}, exportOptions = {}) {
      return this.exportData(apiFunction, searchParams, exportOptions, 'excel')
    },

    /**
     * 导出CSV
     * @param {Function} apiFunction - API调用函数
     * @param {Object} searchParams - 搜索参数
     * @param {Object} exportOptions - 导出选项
     */
    async exportCSV(apiFunction, searchParams = {}, exportOptions = {}) {
      return this.exportData(apiFunction, searchParams, exportOptions, 'csv')
    },

    /**
     * 创建标准的导出选项
     * @param {string} filename - 文件名
     * @param {Object} headers - 列头映射
     * @param {string} sheetName - 工作表名称
     */
    createExportOptions(filename, headers, sheetName = 'Sheet1') {
      return {
        filename,
        headers,
        sheetName
      }
    }
  }
}