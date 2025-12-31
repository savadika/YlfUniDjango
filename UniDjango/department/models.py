from django.db import models

# Create your models here.
class SysDep(models.Model):
    """
    部门模型
    """
    id = models.AutoField(primary_key=True, verbose_name='部门ID')
    dep_name = models.CharField(max_length=150, unique=True, verbose_name='部门名称')
    status = models.IntegerField(null=True, default=1, choices=[(1, '正常'), (0, '禁用')], verbose_name='状态')
    create_time = models.DateField(null=True, verbose_name='创建时间')
    update_time = models.DateField(null=True, verbose_name='更新时间')
    remark = models.CharField(max_length=500, null=True, verbose_name='备注')

    class Meta:
        db_table = 'sys_department'
        verbose_name = '部门'
        verbose_name_plural = verbose_name

# Create your models here.
