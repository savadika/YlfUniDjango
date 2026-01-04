import request from '@/utils/request'

export function getAllMenus() {
  return request({
    url: '/menu/get_all_menus/',
    method: 'get'
  })
}

export function addMenu(data) {
  return request({
    url: '/menu/',
    method: 'post',
    data
  })
}

export function updateMenu(id, data) {
  return request({
    url: `/menu/${id}/`,
    method: 'put',
    data
  })
}

export function deleteMenu(id) {
  return request({
    url: `/menu/${id}/`,
    method: 'delete'
  })
}

export function getMenu(id) {
  return request({
    url: `/menu/${id}/`,
    method: 'get'
  })
}
