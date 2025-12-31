# 通用路由器使用说明

## OptionalSlashRouter 类

这是一个支持可选斜杠的通用路由器类，可以让API同时支持带斜杠和不带斜杠的URL访问模式。

### 功能特点

- 自动生成带斜杠和不带斜杠的URL模式
- 减少代码重复，避免在每个模块中重复定义路由器类
- 完全兼容Django REST Framework的SimpleRouter
- 支持所有HTTP方法（GET、POST、PUT、PATCH、DELETE）

### 使用方法

#### 1. 导入路由器

```python
from utils.routers import OptionalSlashRouter
```

#### 2. 创建路由器实例并注册ViewSet

```python
# 创建支持可选斜杠的路由器
router = OptionalSlashRouter()
router.register(r'', YourViewSet, basename='your_model')
```

#### 3. 配置URL模式

```python
from django.urls import path, include

urlpatterns = [
    # 其他URL模式...
    path('', include(router.urls)),
]
```

### 完整示例

```python
# your_app/urls.py
from django.urls import path, include
from your_app.views import YourViewSet
from utils.routers import OptionalSlashRouter

# 创建支持可选斜杠的路由器
router = OptionalSlashRouter()
router.register(r'', YourViewSet, basename='your_model')

urlpatterns = [
    # 支持带斜杠和不带斜杠的路由
    # - GET /your_model 或 /your_model/ → 列表
    # - POST /your_model 或 /your_model/ → 新增
    # - GET /your_model/{id} 或 /your_model/{id}/ → 详情
    # - PUT /your_model/{id} 或 /your_model/{id}/ → 全量更新
    # - PATCH /your_model/{id} 或 /your_model/{id}/ → 局部更新
    # - DELETE /your_model/{id} 或 /your_model/{id}/ → 删除
    path('', include(router.urls)),
]
```

### 支持的URL模式

使用OptionalSlashRouter后，以下URL都会正常工作：

- `/api/your_model` 和 `/api/your_model/` - 列表和创建
- `/api/your_model/1` 和 `/api/your_model/1/` - 详情、更新和删除

### 迁移现有代码

如果你之前使用了两个单独的路由器类，可以按以下步骤迁移：

1. 删除自定义的NoSlashRouter和WithSlashRouter类
2. 导入OptionalSlashRouter
3. 创建单个路由器实例
4. 注册ViewSet
5. 更新urlpatterns，使用单个include语句

## 复杂查询工具类 (filters.py)

提供了一套完整的复杂查询解决方案，包括过滤器基类、混入类和ViewSet混入类。

### 主要组件

#### BaseComplexFilter
基础复杂过滤器类，提供常用的查询字段：
- `status`: 状态查询
- `create_time_start/end`: 创建时间范围
- `update_time_start/end`: 更新时间范围  
- `search`: 全局关键词搜索

#### ComplexQueryMixin
ViewSet混入类，为ViewSet添加完整的复杂查询功能：
- 自动配置过滤、搜索、排序后端
- 提供`advanced_search`高级搜索接口
- 提供`filter_options`筛选选项接口
- 支持分页功能

#### 其他混入类
- `TextSearchMixin`: 文本搜索功能
- `DateRangeFilterMixin`: 日期范围过滤
- `NumberRangeFilterMixin`: 数字范围过滤

### 使用示例

```python
from utils.filters import BaseComplexFilter, ComplexQueryMixin

# 1. 创建自定义过滤器
class MyModelFilter(BaseComplexFilter):
    name = django_filters.CharFilter(field_name='name', lookup_expr='icontains')
    
    def filter_search(self, queryset, name, value):
        if value:
            return queryset.filter(Q(name__icontains=value))
        return queryset
    
    class Meta:
        model = MyModel
        fields = ['name', 'status', 'create_time_start', 'create_time_end', 'search']

# 2. 在ViewSet中使用
class MyModelViewSet(ComplexQueryMixin, viewsets.ModelViewSet):
    queryset = MyModel.objects.all()
    serializer_class = MyModelSerializer
    filterset_class = MyModelFilter
    search_fields = ['name']
    ordering_fields = ['id', 'name', 'create_time']
```

### 自动获得的API接口

- `GET /mymodel/`: 基础列表，支持所有过滤参数
- `GET /mymodel/advanced-search/`: 高级搜索接口
- `GET /mymodel/filter-options/`: 获取筛选选项

### 支持的查询参数

- 基础参数: `status`, `create_time_start`, `create_time_end`, `search`
- 排序: `ordering` (如: `?ordering=-create_time`)
- 分页: `page`, `page_size`
- 自定义字段: 根据过滤器定义

详细使用示例请参考 `complex_query_example.py` 文件。

## 分页工具类 (pagination.py)

提供了灵活的分页功能，支持多种分页场景：

### 主要组件

