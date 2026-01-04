import request from '@/utils/request'

/**
 * 获取role列表
 * @param {Object} params - 查询参数
 * @param {number} params.page - 页码
 * @param {number} params.size - 每页数量
 * @param {string} [params.name] - 角色名称
 * @param {string} [params.code] - 角色编码
 * @param {string} [params.create_time] - 创建时间
 * @param {string} [params.update_time] - 更新时间
 * @param {string} [params.remark] - 备注
 * @returns {Promise} 返回role列表数据
 */
export function getRoleList(params) {
  return request({
    url: '/role',
    method: 'get',
    params
  })
}

/**
 * 获取role详情
 * @param {number|string} id - roleID
 * @returns {Promise} 返回role详情数据
 */
export function getRoleDetail(id) {
  return request({
    url: `/role/${id}`,
    method: 'get'
  })
}

/**
 * 创建role
 * @param {Object} data - role数据
 * @param {string} ?data.name - 角色名称
 * @param {string} ?data.code - 角色编码
 * @param {string} ?data.create_time - 创建时间
 * @param {string} ?data.update_time - 更新时间
 * @param {string} ?data.remark - 备注
 * @returns {Promise} 返回创建结果
 */
export function createRole(data) {
  return request({
    url: '/role',
    method: 'post',
    data
  })
}

/**
 * 更新role（全量更新）
 * @param {number|string} id - roleID
 * @param {Object} data - role数据
 * @param {string} ?data.name - 角色名称
 * @param {string} ?data.code - 角色编码
 * @param {string} ?data.create_time - 创建时间
 * @param {string} ?data.update_time - 更新时间
 * @param {string} ?data.remark - 备注
 * @returns {Promise} 返回更新结果
 */
export function updateRole(id, data) {
  return request({
    url: `/role/${id}`,
    method: 'put',
    data
  })
}

/**
 * 更新role（部分更新）
 * @param {number|string} id - roleID
 * @param {Object} data - 要更新的role数据字段
 * @returns {Promise} 返回更新结果
 */
export function patchRole(id, data) {
  return request({
    url: `/role/${id}`,
    method: 'patch',
    data
  })
}

/**
 * 删除role
 * @param {number|string} id - roleID
 * @returns {Promise} 返回删除结果
 */
export function deleteRole(id) {
  return request({
    url: `/role/${id}`,
    method: 'delete'
  })
}

/**
 * 更新角色权限
 * @param {number|string} id - roleID
 * @param {Object} data - 权限数据 { permissions: [...] }
 * @returns {Promise}
 */
export function updateRolePermissions(id, data) {
  return request({
    url: `/role/${id}/permissions`,
    method: 'put',
    data
  })
}

/**
 * 获取角色菜单和权限
 * @param {number|string} id - roleID
 * @returns {Promise} 返回角色关联的菜单和权限
 */
export function getRoleMenus(id) {
  return request({
    url: `/role/${id}/menus/`,
    method: 'get'
  })
}

// 默认导出所有API函数
export default {
  getRoleList,
  getRoleDetail,
  createRole,
  updateRole,
  patchRole,
  deleteRole
}