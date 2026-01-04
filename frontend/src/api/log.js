import request from '@/utils/request'

/**
 * 获取日志管理列表
 * @param {Object} params - 查询参数
 * @param {number} params.page - 页码
 * @param {number} params.size - 每页数量
 * @param {number} [params.id] - ID
 * @param {string|number} [params.user] - 操作用户
 * @param {string} [params.ip] - 访问IP
 * @param {string} [params.method] - 请求方式
 * @param {string} [params.path] - 请求路径
 * @param {string} [params.params] - 请求参数
 * @param {number} [params.status] - 响应状态码
 * @param {number} [params.cost_time] - 耗时(ms)
 * @param {string} [params.create_time] - 创建时间
 * @param {string} [params.log_type] - 日志类型
 * @param {string} [params.error_msg] - 错误信息
 * @param {string} [params.traceback] - 堆栈详情
 * @returns {Promise} 返回日志管理列表数据
 */
export function getLogList(params) {
  return request({
    url: '/log',
    method: 'get',
    params
  })
}

/**
 * 获取日志管理详情
 * @param {number|string} id - 日志管理ID
 * @returns {Promise} 返回日志管理详情数据
 */
export function getLogDetail(id) {
  return request({
    url: `/log/${id}`,
    method: 'get'
  })
}

/**
 * 创建日志管理
 * @param {Object} data - 日志管理数据
 * @param {string|number} ?data.user - 操作用户
 * @param {string} ?data.ip - 访问IP
 * @param {string} ?data.method - 请求方式
 * @param {string} ?data.path - 请求路径
 * @param {string} ?data.params - 请求参数
 * @param {number} data.status - 响应状态码
 * @param {number} ?data.cost_time - 耗时(ms)
 * @param {string} data.create_time - 创建时间
 * @param {string} data.log_type - 日志类型
 * @param {string} ?data.error_msg - 错误信息
 * @param {string} ?data.traceback - 堆栈详情
 * @returns {Promise} 返回创建结果
 */
export function createLog(data) {
  return request({
    url: '/log',
    method: 'post',
    data
  })
}

/**
 * 更新日志管理（全量更新）
 * @param {number|string} id - 日志管理ID
 * @param {Object} data - 日志管理数据
 * @param {string|number} ?data.user - 操作用户
 * @param {string} ?data.ip - 访问IP
 * @param {string} ?data.method - 请求方式
 * @param {string} ?data.path - 请求路径
 * @param {string} ?data.params - 请求参数
 * @param {number} data.status - 响应状态码
 * @param {number} ?data.cost_time - 耗时(ms)
 * @param {string} data.create_time - 创建时间
 * @param {string} data.log_type - 日志类型
 * @param {string} ?data.error_msg - 错误信息
 * @param {string} ?data.traceback - 堆栈详情
 * @returns {Promise} 返回更新结果
 */
export function updateLog(id, data) {
  return request({
    url: `/log/${id}`,
    method: 'put',
    data
  })
}

/**
 * 更新日志管理（部分更新）
 * @param {number|string} id - 日志管理ID
 * @param {Object} data - 要更新的日志管理数据字段
 * @returns {Promise} 返回更新结果
 */
export function patchLog(id, data) {
  return request({
    url: `/log/${id}`,
    method: 'patch',
    data
  })
}

/**
 * 删除日志管理
 * @param {number|string} id - 日志管理ID
 * @returns {Promise} 返回删除结果
 */
export function deleteLog(id) {
  return request({
    url: `/log/${id}`,
    method: 'delete'
  })
}

// 默认导出所有API函数
export default {
  getLogList,
  getLogDetail,
  createLog,
  updateLog,
  patchLog,
  deleteLog
}