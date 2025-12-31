from django.urls import path, include

from user.views import GenerateToken, GetUserInfo, LogOut, UseToken, TestView, SysUserViewSet, TestErrorView
from utils.routers import OptionalSlashRouter

# 创建支持可选斜杠的路由器
router = OptionalSlashRouter()
router.register(r'', SysUserViewSet, basename='user')


urlpatterns = [
    path('test', TestView.as_view(), name='test'),  # 测试
    path('test_error', TestErrorView.as_view(), name='test_error'),  # 测试异常日志
    path('gen_token', GenerateToken.as_view(), name='gen_token'),  # 测试生成token
    path('use_token', UseToken.as_view(), name='use_token'),  # 测试使用token
    path('get_user_info', GetUserInfo.as_view(), name='get_user_info'),  # 测试生成token
    path('logout', LogOut.as_view(), name='logout'),  # 退出登录

    # 支持带斜杠和不带斜杠的路由
    # - GET /user 或 /user/ → 用户列表
    # - POST /user 或 /user/ → 新增用户
    # - GET /user/{id} 或 /user/{id}/ → 用户详情
    # - PUT /user/{id} 或 /user/{id}/ → 全量更新
    # - PATCH /user/{id} 或 /user/{id}/ → 局部更新
    # - DELETE /user/{id} 或 /user/{id}/ → 删除
    path('', include(router.urls)),
]



