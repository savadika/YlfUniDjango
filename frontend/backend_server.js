// 简单的后端服务器，提供部门数据API
const express = require('express')
const cors = require('cors')
const app = express()
const port = 8000

// 中间件
app.use(cors())
app.use(express.json())

// 模拟部门数据
const departments = [
  { id: 1, name: '技术部', description: '负责技术开发和维护' },
  { id: 2, name: '市场部', description: '负责市场推广和销售' },
  { id: 3, name: '人事部', description: '负责人力资源管理' },
  { id: 4, name: '财务部', description: '负责财务管理和会计' },
  { id: 5, name: '运营部', description: '负责日常运营管理' },
  { id: 6, name: '产品部', description: '负责产品设计和规划' },
  { id: 7, name: '客服部', description: '负责客户服务和支持' }
]

// 模拟用户数据
const users = [
  { 
    id: 1, 
    username: 'testuser1', 
    department: 1, 
    avatar: '/media/avatars/testuser1.png',
    email: 'testuser1@company.com', 
    phone: '13800138001', 
    login_date: '2025-08-10',
    status: 1,
    create_time: '2025-08-14',
    update_time: '2025-08-05',
    remark: '测试用户1'
  },
  { 
    id: 2, 
    username: 'admin', 
    department: 2, 
    avatar: '/media/avatars/admin.png',
    email: 'ylf8708@126.com', 
    phone: '18806537016', 
    login_date: '2015-08-11',
    status: 1,
    create_time: '2025-08-14',
    update_time: '2025-08-05',
    remark: '超级管理员'
  },
  { 
    id: 3, 
    username: 'ylf', 
    department: 2, 
    avatar: '/media/avatars/ylf.png',
    email: 'ylf87908@126.com', 
    phone: '18803885922', 
    login_date: '2025-08-05',
    status: 1,
    create_time: '2025-08-14',
    update_time: '2025-08-19',
    remark: '一级管理'
  },
  { 
    id: 4, 
    username: 'testuser4', 
    department: 4, 
    avatar: '/media/avatars/testuser4.png',
    email: 'testuser4@company.com', 
    phone: '13800138004', 
    login_date: '2025-08-12',
    status: 0,
    create_time: '2025-08-14',
    update_time: '2025-08-05',
    remark: '测试用户4'
  }
]

// 部门相关API
// 获取部门列表
app.get('/department', (req, res) => {
  const { page = 1, page_size = 10 } = req.query
  const pageNum = parseInt(page)
  const pageSize = parseInt(page_size)
  
  console.log(`[${new Date().toLocaleString()}] GET /department - page: ${pageNum}, page_size: ${pageSize}`)
  
  // 如果page_size很大（如1000），返回所有数据
  if (pageSize >= 1000) {
    res.json({
      code: 20000,
      message: 'success',
      data: {
        results: departments,
        count: departments.length,
        page: pageNum,
        page_size: pageSize
      }
    })
  } else {
    // 分页逻辑
    const startIndex = (pageNum - 1) * pageSize
    const endIndex = startIndex + pageSize
    const paginatedDepartments = departments.slice(startIndex, endIndex)
    
    res.json({
      code: 20000,
      message: 'success',
      data: {
        results: paginatedDepartments,
        count: departments.length,
        page: pageNum,
        page_size: pageSize
      }
    })
  }
})

// 获取单个部门详情
app.get('/department/:id', (req, res) => {
  const id = parseInt(req.params.id)
  const department = departments.find(d => d.id === id)
  
  console.log(`[${new Date().toLocaleString()}] GET /department/${id}`)
  
  if (department) {
    res.json({
      code: 20000,
      message: 'success',
      data: department
    })
  } else {
    res.status(404).json({
      code: 40404,
      message: '部门不存在'
    })
  }
})

