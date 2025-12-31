from django.urls import path, include
from auto.views import  SysAutoViewSet
from utils.routers import OptionalSlashRouter

# 创建支持可选斜杠的路由器
router = OptionalSlashRouter()
router.register(r'', SysAutoViewSet, basename='auto')

urlpatterns = [
    # 支持带斜杠和不带斜杠的路由
    # - GET /department 或 /department/ → 部门列表
    # - POST /department 或 /department/ → 新增部门
    # - GET /department/{id} 或 /department/{id}/ → 部门详情
    # - PUT /department/{id} 或 /department/{id}/ → 全量更新
    # - PATCH /department/{id} 或 /department/{id}/ → 局部更新
    # - DELETE /department/{id} 或 /department/{id}/ → 删除
    path('', include(router.urls)),
]