// 外键数据获取API接口模板
// 请根据实际需要将这些函数添加到对应的API文件中

import request from '@/utils/request'

/**
 * 获取部门列表（用于用户表的department外键）
 * @param {Object} params - 查询参数
 * @returns {Promise} 部门列表数据
 */
export function getDepartmentOptions(params = {}) {
  return request({
    url: '/api/departments/options',
    method: 'get',
    params: {
      page_size: params.pageSize || 100, // 默认获取100条
      is_active: true, // 只获取激活的部门
      ...params
    }
  })
}

/**
 * 获取用户列表选项（用于其他表的user外键）
 * @param {Object} params - 查询参数
 * @returns {Promise} 用户列表数据
 */
export function getUserOptions(params = {}) {
  return request({
    url: '/api/users/options',
    method: 'get',
    params: {
      page_size: params.pageSize || 100,
      is_active: true, // 只获取激活的用户
      fields: 'id,username,email', // 只获取必要字段
      ...params
    }
  })
}

/**
 * 获取角色列表选项（用于用户角色关联）
 * @param {Object} params - 查询参数
 * @returns {Promise} 角色列表数据
 */
export function getRoleOptions(params = {}) {
  return request({
    url: '/api/roles/options',
    method: 'get',
    params: {
      page_size: params.pageSize || 50,
      is_active: true,
      ...params
    }
  })
}

/**
 * 通用外键选项获取函数
 * @param {string} modelName - 模型名称（如：department, user, role等）
 * @param {Object} params - 查询参数
 * @returns {Promise} 选项数据
 */
export function getForeignKeyOptions(modelName, params = {}) {
  return request({
    url: `/api/${modelName}/options`,
    method: 'get',
    params: {
      page_size: params.pageSize || 100,
      is_active: true,
      ...params
    }
  })
}

/**
 * 根据ID获取外键对象详情
 * @param {string} modelName - 模型名称
 * @param {number|string} id - 对象ID
 * @returns {Promise} 对象详情
 */
export function getForeignKeyDetail(modelName, id) {
  return request({
    url: `/api/${modelName}/${id}`,
    method: 'get'
  })
}

/**
 * 搜索外键选项（支持模糊搜索）
 * @param {string} modelName - 模型名称
 * @param {string} keyword - 搜索关键词
 * @param {Object} params - 其他查询参数
 * @returns {Promise} 搜索结果
 */
export function searchForeignKeyOptions(modelName, keyword, params = {}) {
  return request({
    url: `/api/${modelName}/search`,
    method: 'get',
    params: {
      q: keyword,
      page_size: params.pageSize || 20,
      ...params
    }
  })
}

// 使用示例：
// 
// 1. 在Vue组件中获取部门选项：
// import { getDepartmentOptions } from '@/api/department'
// 
// async mounted() {
//   try {
//     const response = await getDepartmentOptions()
//     this.departmentOptions = response.data.results.map(item => ({
//       label: item.name,
//       value: item.id
//     }))
//   } catch (error) {
//     console.error('获取部门选项失败:', error)
//   }
// }
//
// 2. 使用通用函数：
// import { getForeignKeyOptions } from '@/api/common'
// 
// async loadOptions(modelName) {
//   try {
//     const response = await getForeignKeyOptions(modelName)
//     return response.data.results.map(item => ({
//       label: item.name || item.title || item.username,
//       value: item.id
//     }))
//   } catch (error) {
//     console.error(`获取${modelName}选项失败:`, error)
//     return []
//   }
// }