// 用户相关API
// 获取用户列表
app.get('/user', (req, res) => {
  const { page = 1, page_size = 10, department, username, status } = req.query
  const pageNum = parseInt(page)
  const pageSize = parseInt(page_size)
  
  console.log(`[${new Date().toLocaleString()}] GET /user - page: ${pageNum}, page_size: ${pageSize}, filters:`, { department, username, status })
  
  // 过滤逻辑
  let filteredUsers = [...users]
  
  if (department) {
    filteredUsers = filteredUsers.filter(user => user.department === parseInt(department))
  }
  
  if (username) {
    filteredUsers = filteredUsers.filter(user => user.username.includes(username))
  }
  
  if (status !== undefined && status !== '') {
    filteredUsers = filteredUsers.filter(user => user.status === parseInt(status))
  }
  
  console.log(`[${new Date().toLocaleString()}] Filtered users count: ${filteredUsers.length}`)
  
  // 分页逻辑
  const startIndex = (pageNum - 1) * pageSize
  const endIndex = startIndex + pageSize
  const paginatedUsers = filteredUsers.slice(startIndex, endIndex)
  
  const totalPages = Math.ceil(filteredUsers.length / pageSize)
  const hasNext = pageNum < totalPages
  const hasPrevious = pageNum > 1
  
  res.json({
    count: filteredUsers.length,
    next: hasNext ? `http://localhost:8000/user?page=${pageNum + 1}&page_size=${pageSize}` : null,
    previous: hasPrevious ? `http://localhost:8000/user?page=${pageNum - 1}&page_size=${pageSize}` : null,
    results: paginatedUsers
  })
})

// 登录API（简单模拟）
app.post('/user/login', (req, res) => {
  const { username, password } = req.body
  
  console.log(`[${new Date().toLocaleString()}] POST /user/login - username: ${username}`)
  
  // 简单验证
  if (username === 'admin' && password === '111111') {
    res.json({
      code: 20000,
      message: 'success',
      data: {
        token: 'admin-token-' + Date.now()
      }
    })
  } else {
    res.status(401).json({
      code: 60204,
      message: '用户名或密码错误'
    })
  }
})

// 获取用户信息API
app.get('/user/info', (req, res) => {
  const token = req.headers.authorization
  
  console.log(`[${new Date().toLocaleString()}] GET /user/info - token: ${token ? token.substring(0, 20) + '...' : 'none'}`)
  
  if (token && token.includes('admin-token')) {
    res.json({
      code: 20000,
      message: 'success',
      data: {
        roles: ['admin'],
        introduction: 'I am a super administrator',
        avatar: 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif',
        name: 'Super Admin'
      }
    })
  } else {
    res.status(401).json({
      code: 50008,
      message: 'Invalid Token'
    })
  }
})

// 健康检查
app.get('/health', (req, res) => {
  res.json({
    status: 'ok',
    timestamp: new Date().toISOString(),
    message: '后端服务器运行正常'
  })
})

// 启动服务器
app.listen(port, () => {
  console.log('='.repeat(50))
  console.log('🚀 后端服务器启动成功！')
  console.log(`📍 服务地址: http://localhost:${port}`)
  console.log(`🕒 启动时间: ${new Date().toLocaleString()}`)
  console.log('='.repeat(50))
  console.log('📋 可用的API接口:')
  console.log('  GET  /health           - 健康检查')
  console.log('  GET  /department       - 获取部门列表')
  console.log('  GET  /department/:id   - 获取部门详情')
  console.log('  GET  /user             - 获取用户列表')
  console.log('  POST /user/login       - 用户登录')
  console.log('  GET  /user/info        - 获取用户信息')
  console.log('='.repeat(50))
  console.log('💡 测试命令:')
  console.log(`  curl http://localhost:${port}/health`)
  console.log(`  curl http://localhost:${port}/department`)
  console.log('='.repeat(50))
})

// 优雅关闭
process.on('SIGINT', () => {
  console.log('\n👋 正在关闭服务器...')
  process.exit(0)
})

process.on('SIGTERM', () => {
  console.log('\n👋 正在关闭服务器...')
  process.exit(0)
})