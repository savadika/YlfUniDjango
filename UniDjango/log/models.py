from django.db import models
from user.models import SysUser

class SysLog(models.Model):
    """
    系统日志表
    """
    id = models.AutoField(primary_key=True, verbose_name='日志ID')
    user = models.ForeignKey(SysUser, on_delete=models.SET_NULL, null=True, verbose_name='操作用户')
    ip = models.CharField(max_length=50, null=True, verbose_name='访问IP')
    method = models.CharField(max_length=10, null=True, verbose_name='请求方式')
    path = models.CharField(max_length=255, null=True, verbose_name='请求路径')
    params = models.TextField(null=True, verbose_name='请求参数')
    status = models.IntegerField(default=200, verbose_name='响应状态码')
    cost_time = models.FloatField(null=True, verbose_name='耗时(ms)')
    create_time = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    
    # 错误监控字段
    log_type = models.CharField(max_length=10, default='INFO', verbose_name='日志类型') # INFO / ERROR
    error_msg = models.TextField(null=True, verbose_name='错误信息')
    traceback = models.TextField(null=True, verbose_name='堆栈详情')

    class Meta:
        db_table = 'sys_log'
        verbose_name = '系统日志'
        verbose_name_plural = verbose_name
        ordering = ['-create_time']
