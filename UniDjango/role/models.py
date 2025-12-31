from django.db import models
from rest_framework import serializers


# Create your models here.

class SysRole(models.Model):
    """
    角色表
    """
    id = models.AutoField(primary_key=True, verbose_name='角色ID')
    name = models.CharField(max_length=50, null=True, verbose_name='角色名称')
    code = models.CharField(max_length=50, null=True, verbose_name='角色编码')
    create_time = models.DateField(null=True, verbose_name='创建时间')
    update_time = models.DateField(null=True, verbose_name='更新时间')
    remark = models.CharField(max_length=200, null=True, verbose_name='备注')

    class Meta:
        db_table = 'sys_role'
        verbose_name = '角色表'
        verbose_name_plural = verbose_name


    def get_role_menus(self):
        """
        获取角色菜单（树形结构）和权限列表
        返回: (menu_tree, permission_list)
        """
        # 解决循环引入问题
        from menu.models import SysMenu, SysRoleMenu

        # 根据角色id查询出菜单id
        role_menu_qs = SysRoleMenu.objects.filter(role_id=self.id)
        menu_ids = list(role_menu_qs.values_list('menu_id', flat=True).distinct())
        # 根据菜单id查询出菜单
        menus = SysMenu.objects.filter(id__in=menu_ids).order_by('order_num', 'id')

        # 收集权限标识
        permissions = set()
        for m in menus:
            if m.perms:
                permissions.add(m.perms)

        # 构建树形结构
        nodes_by_id = {}
        roots = []

        # 先构建节点字典
        for m in menus:
            # 过滤掉按钮类型的菜单（不显示在菜单栏），或者根据需求决定是否包含
            # 这里我们只构建菜单树，按钮通常不显示在导航栏中
            # if m.menu_type == 'F':
            #     continue
                
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
            # 顶级：parent_id 为 0/None，或父级不在授权菜单中
            if pid in (None, 0) or pid not in nodes_by_id:
                roots.append(node)
            else:
                nodes_by_id[pid]['children'].append(node)

        # 递归排序（按 order_num、再按 id）
        def sort_children(n):
            n['children'].sort(key=lambda x: (x['order_num'] is None, x['order_num'], x['id']))
            for c in n['children']:
                sort_children(c)

        roots.sort(key=lambda x: (x['order_num'] is None, x['order_num'], x['id']))
        for r in roots:
            sort_children(r)

        return roots, list(permissions)


class SysRoleSerializer(serializers.ModelSerializer):
    """
    角色序列化器
    """
    class Meta:
        model = SysRole
        fields = '__all__'


class SysUserRole(models.Model):
    """
    用户角色关联表
    """ 
    id = models.AutoField(primary_key=True, verbose_name='关联ID')
    user = models.ForeignKey('user.SysUser', on_delete=models.PROTECT, verbose_name='用户ID')
    role = models.ForeignKey(SysRole, on_delete=models.PROTECT, verbose_name='角色ID')

    class Meta:
        db_table = 'sys_user_role'
        verbose_name = '用户角色关联表'
        verbose_name_plural = verbose_name


class SysUserRoleSerializer(serializers.ModelSerializer):
    """
    用户角色关联序列化器
    """
    class Meta:
        model = SysUserRole
        fields = '__all__'