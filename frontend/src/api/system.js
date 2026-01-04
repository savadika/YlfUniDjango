import request from '@/utils/request'

export function getServerInfo() {
  return request({
    url: '/system/info',
    method: 'get'
  })
}

export function getUsers(params) {
  return request({
    url: '/system/users',
    method: 'get',
    params
  })
}

export function createUser(data) {
  return request({
    url: '/system/users',
    method: 'post',
    data
  })
}

export function updateUser(id, data) {
  return request({
    url: `/system/users/${id}`,
    method: 'put',
    data
  })
}

export function deleteUser(id) {
  return request({
    url: `/system/users/${id}`,
    method: 'delete'
  })
}

export function toggleUserStatus(id, status) {
  return request({
    url: `/system/users/${id}/status`,
    method: 'patch',
    data: { status }
  })
}