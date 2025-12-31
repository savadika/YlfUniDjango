from django.urls import include, path
from utils.routers import OptionalSlashRouter
from .views import SysLogViewSet

router = OptionalSlashRouter()
router.register(r'', SysLogViewSet, basename='log')

urlpatterns = [
    path('', include(router.urls)),
]
