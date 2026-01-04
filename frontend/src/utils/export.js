import * as XLSX from 'xlsx'

/**
 * 通用导出功能工具类
 * 支持Excel和CSV格式导出
 */
class ExportUtil {
  /**
   * 导出Excel文件
   * @param {Array} data - 要导出的数据数组
   * @param {Object} options - 导出选项
   * @param {string} options.filename - 文件名（不含扩展名）
   * @param {Object} options.headers - 列头映射 {key: '显示名称'}
   * @param {string} options.sheetName - 工作表名称
   */
  static exportExcel(data, options = {}) {
    const {
      filename = 'export_data',
      headers = {},
      sheetName = 'Sheet1'
    } = options

    try {
      // 如果没有数据，导出空文件
      if (!data || data.length === 0) {
        const emptyData = [Object.keys(headers).reduce((obj, key) => {
          obj[key] = ''
          return obj
        }, {})]
        data = emptyData
      }

      // 处理数据，只保留需要的字段并重命名列头
      const processedData = data.map(item => {
        const newItem = {}
        Object.keys(headers).forEach(key => {
          newItem[headers[key]] = this.formatCellValue(item[key])
        })
        return newItem
      })

      // 创建工作簿
      const wb = XLSX.utils.book_new()
      const ws = XLSX.utils.json_to_sheet(processedData)

      // 设置列宽
      const colWidths = Object.values(headers).map(header => ({
        wch: Math.max(header.length, 15)
      }))
      ws['!cols'] = colWidths

      // 添加工作表到工作簿
      XLSX.utils.book_append_sheet(wb, ws, sheetName)

      // 生成文件名
      const timestamp = new Date().toISOString().slice(0, 19).replace(/:/g, '-')
      const finalFilename = `${filename}_${timestamp}.xlsx`

      // 导出文件
      XLSX.writeFile(wb, finalFilename)

      return {
        success: true,
        filename: finalFilename,
        message: '导出成功'
      }
    } catch (error) {
      console.error('Excel导出失败:', error)
      return {
        success: false,
        error: error.message,
        message: '导出失败'
      }
    }
  }

  /**
   * 导出CSV文件
   * @param {Array} data - 要导出的数据数组
   * @param {Object} options - 导出选项
   * @param {string} options.filename - 文件名（不含扩展名）
   * @param {Object} options.headers - 列头映射 {key: '显示名称'}
   */
  static exportCSV(data, options = {}) {
    const {
      filename = 'export_data',
      headers = {}
    } = options

    try {
      // 如果没有数据，创建空数据
      if (!data || data.length === 0) {
        data = [{}]
      }

      // 构建CSV内容
      const csvContent = this.buildCSVContent(data, headers)

      // 创建Blob对象
      const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' })

      // 生成文件名
      const timestamp = new Date().toISOString().slice(0, 19).replace(/:/g, '-')
      const finalFilename = `${filename}_${timestamp}.csv`

      // 创建下载链接
      const link = document.createElement('a')
      if (link.download !== undefined) {
        const url = URL.createObjectURL(blob)
        link.setAttribute('href', url)
        link.setAttribute('download', finalFilename)
        link.style.visibility = 'hidden'
        document.body.appendChild(link)
        link.click()
        document.body.removeChild(link)
        URL.revokeObjectURL(url)
      }

      return {
        success: true,
        filename: finalFilename,
        message: '导出成功'
      }
    } catch (error) {
      console.error('CSV导出失败:', error)
      return {
        success: false,
        error: error.message,
        message: '导出失败'
      }
    }
  }

  /**
   * 构建CSV内容
   * @param {Array} data - 数据数组
   * @param {Object} headers - 列头映射
   * @returns {string} CSV内容
   */
  static buildCSVContent(data, headers) {
    // 添加BOM以支持中文
    let csvContent = '\uFEFF'

    // 添加表头
    const headerRow = Object.values(headers).map(header => `"${header}"`).join(',')
    csvContent += headerRow + '\n'

    // 添加数据行
    data.forEach(item => {
      const row = Object.keys(headers).map(key => {
        const value = this.formatCellValue(item[key])
        return `"${String(value).replace(/"/g, '""')}"`
      }).join(',')
      csvContent += row + '\n'
    })

    return csvContent
  }

  /**
   * 格式化单元格值
   * @param {any} value - 原始值
   * @returns {string} 格式化后的值
   */
  static formatCellValue(value) {
    if (value === null || value === undefined) {
      return ''
    }
    
    // 处理日期
    if (value instanceof Date) {
      return value.toISOString().slice(0, 19).replace('T', ' ')
    }
    
    // 处理布尔值
    if (typeof value === 'boolean') {
      return value ? '是' : '否'
    }
    
    // 处理数字
    if (typeof value === 'number') {
      return value.toString()
    }
    
    // 处理对象
    if (typeof value === 'object') {
      return JSON.stringify(value)
    }
    
    return String(value)
  }

  /**
   * 根据搜索条件导出数据
   * @param {Function} apiFunction - API调用函数
   * @param {Object} searchParams - 搜索参数
   * @param {Object} exportOptions - 导出选项
   * @param {string} format - 导出格式 'excel' | 'csv'
   */
  static async exportWithSearch(apiFunction, searchParams = {}, exportOptions = {}, format = 'excel') {
    try {
      // 设置导出参数（获取所有数据）
      const params = {
        ...searchParams,
        page: 1,
        page_size: 10000, // 设置一个较大的值获取所有数据
        export: true // 标识这是导出请求
      }

      // 调用API获取数据
      const response = await apiFunction(params)
      
      // 处理响应数据
      let data = []
      if (response && typeof response === 'object') {
        if (response.results && Array.isArray(response.results)) {
          data = response.results
        } else if (Array.isArray(response.data)) {
          data = response.data
        } else if (Array.isArray(response)) {
          data = response
        }
      }

      // 根据格式导出
      if (format === 'csv') {
        return this.exportCSV(data, exportOptions)
      } else {
        return this.exportExcel(data, exportOptions)
      }
    } catch (error) {
      console.error('导出失败:', error)
      return {
        success: false,
        error: error.message,
        message: '导出失败，请检查网络连接或联系管理员'
      }
    }
  }
}

export default ExportUtil