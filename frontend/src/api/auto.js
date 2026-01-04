/**
 * SysAuto API接口
 */
import request from '@/utils/request'

// 获取Auto列表
export function getAutoList(params) {
  return request({
    url: '/auto/',
    method: 'get',
    params
  })
}

// 创建Auto
export function createAuto(data) {
  return request({
    url: '/auto/',
    method: 'post',
    data
  })
}

// 更新Auto
export function updateAuto(id, data) {
  return request({
    url: `/auto/${id}/`,
    method: 'put',
    data
  })
}

// 删除Auto
export function deleteAuto(id) {
  return request({
    url: `/auto/${id}/`,
    method: 'delete'
  })
}

// 获取Auto详情
export function getAutoDetail(id) {
  return request({
    url: `/auto/${id}/`,
    method: 'get'
  })
}

// 导出Auto列表
export function exportAutoList(params) {
  return request({
    url: '/auto/',
    method: 'get',
    params: {
      ...params,
      export: true
    }
  })
}
