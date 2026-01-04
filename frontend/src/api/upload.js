import request from '@/utils/request'

/**
 * 上传文件
 * @param {FormData} data - 包含文件的FormData对象，key通常为'file'
 */
export function uploadFile(data) {
  return request({
    url: '/upload/',
    method: 'post',
    headers: {
      'Content-Type': 'multipart/form-data'
    },
    data
  })
}