1. **CustomPageNumberPagination** - 自定义分页类
   - 默认每页10条记录
   - 提供基本的分页信息
   - 支持自定义每页大小
   - 最大每页100条记录

### 分页响应格式

```json
{
    "count": 25,           // 总记录数
    "total_pages": 3,     // 总页数
    "current_page": 1,    // 当前页码
    "page_size": 10,      // 每页大小
    "next": "http://...", // 下一页链接
    "previous": null,     // 上一页链接
    "results": [...]      // 数据列表
}
```

### 使用示例

```python
# 在ViewSet中使用分页
class MyModelViewSet(viewsets.ModelViewSet):
    queryset = MyModel.objects.all()
    serializer_class = MyModelSerializer
    pagination_class = CustomPageNumberPagination
```

### 支持的查询参数

- `page` - 页码（默认为1）
- `page_size` - 每页大小（可自定义，受max_page_size限制）

### API接口示例

- `GET /api/model/` - 默认分页
- `GET /api/model/?page=2` - 第2页
- `GET /api/model/?page_size=5` - 每页5条
- `GET /api/model/?page=2&page_size=15` - 第2页，每页15条

### 配置说明

在settings.py中配置全局分页：

```python
REST_FRAMEWORK = {
    'DEFAULT_PAGINATION_CLASS': 'rest_framework.pagination.PageNumberPagination',
    'PAGE_SIZE': 10,
    'PAGE_SIZE_QUERY_PARAM': 'page_size',
    'MAX_PAGE_SIZE': 100,
}
```

## 高级搜索功能

### 概述

高级搜索功能基于增强的`create_complex_filter_class`函数，能够自动检测模型字段并创建相应的过滤器，支持多种搜索方式的组合使用。

### 功能特性

1. **自动字段检测**: 自动分析模型字段并创建对应的过滤器
2. **多种搜索类型**: 支持模糊搜索、精确匹配、范围查询
3. **全局搜索**: 支持跨多个字段的关键词搜索
4. **时间范围查询**: 支持日期和时间字段的范围查询
5. **组合搜索**: 所有搜索参数可以任意组合使用

### 使用方法

#### 1. 在ViewSet中启用高级搜索

```python
from utils.filters import create_complex_filter_class
from .models import YourModel

class YourModelViewSet(viewsets.ModelViewSet):
    queryset = YourModel.objects.all()
    serializer_class = YourModelSerializer
    # 启用高级搜索，指定全局搜索字段
    filterset_class = create_complex_filter_class(
        YourModel, 
        search_fields=['name', 'description']  # 全局搜索字段
    )
```

#### 2. 支持的搜索参数类型

- **字符串字段**: 自动创建模糊搜索过滤器（使用`icontains`）
- **数字字段**: 自动创建精确匹配过滤器
- **日期字段**: 自动创建范围查询过滤器（`字段名_start`和`字段名_end`）
- **状态字段**: 继承自基础过滤器的精确匹配
- **时间字段**: 继承自基础过滤器的范围查询（`create_time_start/end`, `update_time_start/end`）

#### 3. API使用示例

以部门管理为例，支持以下搜索参数：

```
# 基础查询
GET /department/

# 分页查询
GET /department/?page=1&page_size=5

# 部门名称模糊搜索
GET /department/?dep_name=技术

# 备注模糊搜索
GET /department/?remark=负责

# 状态精确匹配
GET /department/?status=1

# 创建时间范围查询
GET /department/?create_time_start=2025-01-01&create_time_end=2025-01-31

# 更新时间范围查询
GET /department/?update_time_start=2025-01-01&update_time_end=2025-01-31

# 全局搜索（搜索部门名称和备注）
GET /department/?search=技术

# 组合搜索
GET /department/?page=1&page_size=5&dep_name=技术部&status=1&remark=开发&create_time_start=2025-01-01&create_time_end=2025-01-31
```

#### 4. 高级配置

```python
# 禁用自动字段检测，手动指定过滤器
filterset_class = create_complex_filter_class(
    YourModel,
    search_fields=['name', 'description'],
    auto_detect_fields=False,  # 禁用自动检测
    extra_filters={
        'custom_field': django_filters.CharFilter(
            field_name='custom_field',
            lookup_expr='exact'
        )
    }
)
```

### 测试

使用提供的测试脚本验证高级搜索功能：

```bash
python tools/test_advanced_search.py
```

测试脚本会自动创建测试数据并验证各种搜索场景。

### 注意事项

- 确保utils包在Django的INSTALLED_APPS中或者可以被正确导入
- 这个路由器会生成两倍的URL模式，但不会影响性能
- 反向路由解析会优先使用不带斜杠的模式
- 使用复杂查询功能需要安装`django-filter`包
- 确保在`INSTALLED_APPS`中添加了`django_filters`
- 高级搜索功能会自动检测模型字段，无需手动配置过滤器
- 所有搜索参数都支持组合使用，提供灵活的查询能力