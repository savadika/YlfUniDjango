from rest_framework import viewsets, serializers, permissions
from .models import SysAuto
from utils.pagination import CustomPageNumberPagination
from utils.filters import create_complex_filter_class


class SysAutoSerializer(serializers.ModelSerializer):
    class Meta:
        model = SysAuto
        fields = ('id', 'dep_name', 'status', 'create_time', 'update_time', 'remark')


class SysAutoViewSet(viewsets.ModelViewSet):
    """
    自动代码资源：提供列表、详情、创建、更新、局部更新、删除
    路由由 SimpleRouter 生成：/department 与 /department/{id}
    支持分页功能和高级搜索功能
    
    支持的搜索参数：
    - dep_name: 部门名称模糊搜索
    - remark: 备注模糊搜索
    - status: 状态精确匹配
    - create_time_start/create_time_end: 创建时间范围
    - update_time_start/update_time_end: 更新时间范围
    - search: 全局搜索（搜索部门名称和备注）
    """
    queryset = SysAuto.objects.all().order_by('id')  # 查询集
    serializer_class = SysAutoSerializer             # 序列化器
    permission_classes = [permissions.AllowAny]     # 允许所有用户访问
    pagination_class = CustomPageNumberPagination   # 自定义分页类
    filterset_class = create_complex_filter_class(SysAuto, search_fields=['dep_name', 'remark'])  # 动态创建的过滤器类，查询
    http_method_names = ['get', 'post', 'put', 'patch', 'delete', 'head', 'options']   # 允许的HTTP方法

# Create your views here.
