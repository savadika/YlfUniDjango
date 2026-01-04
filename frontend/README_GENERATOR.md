# Vue Admin 模块代码生成器

基于部门管理模块开发的通用CRUD模块代码生成器，可以快速生成标准化的管理界面、API接口和路由配置。

## 🚀 快速开始

### 基本用法

```javascript
import { GeneratorFactory } from '@/utils/generator'

// 快速生成用户管理模块
const result = GeneratorFactory.quickGenerate(
  '用户管理',
  'user',
  'basic',
  [
    {
      key: 'username',
      label: '用户名',
      type: 'string',
      required: true,
      searchable: true,
      defaultSearch: true,
      placeholder: '请输入用户名'
    },
    {
      key: 'email',
      label: '邮箱',
      type: 'string',
      required: true,
      searchable: true,
      placeholder: '请输入邮箱地址'
    },
    {
      key: 'role',
      label: '角色',
      type: 'select',
      required: true,
      searchable: true,
      options: [
        { label: '管理员', value: 'admin' },
        { label: '普通用户', value: 'user' }
      ]
    }
  ]
)

console.log(result)
```

### 高级配置

```javascript
import { ConfigBuilder, CommonFields } from '@/utils/generator'
import { ModuleGenerator } from '@/utils/generator'

// 使用配置构建器
const config = new ConfigBuilder()
  .setModule('产品管理', 'product')
  .addField(CommonFields.id)
  .addField({
    key: 'name',
    label: '产品名称',
    type: 'string',
    required: true,
    searchable: true,
    defaultSearch: true,
    placeholder: '请输入产品名称'
  })
  .addField({
    key: 'price',
    label: '价格',
    type: 'number',
    required: true,
    searchable: true,
    placeholder: '请输入产品价格'
  })
  .addField(CommonFields.status)
  .addField(CommonFields.createTime)
  .setOptions({
    enableSearch: true,
    enableExport: true,
    enablePagination: true,
    pageSize: 20
  })
  .build()

const generator = new ModuleGenerator()
const result = generator.setConfig(config).generateAll()
```

## 📁 生成的文件结构

生成器会创建以下文件：

```
src/
├── views/
│   └── [moduleKey]/
│       └── index.vue          # 主页面组件
├── api/
│   └── [moduleKey].js         # API接口文件
└── router/
    └── modules/
        └── [moduleKey].js     # 路由配置文件
```

## 🔧 字段类型支持

### 基础类型

| 类型 | 说明 | 表单组件 | 搜索支持 |
|------|------|----------|----------|
| `string` | 字符串 | el-input | ✅ |
| `number` | 数字 | el-input-number | ✅ |
| `textarea` | 多行文本 | el-input (type="textarea") | ✅ |
| `date` | 日期 | el-date-picker | ✅ |
| `datetime` | 日期时间 | el-date-picker | ✅ |
| `select` | 下拉选择 | el-select | ✅ |
| `switch` | 开关 | el-switch | ✅ |
| `radio` | 单选 | el-radio-group | ✅ |
| `checkbox` | 多选 | el-checkbox-group | ✅ |

### 字段配置选项

```javascript
{
  key: 'field_name',           // 字段名（必填）
  label: '字段标签',            // 显示标签（必填）
  type: 'string',              // 字段类型（必填）
  required: true,              // 是否必填
  searchable: true,            // 是否可搜索
  defaultSearch: true,         // 是否默认搜索字段
  showInTable: true,           // 是否在表格中显示
  showInForm: true,            // 是否在表单中显示
  width: 120,                  // 表格列宽
  placeholder: '请输入...',     // 输入提示
  defaultValue: '',            // 默认值
  options: [],                 // 选项（select/radio/checkbox）
  activeText: '启用',          // switch激活文本
  inactiveText: '禁用',        // switch非激活文本
  activeValue: 1,              // switch激活值
  inactiveValue: 0,            // switch非激活值
  rules: []                    // 自定义验证规则
}
```

## 🎯 预定义字段

使用 `CommonFields` 快速添加常用字段：

```javascript
import { CommonFields } from '@/utils/generator'

// 可用的预定义字段
CommonFields.id          // ID字段
CommonFields.name        // 名称字段
CommonFields.status      // 状态字段
CommonFields.remark      // 备注字段
CommonFields.createTime  // 创建时间
CommonFields.updateTime  // 更新时间
CommonFields.sort        // 排序字段
```

## 📋 模块模板

### 基础模板 (basic)

包含基本的CRUD功能：
- 列表展示
- 搜索功能
- 新增/编辑/删除
- 分页

### 高级模板 (advanced)

