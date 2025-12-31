from rest_framework import viewsets, serializers, permissions
from rest_framework.decorators import action
from rest_framework.response import Response
from django.db import transaction
from .models import SysRole
from menu.models import SysRoleMenu
from utils.pagination import CustomPageNumberPagination
from utils.filters import create_complex_filter_class


class SysRoleSerializer(serializers.ModelSerializer):
    class Meta:
        model = SysRole
        fields = ('id', 'name', 'code', 'create_time', 'update_time', 'remark')


class SysRoleViewSet(viewsets.ModelViewSet):
    """
    角色资源：提供列表、详情、创建、更新、局部更新、删除
    路由由 SimpleRouter 生成：/department 与 /department/{id}
    支持分页功能和高级搜索功能
    
    支持的搜索参数：
    - name: 角色名称模糊搜索
    - remark: 备注模糊搜索
    - create_time_start/create_time_end: 创建时间范围
    - update_time_start/update_time_end: 更新时间范围
    - search: 全局搜索（搜索部门名称和备注）
    """
    queryset = SysRole.objects.all().order_by('id')  # 查询集
    serializer_class = SysRoleSerializer             # 序列化器
    permission_classes = [permissions.AllowAny]     # 允许所有用户访问
    pagination_class = CustomPageNumberPagination   # 自定义分页类
    filterset_class = create_complex_filter_class(SysRole, search_fields=['name', 'code', 'remark', 'create_time', 'update_time'])  # 动态创建的过滤器类，查询
    http_method_names = ['get', 'post', 'put', 'patch', 'delete', 'head', 'options']   # 允许的HTTP方法

    @action(detail=True, methods=['get'])
    def menus(self, request, pk=None):
        """
        获取指定角色的菜单树和权限列表
        url: /role/{id}/menus/
        """
        role = self.get_object()
        menu_tree, permissions = role.get_role_menus()  
        return Response({
            'code': 200,
            'data': {
                'menus': menu_tree,
                'permissions': permissions
            }
        })

    @action(detail=True, methods=['put'], url_path='permissions')
    def update_permissions(self, request, pk=None):
        """
        更新角色权限（自定义）
        url: /role/{id}/permissions/
        method: PUT
        body: { "permissions": [1, 2, 3, ...] }
        """
        role = self.get_object()
        permissions = request.data.get('permissions', [])
        
        if not isinstance(permissions, list):
            return Response({'code': 400, 'message': 'permissions must be a list'}, status=400)

        try:
            with transaction.atomic():
                # 1. 删除旧的权限
                SysRoleMenu.objects.filter(role=role).delete()
                
                # 2. 插入新的权限
                new_relations = []
                for menu_id in permissions:
                    # 可以在这里做个校验，确保 menu_id 存在，或者利用数据库外键约束报错
                    # 为了性能，这里批量创建，假设前端传的 ID 都是有效的
                    new_relations.append(SysRoleMenu(role=role, menu_id=menu_id))
                
                # 只有当有新权限时才执行批量创建
                if len(new_relations) > 0:
                    SysRoleMenu.objects.bulk_create(new_relations)
                    
            return Response({'code': 200, 'message': '权限更新成功'})
            
        except Exception as e:
            # 捕获可能的数据库完整性错误（如无效的 menu_id）
            return Response({'code': 500, 'message': f'更新失败: {str(e)}'}, status=500)



# Create your views here.
