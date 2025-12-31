from django_filters import rest_framework as django_filters
from django.db.models import Q
from rest_framework import filters
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.decorators import action
from rest_framework.response import Response
from django.db import models


class BaseComplexFilter(django_filters.FilterSet):
    """
    基础复杂查询过滤器类
    提供通用的查询字段和方法，其他模块可以继承使用
    """
    
    # 通用的时间范围查询字段
    create_time_start = django_filters.DateFilter(field_name='create_time', lookup_expr='gte', label='创建时间开始')
    create_time_end = django_filters.DateFilter(field_name='create_time', lookup_expr='lte', label='创建时间结束')
    update_time_start = django_filters.DateFilter(field_name='update_time', lookup_expr='gte', label='更新时间开始')
    update_time_end = django_filters.DateFilter(field_name='update_time', lookup_expr='lte', label='更新时间结束')
    
    # 通用的状态查询
    status = django_filters.NumberFilter(field_name='status', label='状态')
    
    # 全局搜索字段（子类需要重写filter_search方法）
    search = django_filters.CharFilter(method='filter_search', label='关键词搜索')
    
    def filter_search(self, queryset, name, value):
        """
        全局关键词搜索方法
        子类应该重写此方法来定义具体的搜索逻辑
        """
        if value:
            # 默认实现：如果模型有name字段，则在name字段中搜索
            if hasattr(queryset.model, 'name'):
                return queryset.filter(name__icontains=value)
            # 如果有title字段，则在title字段中搜索
            elif hasattr(queryset.model, 'title'):
                return queryset.filter(title__icontains=value)
        return queryset
    
    class Meta:
        abstract = True
        fields = ['create_time_start', 'create_time_end', 'update_time_start', 'update_time_end', 'status', 'search']


class ComplexQueryMixin:
    """
    复杂查询混入类
    为ViewSet提供复杂查询功能，包括高级搜索和筛选选项接口
    """
    
    # 默认的过滤、搜索、排序配置
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    search_fields = []  # 子类需要定义
    ordering_fields = ['id', 'create_time', 'update_time']  # 默认可排序字段
    ordering = ['id']  # 默认排序
    
    @action(detail=False, methods=['get'], url_path='advanced-search')
    def advanced_search(self, request):
        """
        高级搜索接口
        支持复杂的查询条件组合
        
        通用查询参数：
        - create_time_start: 创建时间开始（YYYY-MM-DD）
        - create_time_end: 创建时间结束（YYYY-MM-DD）
        - update_time_start: 更新时间开始（YYYY-MM-DD）
        - update_time_end: 更新时间结束（YYYY-MM-DD）
        - status: 状态
        - search: 关键词搜索
        - ordering: 排序字段（如：id, -id）
        - page: 页码
        - page_size: 每页数量
        """
        # 获取查询参数
        queryset = self.filter_queryset(self.get_queryset())
        
        # 分页
        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)
        
        serializer = self.get_serializer(queryset, many=True)
        return Response({
            'code': 200,
            'message': '查询成功',
            'data': serializer.data,
            'total': queryset.count()
        })
    
    @action(detail=False, methods=['get'], url_path='filter-options')
    def filter_options(self, request):
        """
        获取筛选选项
        返回可用的筛选条件选项
        """
        model = self.get_queryset().model
        options = {
            'ordering_options': self.get_ordering_options()
        }
        
        # 如果模型有status字段，获取状态选项
        if hasattr(model, 'status'):
            status_field = model._meta.get_field('status')
            if hasattr(status_field, 'choices') and status_field.choices:
                options['status_options'] = [
                    {'value': choice[0], 'label': choice[1]} 
                    for choice in status_field.choices
                ]
        
        # 获取时间范围
        date_range = self.get_date_range()
        if date_range:
            options['date_range'] = date_range
        
        return Response({
            'code': 200,
            'message': '获取筛选选项成功',
            'data': options
        })
    
    def get_ordering_options(self):
        """
        获取排序选项
        子类可以重写此方法来自定义排序选项
        """
        ordering_options = []
        
        for field in self.ordering_fields:
            # 获取字段的verbose_name
            try:
                model = self.get_queryset().model
                field_obj = model._meta.get_field(field)
                field_label = field_obj.verbose_name
            except:
                field_label = field
            
            ordering_options.extend([
                {'value': field, 'label': f'{field_label}升序'},
                {'value': f'-{field}', 'label': f'{field_label}降序'}
            ])
        
        return ordering_options
    
    def get_date_range(self):
        """
        获取日期范围
        """
        model = self.get_queryset().model
        date_fields = []
        
        # 检查常见的日期字段
        for field_name in ['create_time', 'update_time', 'created_at', 'updated_at']:
            if hasattr(model, field_name):
                date_fields.append(field_name)
        
        if not date_fields:
            return None
        
        # 构建聚合查询
        aggregate_dict = {}
        for field in date_fields:
            aggregate_dict[f'min_{field}'] = models.Min(field)
            aggregate_dict[f'max_{field}'] = models.Max(field)
        
        date_range_data = model.objects.aggregate(**aggregate_dict)
        
        result = {}
        for field in date_fields:
            result[field] = {
                'min': date_range_data.get(f'min_{field}'),
                'max': date_range_data.get(f'max_{field}')
            }
        
        return result


