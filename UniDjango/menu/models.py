from django.db import models
from rest_framework import serializers

from role.models import SysRole


# Create your models here.

class SysMenu(models.Model):
    """
    菜单表
    """
    id = models.AutoField(primary_key=True, verbose_name='菜单ID')
    name = models.CharField(max_length=50, unique=True, verbose_name='菜单名称')
    icon = models.CharField(max_length=50, null=True, verbose_name='菜单图标')
    parent_id = models.IntegerField(null=True, verbose_name='父菜单ID')
    order_num = models.IntegerField(null=True, verbose_name='排序号')
    path = models.CharField(max_length=200, null=True, verbose_name='菜单路径')
    component = models.CharField(max_length=200, null=True, verbose_name='组件路径')
    menu_type = models.CharField(max_length=20, null=True, verbose_name='菜单类型')  # 'M' for menu, 'C' for component, 'F' for Button
    perms = models.CharField(max_length=100, null=True, verbose_name='权限标识')  # 权限标识，格式为：system:user:add
    create_time = models.DateField(null=True, verbose_name='创建时间')
    update_time = models.DateField(null=True, verbose_name='更新时间')
    remark = models.CharField(max_length=200, null=True, verbose_name='备注')

    class Meta:
        db_table = 'sys_menu'
        verbose_name = '菜单表'
        verbose_name_plural = verbose_name
       


class SysMenuSerializer(serializers.ModelSerializer):
    """
    菜单序列化器
    """
    class Meta:
        model = SysMenu
        fields = ('id', 'name', 'icon', 'parent_id', 'order_num', 'path', 'component', 'menu_type', 'perms', 'remark')


class SysRoleMenu(models.Model):
    """
    角色菜单关联表
    """
    id = models.AutoField(primary_key=True, verbose_name='关联ID')
    role = models.ForeignKey(SysRole, on_delete=models.PROTECT, verbose_name='角色ID')
    menu = models.ForeignKey(SysMenu, on_delete=models.PROTECT, verbose_name='菜单ID')

    class Meta:
        db_table = 'sys_role_menu'
        verbose_name = '角色菜单关联表'
        verbose_name_plural = verbose_name


class SysRoleMenuSerializer(serializers.ModelSerializer):
    """
    角色菜单关联序列化器
    """
    class Meta:
        model = SysRoleMenu
        fields = '__all__'