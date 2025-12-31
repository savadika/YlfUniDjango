from django.http import HttpResponse
from django.utils.deprecation import MiddlewareMixin
from rest_framework_jwt.settings import api_settings
from jwt import ExpiredSignatureError,InvalidTokenError,PyJWTError
from user.models import SysUser


class JwtAuthenticationMiddleware(MiddlewareMixin):
    """
    jwt解析中间件，如果不通过token认证，则返回401错误。
    """

    def process_request(self, request):
        """
        Process the request to authenticate the user using JWT.
        """
        white_list = ['/user/gen_token', '/upload/']  # 白名单，放行的url
        path = request.path            # 获取请求的路径
        
        # 放行静态资源、Swagger文档、以及白名单接口
        if path in white_list or path.startswith("/media") or path.startswith("/swagger") or path.startswith("/redoc"):
            print("不需要token认证")
            return None
            
        if path not in white_list and not path.startswith("/media"):
            token = request.META.get('HTTP_AUTHORIZATION')
            try:
                # print(f"DEBUG: Token received type: {type(token)}")
                # print(f"DEBUG: Token content: {token}")
                if isinstance(token, str):
                    token = token.encode('utf-8')
                
                payload = api_settings.JWT_DECODE_HANDLER(token)  # 尝试解码token,成功就放行
                user_id = payload.get('user_id')
                user = SysUser.objects.get(id=user_id)
                request.user = user # 将用户信息附加到request中
            except ExpiredSignatureError:
                print("token已过期")
                return HttpResponse('{"code":401,"message":"token已过期"}', content_type='application/json')
            except InvalidTokenError as e:
                print(f"无效的token: {e}")
                return HttpResponse('{"code":401,"message":"无效的token"}', content_type='application/json')
            except PyJWTError:
                return HttpResponse('{"code":401,"message":"token解析错误"}', content_type='application/json')
            except SysUser.DoesNotExist:
                return HttpResponse('{"code":401,"message":"用户不存在"}', content_type='application/json')
        else:
            print("不需要token认证")
            return None
            