在基础模板基础上增加：
- 批量操作
- 导入/导出
- 高级搜索
- 状态切换

### 简单模板 (simple)

精简版功能：
- 基本列表
- 简单搜索
- 基础操作

## 🔄 批量生成

```javascript
import { GeneratorFactory } from '@/utils/generator'

const batchGenerator = GeneratorFactory.createBatchGenerator()

batchGenerator
  .addModule({
    moduleName: '角色管理',
    moduleKey: 'role',
    fields: [/* 字段配置 */]
  })
  .addModule({
    moduleName: '权限管理',
    moduleKey: 'permission',
    fields: [/* 字段配置 */]
  })

const results = batchGenerator.generateAll()
const statistics = batchGenerator.getStatistics()
```

## 🔄 克隆现有模块

基于部门管理模块快速创建相似模块：

```javascript
import { GeneratorFactory } from '@/utils/generator'

// 克隆部门模块创建公司管理
const result = GeneratorFactory.cloneFromDepartment(
  '公司管理',
  'company',
  {
    name: { label: '公司名称', placeholder: '请输入公司名称' },
    remark: { label: '公司简介', placeholder: '请输入公司简介' }
  }
)
```

## 🎨 自定义样式

生成的组件支持自定义样式：

```javascript
const config = {
  // ... 其他配置
  styles: {
    tableHeight: '400px',
    formWidth: '600px',
    searchFormCols: 3
  }
}
```

## 🔌 API 接口规范

生成的API接口遵循RESTful规范：

```javascript
// 生成的API接口
getList(params)           // GET /api/[module] - 获取列表
create(data)             // POST /api/[module] - 创建
getDetail(id)            // GET /api/[module]/:id - 获取详情
update(id, data)         // PUT /api/[module]/:id - 更新
patch(id, data)          // PATCH /api/[module]/:id - 部分更新
delete(id)               // DELETE /api/[module]/:id - 删除
exportData(params)       // GET /api/[module]/export - 导出
```

## 🛠️ 高级功能

### 预览生成结果

```javascript
const generator = new ModuleGenerator()
const preview = generator.setConfig(config).generatePreview()
console.log(preview)
```

### 自定义模板

```javascript
const customTemplate = {
  name: 'custom',
  description: '自定义模板',
  features: ['search', 'table', 'form'],
  options: {
    enableExport: false,
    pageSize: 10
  }
}

const generator = new ModuleGenerator()
generator.addTemplate(customTemplate)
```

### 验证配置

```javascript
import { FieldConfig } from '@/utils/generator'

const isValid = FieldConfig.validate(config)
if (!isValid.success) {
  console.error('配置验证失败:', isValid.errors)
}
```

## 📝 最佳实践

### 1. 字段命名规范

- 使用下划线命名：`user_name`、`create_time`
- 布尔字段使用 `is_` 前缀：`is_active`、`is_deleted`
- 外键字段使用 `_id` 后缀：`user_id`、`category_id`

### 2. 搜索字段配置

- 主要字段设置为默认搜索：`defaultSearch: true`
- 合理控制搜索字段数量（建议不超过5个）
- 日期字段建议支持范围搜索

### 3. 表格显示优化

- 设置合适的列宽：`width`
- 长文本字段不在表格中显示：`showInTable: false`
- 重要字段放在前面

### 4. 表单验证

```javascript
{
  key: 'email',
  label: '邮箱',
  type: 'string',
  required: true,
  rules: [
    { type: 'email', message: '请输入正确的邮箱格式' }
  ]
}
```

### 5. 性能优化

- 合理设置分页大小：`pageSize`
- 大数据量时禁用某些功能：`enableExport: false`
- 使用懒加载：`lazy: true`

## 🐛 常见问题

### Q: 生成的文件已存在怎么办？

A: 生成器会提示文件冲突，可以选择覆盖或跳过。建议先备份现有文件。

### Q: 如何修改生成的代码？

A: 生成的代码是标准的Vue组件，可以直接修改。建议在生成后进行个性化调整。

### Q: 支持哪些UI组件库？

A: 目前支持Element UI，后续会支持更多组件库。

### Q: 如何添加自定义字段类型？

A: 可以扩展 `fieldConfig.js` 中的字段类型定义。

## 🔄 更新日志

### v1.0.0
- 基础CRUD模块生成
- 支持常用字段类型
- Vue组件模板生成
- API接口生成
- 路由配置生成

## 📄 许可证

MIT License

## 🤝 贡献

欢迎提交Issue和Pull Request来改进这个代码生成器。

## 📞 支持

如果您在使用过程中遇到问题，请查看示例文件 `generatorExamples.js` 或提交Issue。