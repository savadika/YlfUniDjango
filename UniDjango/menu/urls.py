from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import SysMenuViewSet

router = DefaultRouter()
router.register(r'', SysMenuViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
