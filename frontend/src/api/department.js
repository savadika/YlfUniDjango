import request from '@/utils/request'


// 分页查询部门列表  GET /department?page=1&page_size=10
// - GET /department/ - 默认分页
// - GET /department/?page=2 - 指定页码
// - GET /department/?page_size=5 - 自定义每页大小
// - GET /department/?page=2&page_size=15 - 组合参数
export function getDepartmentList(params) {
  return request({
    url: '/department',
    method: 'get',
    params
  })
}

// Create department: POST /department (route name: department-list)
export function createDepartment(data) {
  return request({
    url: '/department',
    method: 'post',
    data
  })
}

// Retrieve department detail: GET /department/{id} (route name: department-detail)
export function getDepartmentDetail(id) {
  return request({
    url: `/department/${id}`,
    method: 'get'
  })
}

// Full update department: PUT /department/{id}
export function updateDepartment(id, data) {
  return request({
    url: `/department/${id}`,
    method: 'put',
    data
  })
}

// Partial update department: PATCH /department/{id}
export function patchDepartment(id, data) {
  return request({
    url: `/department/${id}`,
    method: 'patch',
    data
  })
}

// Delete department: DELETE /department/{id}
export function deleteDepartment(id) {
  return request({
    url: `/department/${id}`,
    method: 'delete'
  })
}
