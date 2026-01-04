const Mock = require('mockjs')
const Random = Mock.Random

const genUser = (id) => ({
  id,
  username: 'user_' + id,
  nickname: Random.cname(),
  phone: '1' + Random.integer(3000000000, 9999999999),
  email: Random.email('example.com'),
  role: Random.pick(['admin','editor','visitor']),
  status: Random.pick([0,1]),
  createdAt: Random.datetime(),
  updatedAt: Random.datetime()
})

let users = Array.from({ length: 86 }).map((_, i) => genUser(i + 1))

function filterList({ keyword, role, status }) {
  let list = users.slice()
  if (keyword) {
    const k = String(keyword).toLowerCase()
    list = list.filter(u => [u.username, u.nickname, u.phone, u.email].some(x => String(x).toLowerCase().includes(k)))
  }
  if (role) list = list.filter(u => u.role === role)
  if (status !== '' && status !== undefined) list = list.filter(u => String(u.status) === String(status))
  return list
}

module.exports = [
  // 查询列表
  {
    url: '/vue-admin-template/system/users',
    type: 'get',
    response: config => {
      const { page = 1, pageSize = 10, keyword = '', role = '', status = '' } = config.query
      const all = filterList({ keyword, role, status })
      const start = (page - 1) * pageSize
      const end = start + Number(pageSize)
      return {
        code: 200,
        data: {
          total: all.length,
          list: all.slice(start, end)
        }
      }
    }
  },
  // 新增
  {
    url: '/vue-admin-template/system/users',
    type: 'post',
    response: config => {
      const body = config.body
      const id = users.length ? users[users.length - 1].id + 1 : 1
      const item = { ...genUser(id), ...body, id }
      users.push(item)
      return { code: 200, data: item }
    }
  },
  // 更新
  {
    url: '/vue-admin-template/system/users/\\d+',
    type: 'put',
    response: config => {
      const id = Number(config.url.match(/users\/(\d+)/)[1])
      const body = config.body
      users = users.map(u => (u.id === id ? { ...u, ...body, id } : u))
      return { code: 200, data: true }
    }
  },
  // 删除
  {
    url: '/vue-admin-template/system/users/\\d+',
    type: 'delete',
    response: config => {
      const id = Number(config.url.match(/users\/(\d+)/)[1])
      users = users.filter(u => u.id !== id)
      return { code: 200, data: true }
    }
  },
  // 状态切换
  {
    url: '/vue-admin-template/system/users/\\d+/status',
    type: 'patch',
    response: config => {
      const id = Number(config.url.match(/users\/(\d+)/)[1])
      const { status } = config.body
      users = users.map(u => (u.id === id ? { ...u, status: Number(status) } : u))
      return { code: 200, data: true }
    }
  }
]