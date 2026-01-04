const Mock = require('mockjs')

// 简单模拟服务端系统信息
const data = Mock.mock({
  code: 200,
  message: 'success',
  data: {
    os: {
      platform: 'Windows',
      release: '10',
      arch: 'x64'
    },
    cpu: {
      model: 'Intel(R) Core(TM) i7-9700',
      cores: 8,
      load: 0.36 // 36%
    },
    memory: {
      total: 16 * 1024 * 1024 * 1024,
      free: 7.2 * 1024 * 1024 * 1024,
      used: 8.8 * 1024 * 1024 * 1024,
      usage: 0.55
    },
    uptime: 86400 * 2 + 3600 * 5 + 32,
    node: {
      version: 'v16.19.0'
    }
  }
})

module.exports = [
  {
    // 使用更宽松的匹配，既能匹配 /system/info 也能匹配 http://host:port/system/info 或 /dev-api/system/info
    url: 'system/info',
    type: 'get',
    response: _ => data
  }
]