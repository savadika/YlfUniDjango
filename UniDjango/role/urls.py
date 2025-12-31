from django.urls import path, include
from role.views import SysRoleViewSet
from utils.routers import OptionalSlashRouter

# 创建支持可选斜杠的路由器
router = OptionalSlashRouter()
router.register(r'', SysRoleViewSet, basename='role')

urlpatterns = [
    path('', include(router.urls)),
]