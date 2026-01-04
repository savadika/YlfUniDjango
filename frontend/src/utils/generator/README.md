# 代码生成器工具包

这个文件夹包含了完整的Vue Admin模块代码生成器工具包，基于部门管理模块开发，可以快速生成标准化的CRUD管理界面。

## 📁 文件结构

```
generator/
├── index.js                    # 入口文件，统一导出所有功能
├── fieldConfig.js              # 字段配置和验证规则
├── moduleGenerator.js          # 主模块生成器
├── vueTemplateGenerator.js     # Vue组件模板生成器
├── apiTemplateGenerator.js     # API接口模板生成器
├── routerTemplateGenerator.js  # 路由配置生成器
├── examples.js                 # 使用示例和演示代码
├── codeGenerator.js            # 旧版代码生成器（保留）
└── README.md                   # 本文件
```

## 🚀 快速开始

### 基本用法

```javascript
// 导入生成器
import { GeneratorFactory } from '@/utils/generator'

// 快速生成模块
const result = GeneratorFactory.quickGenerate(
  '用户管理',
  'user', 
  'basic',
  [/* 字段配置 */]
)
```

### 高级用法

```javascript
// 导入配置构建器
import { ConfigBuilder, CommonFields, ModuleGenerator } from '@/utils/generator'

// 构建配置
const config = new ConfigBuilder()
  .setModule('产品管理', 'product')
  .addField(CommonFields.id)
  .addField({ key: 'name', label: '产品名称', type: 'string' })
  .build()

// 生成模块
const generator = new ModuleGenerator()
const result = generator.setConfig(config).generateAll()
```

## 📋 核心功能

### 1. 字段配置 (fieldConfig.js)
- **FieldConfig**: 字段配置类，定义字段结构和验证
- **CommonFields**: 预定义常用字段（id、name、status等）
- **ConfigBuilder**: 配置构建器，链式API构建模块配置
- **ModuleTemplates**: 预定义模块模板

### 2. 模块生成器 (moduleGenerator.js)
- **ModuleGenerator**: 主模块生成器
- **GeneratorFactory**: 生成器工厂，提供快速生成方法
- **BatchGenerator**: 批量生成器，支持一次生成多个模块

### 3. Vue组件生成器 (vueTemplateGenerator.js)
- **VueTemplateGenerator**: 生成Vue组件模板
- 支持搜索、表格、表单、分页等功能
- 基于Element UI组件库

### 4. API接口生成器 (apiTemplateGenerator.js)
- **ApiTemplateGenerator**: 生成标准CRUD接口
- **ApiDocGenerator**: 生成API文档
- 遵循RESTful规范

### 5. 路由生成器 (routerTemplateGenerator.js)
- **RouterTemplateGenerator**: 生成路由配置
- **RouterRegistrar**: 路由注册指南
- **BreadcrumbGenerator**: 面包屑配置
- **MenuGenerator**: 菜单配置

## 🎯 支持的字段类型

### 基础字段类型
- `string` - 字符串输入
- `number` - 数字输入  
- `textarea` - 多行文本
- `boolean` - 布尔值/开关
- `email` - 邮箱输入
- `url` - URL输入
- `file` - 文件上传
- `image` - 图片上传

### 日期时间字段
- `date` - 日期选择
- `datetime` - 日期时间选择
- `time` - 时间选择

### 选择字段
- `select` - 下拉选择
- `multiselect` - 多选下拉
- `radio` - 单选按钮
- `checkbox` - 多选框

### Django字段类型支持

代码生成器完整支持Django的所有官方字段类型：

#### 自增字段
- `AutoField` → number
- `BigAutoField` → number

#### 整数字段
- `IntegerField` → number
- `BigIntegerField` → number
- `SmallIntegerField` → number
- `PositiveIntegerField` → number
- `PositiveSmallIntegerField` → number
- `PositiveBigIntegerField` → number

#### 浮点数字段
- `FloatField` → number
- `DecimalField` → number

#### 文本字段
- `CharField` → string
- `TextField` → textarea
- `SlugField` → string

#### 布尔字段
- `BooleanField` → boolean
- `NullBooleanField` → boolean (已废弃，但仍支持)

#### 日期时间字段
- `DateField` → date
- `DateTimeField` → datetime
- `TimeField` → time
- `DurationField` → string

#### 特殊文本字段
- `EmailField` → email
- `URLField` → url
- `UUIDField` → string
- `GenericIPAddressField` → string

#### 文件字段
- `FileField` → file
- `ImageField` → image
- `FilePathField` → select

#### 其他字段
- `BinaryField` → textarea
- `JSONField` → textarea

#### 关系字段
- `ForeignKey` → select
- `OneToOneField` → select
- `ManyToManyField` → multiselect
- `GenericForeignKey` → string
- `ContentType` → select

## 📝 使用示例

查看 `examples.js` 文件获取详细的使用示例，包括：
- 基础模块生成
- 高级配置示例
- 批量生成示例
- 克隆现有模块
- 完整工作流程

## 🔧 自定义扩展

### 添加新的字段类型

在 `fieldConfig.js` 中扩展 `FIELD_TYPES`：

```javascript
FIELD_TYPES.custom = {
  component: 'el-custom-input',
  props: {},
  defaultValue: ''
}
```

### 添加新的模板

在 `moduleGenerator.js` 中添加模板：

```javascript
const customTemplate = {
  name: 'custom',
  description: '自定义模板',
  features: ['search', 'table', 'form']
}
```

## 📖 详细文档

更多详细信息请参考项目根目录的 `README_GENERATOR.md` 文件。

## 🤝 贡献

欢迎提交Issue和Pull Request来改进这个代码生成器工具包。