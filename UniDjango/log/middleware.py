import time
import json
import traceback
from django.utils.deprecation import MiddlewareMixin
from log.models import SysLog

class RequestLogMiddleware(MiddlewareMixin):
    """
    请求日志中间件
    """

    def process_request(self, request):
        request.start_time = time.time()

    def process_response(self, request, response):
        if hasattr(request, 'start_time'):
            cost_time = (time.time() - request.start_time) * 1000
        else:
            cost_time = 0

        # 过滤掉不需要记录的请求 (静态资源等)
        path = request.path
        if path.startswith('/media') or path.startswith('/static') or path.startswith('/favicon.ico'):
            return response

        # 获取用户信息
        user = request.user if request.user.is_authenticated else None
        
        # 获取请求参数
        try:
            if request.method == 'GET':
                params = json.dumps(request.GET.dict(), ensure_ascii=False)
            elif request.method in ['POST', 'PUT', 'PATCH', 'DELETE']:
                if request.content_type == 'application/json':
                    params = json.dumps(json.loads(request.body), ensure_ascii=False)
                else:
                    params = json.dumps(request.POST.dict(), ensure_ascii=False)
            else:
                params = ''
        except:
            params = ''

        # 敏感信息脱敏 (如密码)
        if 'password' in params:
            try:
                data = json.loads(params)
                if 'password' in data:
                    data['password'] = '******'
                params = json.dumps(data, ensure_ascii=False)
            except:
                pass

        # 获取IP
        x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
        if x_forwarded_for:
            ip = x_forwarded_for.split(',')[0]
        else:
            ip = request.META.get('REMOTE_ADDR')

        # 记录日志 (仅记录非ERROR类型，ERROR在process_exception中记录，或者根据response status判断)
        # 如果 status >= 500，通常意味着服务器错误，但也可能是由 process_exception 捕获并处理后的结果
        # 这里主要记录正常的审计日志
        if response.status_code < 500:
            SysLog.objects.create(
                user=user,
                ip=ip,
                method=request.method,
                path=path,
                params=params[:2000], # 截断过长的参数
                status=response.status_code,
                cost_time=cost_time,
                log_type='INFO'
            )

        return response

    def process_exception(self, request, exception):
        # 捕获异常
        if hasattr(request, 'start_time'):
            cost_time = (time.time() - request.start_time) * 1000
        else:
            cost_time = 0

        # 获取IP
        x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
        if x_forwarded_for:
            ip = x_forwarded_for.split(',')[0]
        else:
            ip = request.META.get('REMOTE_ADDR')

        user = request.user if request.user.is_authenticated else None
        
        # 记录异常日志
        SysLog.objects.create(
            user=user,
            ip=ip,
            method=request.method,
            path=request.path,
            params='', # 异常时参数可能解析失败，暂不记录或尝试记录
            status=500,
            cost_time=cost_time,
            log_type='ERROR',
            error_msg=str(exception),
            traceback=traceback.format_exc()
        )
        
        return None # 返回None，交给Django默认的异常处理机制或后续中间件