class TextSearchMixin:
    """
    文本搜索混入类
    提供通用的文本搜索功能
    """
    
    @classmethod
    def create_text_search_filter(cls, search_fields):
        """
        创建文本搜索过滤器
        
        Args:
            search_fields: 要搜索的字段列表，如 ['name', 'description']
        
        Returns:
            过滤器方法
        """
        def filter_search(self, queryset, name, value):
            if value and search_fields:
                q_objects = Q()
                for field in search_fields:
                    q_objects |= Q(**{f'{field}__icontains': value})
                return queryset.filter(q_objects)
            return queryset
        
        return filter_search


class DateRangeFilterMixin:
    """
    日期范围过滤混入类
    提供通用的日期范围过滤功能
    """
    
    @classmethod
    def create_date_range_filters(cls, date_field):
        """
        创建日期范围过滤器
        
        Args:
            date_field: 日期字段名，如 'create_time'
        
        Returns:
            包含开始和结束日期过滤器的字典
        """
        return {
            f'{date_field}_start': django_filters.DateFilter(
                field_name=date_field, 
                lookup_expr='gte', 
                label=f'{date_field}开始'
            ),
            f'{date_field}_end': django_filters.DateFilter(
                field_name=date_field, 
                lookup_expr='lte', 
                label=f'{date_field}结束'
            )
        }


class NumberRangeFilterMixin:
    """
    数字范围过滤混入类
    提供通用的数字范围过滤功能
    """
    
    @classmethod
    def create_number_range_filters(cls, number_field):
        """
        创建数字范围过滤器
        
        Args:
            number_field: 数字字段名，如 'price'
        
        Returns:
            包含最小值和最大值过滤器的字典
        """
        return {
            f'{number_field}_min': django_filters.NumberFilter(
                field_name=number_field, 
                lookup_expr='gte', 
                label=f'{number_field}最小值'
            ),
            f'{number_field}_max': django_filters.NumberFilter(
                field_name=number_field, 
                lookup_expr='lte', 
                label=f'{number_field}最大值'
            )
        }


def create_complex_filter_class(model, search_fields=None, extra_filters=None, auto_detect_fields=True):
    """
    动态创建复杂查询过滤器类
    
    Args:
        model: Django模型类
        search_fields: 搜索字段列表，用于全局搜索
        extra_filters: 额外的过滤器字典
        auto_detect_fields: 是否自动检测模型字段并创建过滤器
    
    Returns:
        动态创建的过滤器类
    """
    class_name = f'{model.__name__}ComplexFilter'
    
    # 基础字段列表
    base_fields = ['create_time_start', 'create_time_end', 'update_time_start', 'update_time_end', 'status', 'search']
    
    # 基础属性
    attrs = {}
    
    # 自动检测模型字段并创建过滤器
    if auto_detect_fields:
        for field in model._meta.get_fields():
            if hasattr(field, 'name') and not field.name.startswith('_'):
                field_name = field.name
                
                # 跳过已经在基础过滤器中定义的字段
                if field_name in ['create_time', 'update_time', 'status', 'id']:
                    continue
                
                # 为字符串字段创建模糊搜索过滤器
                if isinstance(field, models.CharField) or isinstance(field, models.TextField):
                    attrs[field_name] = django_filters.CharFilter(
                        field_name=field_name,
                        lookup_expr='icontains',
                        label=getattr(field, 'verbose_name', field_name)
                    )
                    base_fields.append(field_name)
                
                # 为数字字段创建精确匹配过滤器
                elif isinstance(field, (models.IntegerField, models.BigIntegerField, models.SmallIntegerField)):
                    if field_name != 'status':  # status已经在基础类中定义
                        attrs[field_name] = django_filters.NumberFilter(
                            field_name=field_name,
                            label=getattr(field, 'verbose_name', field_name)
                        )
                        base_fields.append(field_name)
                
                # 为外键字段创建精确匹配过滤器
                elif isinstance(field, models.ForeignKey):
                    attrs[field_name] = django_filters.NumberFilter(
                        field_name=field_name,
                        label=getattr(field, 'verbose_name', field_name)
                    )
                    base_fields.append(field_name)
                
                # 为日期字段创建范围过滤器
                elif isinstance(field, (models.DateField, models.DateTimeField)):
                    if field_name not in ['create_time', 'update_time']:  # 这些已经在基础类中定义
                        attrs[f'{field_name}_start'] = django_filters.DateFilter(
                            field_name=field_name,
                            lookup_expr='gte',
                            label=f'{getattr(field, "verbose_name", field_name)}开始'
                        )
                        attrs[f'{field_name}_end'] = django_filters.DateFilter(
                            field_name=field_name,
                            lookup_expr='lte',
                            label=f'{getattr(field, "verbose_name", field_name)}结束'
                        )
                        base_fields.extend([f'{field_name}_start', f'{field_name}_end'])
    
    # 设置Meta类
    attrs['Meta'] = type('Meta', (), {
        'model': model,
        'fields': base_fields
    })
    
    # 添加搜索方法
    if search_fields:
        attrs['filter_search'] = TextSearchMixin.create_text_search_filter(search_fields)
    
    # 添加额外的过滤器
    if extra_filters:
        attrs.update(extra_filters)
        # 将额外过滤器的字段名添加到fields列表中
        for key in extra_filters.keys():
            if key not in base_fields and not key.startswith('filter_'):
                base_fields.append(key)
        attrs['Meta'] = type('Meta', (), {
            'model': model,
            'fields': base_fields
        })
    
    # 动态创建类
    return type(class_name, (BaseComplexFilter,), attrs)