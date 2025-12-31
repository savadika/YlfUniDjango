from rest_framework import viewsets, permissions
from rest_framework.decorators import action
from rest_framework.response import Response
from .models import SysMenu, SysMenuSerializer
from utils.pagination import CustomPageNumberPagination
from utils.filters import create_complex_filter_class

class SysMenuViewSet(viewsets.ModelViewSet):
    """
    菜单资源：提供列表、详情、创建、更新、局部更新、删除
    """
    queryset = SysMenu.objects.all().order_by('order_num', 'id')
    serializer_class = SysMenuSerializer
    permission_classes = [permissions.AllowAny]
    pagination_class = CustomPageNumberPagination
    filterset_class = create_complex_filter_class(SysMenu, search_fields=['name', 'path', 'component', 'perms', 'remark'])
    http_method_names = ['get', 'post', 'put', 'patch', 'delete', 'head', 'options']

    @action(detail=False, methods=['get'])
    def get_all_menus(self, request):
        """
        获取所有菜单（树形结构），包含按钮
        通常用于菜单管理页面展示，或角色授权时的菜单树选择
        url: /menu/get_all_menus/
        """
        menus = SysMenu.objects.all().order_by('order_num', 'id')
        
        # 构建树形结构
        nodes_by_id = {}
        roots = []

        # 先构建节点字典
        for m in menus:
            nodes_by_id[m.id] = {
                'id': m.id,
                'name': m.name,
                'icon': m.icon,
                'parent_id': m.parent_id,
                'order_num': m.order_num,
                'path': m.path,
                'component': m.component,
                'menu_type': m.menu_type,
                'perms': m.perms,
                'remark': m.remark,
                'children': []
            }

        # 组装父子关系
        for node in nodes_by_id.values():
            pid = node['parent_id']
            # 顶级：parent_id 为 0/None，或父级不在列表中（防断链）
            if pid in (None, 0) or pid not in nodes_by_id:
                roots.append(node)
            else:
                nodes_by_id[pid]['children'].append(node)

        # 递归排序
        def sort_children(n):
            n['children'].sort(key=lambda x: (x['order_num'] is None, x['order_num'], x['id']))
            for c in n['children']:
                sort_children(c)

        roots.sort(key=lambda x: (x['order_num'] is None, x['order_num'], x['id']))
        for r in roots:
            sort_children(r)

        return Response({
            'code': 200,
            'data': roots
        })
