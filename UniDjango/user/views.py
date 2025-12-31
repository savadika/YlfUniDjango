import json
from django.http import JsonResponse
from django.shortcuts import render
from django.views import View
from django.db import transaction
from django.contrib.auth.hashers import check_password
from rest_framework_jwt.settings import api_settings
from user.models import SysUser
from role.models import SysUserRole
from rest_framework import viewsets, serializers, permissions
from django.conf import settings
from utils.media import build_absolute_media_url
from utils.pagination import CustomPageNumberPagination
from utils.filters import create_complex_filter_class

# Create your views here.
class TestView(View):

    def get(self, request):
        users_obj = SysUser.objects.all()    #queryset <obj,obj,obj>
        user_list = list(users_obj.values())  #先转成字典，再转成list,才能成为json格式的数据[{"a":"1","b":"2"},{},{}],比较麻烦
        return JsonResponse(user_list, safe=False)  #safe=False表示可以返回非字典类型的数据，默认是True，只能返回字典类型的数据
    

class TestErrorView(View):
    """
    测试异常日志
    """
    def get(self, request):
        # 故意抛出一个除零异常
        a = 1 / 0
        return JsonResponse({'message': '这行代码不会被执行'})

    

class GenerateToken(View):
    """
    测试生成token
    """
    def post(self, request):
        jwt_payload_handler = api_settings.JWT_PAYLOAD_HANDLER  # 生成token的载荷
        jwt_encode_handler = api_settings.JWT_ENCODE_HANDLER    # 生成token的编码函数
        # 根据request传递过来的用户和密码进行查询 
        data = json.loads(request.body)  
        username = data.get('username')
        password = data.get('password')
        if not username or not password:  # 如果没有用户名或密码，则返回错误
            return JsonResponse({'code': 400, 'message': '用户名或密码不能为空'})
        try:
            user = SysUser.objects.get(username=username)
            if check_password(password, user.password):
                payload = jwt_payload_handler(user)  # 生成token的载荷，包含用户信息等
                token = jwt_encode_handler(payload)  # 生成token    
                return JsonResponse({'code': 200, 'token': token})  # 返回生成的token
            else:
                return JsonResponse({'code': 404, 'message': '用户不存在或密码错误'})
        except SysUser.DoesNotExist:
            return JsonResponse({'code': 404, 'message': '用户不存在或密码错误'})
    

class UseToken(View):
    """
    测试使用token,没有token则无法访问
    """
    def get(self, request):
        token = request.META.get('HTTP_AUTHORIZATION')  # 获取请求头中的token
        if token is  not None:  
            # 获取user对象并放回    
            jwt_decode_handler = api_settings.JWT_DECODE_HANDLER
            try:
                payload = jwt_decode_handler(token)
                user = SysUser.objects.get(id=payload['user_id'])  # 获取用户对象
                return JsonResponse({'code': 200, 'message': f'欢迎 {user.username} 使用token访问系统'})
            except Exception as e:
                return JsonResponse({'code': 401, 'message': 'token无效或已过期'})
        else:
            return JsonResponse({'code': 401, 'message': 'token并不存在，请先获取token'})
        


class GetUserInfo(View):
    """
    获取用户信息
    """
    def get(self, request):
        token = request.META.get('HTTP_AUTHORIZATION')  # 获取请求头中的token
        if token is not None:
            jwt_decode_handler = api_settings.JWT_DECODE_HANDLER
            try:
                payload = jwt_decode_handler(token)
                user = SysUser.objects.get(id=payload['user_id'])  # 获取用户对象
                # print(user.get_role_menus())  # 打印用户角色菜单
                menu_tree, permissions = user.get_role_menus()
                avatar_url = build_absolute_media_url(request, user.avatar)
                user_info= {
                    'username': user.username,
                    'avatar': avatar_url,  # 头像（完整 URL，空则使用默认）
                    'menus': menu_tree,  # 用户角色菜单
                    'permissions': permissions # 权限标识列表
                }
                return JsonResponse({'code': 200, 'data': user_info})
            except Exception as e:
                return JsonResponse({'code': 401, 'message': 'token无效或已过期'})
        else:
            return JsonResponse({'code': 401, 'message': 'token not exist'})
        

class LogOut(View):
    """
    注销登录
    """
    def post(self, request):
        # 这里可以添加注销逻辑，比如清除session等
        return JsonResponse({'code': 200, 'message': '注销成功'})


    


class SysUserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True, required=False, allow_blank=True)
    roles = serializers.ListField(child=serializers.IntegerField(), write_only=True, required=False)

    class Meta:
        model = SysUser
        fields = (
            'id', 'department', 'username', 'password', 'avatar', 'email', 'phone',
            'login_date', 'status', 'create_time', 'update_time', 'remark', 'roles'
        )

    def create(self, validated_data):
        password = validated_data.pop('password', None)
        roles = validated_data.pop('roles', [])
        
        with transaction.atomic():
            user = SysUser(**validated_data)
            if password:
                user.set_password(password)
            user.save()
            
            # 处理角色关联
            if roles:
                new_relations = []
                for role_id in roles:
                    new_relations.append(SysUserRole(user=user, role_id=role_id))
                SysUserRole.objects.bulk_create(new_relations)
                
        return user

    def update(self, instance, validated_data):
        password = validated_data.pop('password', None)
        roles = validated_data.pop('roles', None)
        
        with transaction.atomic():
            for attr, value in validated_data.items():
                setattr(instance, attr, value)
            if password is not None:
                instance.set_password(password)
            instance.save()
            
            # 处理角色关联更新
            if roles is not None:
                # 先删除旧关联
                SysUserRole.objects.filter(user=instance).delete()
                # 再创建新关联
                new_relations = []
                for role_id in roles:
                    new_relations.append(SysUserRole(user=instance, role_id=role_id))
                SysUserRole.objects.bulk_create(new_relations)
                
        return instance

    def to_representation(self, instance):
        ret = super().to_representation(instance)
        # 获取用户角色备注列表
        role_remarks = SysUserRole.objects.filter(user=instance).values_list('role__remark', flat=True)
        ret['roles'] = list(role_remarks)
        return ret


class SysUserViewSet(viewsets.ModelViewSet):
    """
    用户资源：提供列表、详情、创建、更新、局部更新、删除
    路由由 SimpleRouter 生成：/user 与 /user/{id}
    支持分页功能和高级搜索功能
    
    支持的搜索参数：
    - username: 用户名模糊搜索
    - email: 邮箱模糊搜索
    - phone: 电话模糊搜索
    - remark: 备注模糊搜索
    - status: 状态精确匹配
    - create_time_start/create_time_end: 创建时间范围
    - update_time_start/update_time_end: 更新时间范围
    - search: 全局搜索（搜索用户名、邮箱、电话、备注）
    """
    queryset = SysUser.objects.all().order_by('id')
    serializer_class = SysUserSerializer
    permission_classes = [permissions.AllowAny]
    pagination_class = CustomPageNumberPagination   # 自定义分页类
    filterset_class = create_complex_filter_class(SysUser, search_fields=['username', 'email', 'phone', 'remark'])  # 动态创建的过滤器类，会自动包含department字段
    http_method_names = ['get', 'post', 'put', 'patch', 'delete', 'head', 'options']