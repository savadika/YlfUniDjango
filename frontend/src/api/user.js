import request from '@/utils/request'

export function login(data) {
  return request({
    url: '/user/gen_token',
    method: 'post',
    data
  })
}


export function getInfo(token) {
  return request({
    url: '/user/get_user_info',
    method: 'get',
    params: { token }
  })
}

export function logout() {
  return request({
    url: '/user/logout',
    method: 'post'
  })
}

// ======================================================================
// DRF 生成的链接
// List users: GET /user (route name: user-list)
export function getUserList(params) {
  return request({
    url: '/user',
    method: 'get',
    params
  })
}

// Create user: POST /user (route name: user-list)
export function createUser(data) {
  return request({
    url: '/user',
    method: 'post',
    data
  })
}

// Retrieve user detail: GET /user/{id} (route name: user-detail)
export function getUserDetail(id) {
  return request({
    url: `/user/${id}`,
    method: 'get'
  })
}

// Full update: PUT /user/{id}
export function updateUser(id, data) {
  return request({
    url: `/user/${id}`,
    method: 'put',
    data
  })
}

// Partial update: PATCH /user/{id}
export function patchUser(id, data) {
  return request({
    url: `/user/${id}`,
    method: 'patch',
    data
  })
}

// Delete: DELETE /user/{id}
export function deleteUser(id) {
  return request({
    url: `/user/${id}`,
    method: 'delete'
  })
}