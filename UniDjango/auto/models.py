from django.db import models

# Create your models here.
class SysAuto(models.Model):
    """
    自动代码模型
    """
    id = models.AutoField(primary_key=True, verbose_name='自动代码ID')
    dep_name = models.CharField(max_length=150, unique=True, verbose_name='自动代码名称')
    status = models.IntegerField(null=True, default=1, choices=[(1, '正常'), (0, '禁用')], verbose_name='状态')
    create_time = models.DateField(null=True, verbose_name='创建时间')
    update_time = models.DateField(null=True, verbose_name='更新时间')
    remark = models.CharField(max_length=500, null=True, verbose_name='备注')

    class Meta:
        db_table = 'sys_auto'
        verbose_name = '自动代码'
        verbose_name_plural = verbose_name

# Create your models here.

# Create your models here.
