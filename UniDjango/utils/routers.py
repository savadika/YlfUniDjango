from rest_framework.routers import SimpleRouter
from django.urls import path, include

class OptionalSlashRouter(SimpleRouter):
    """
    支持可选斜杠的路由器
    同时生成带斜杠和不带斜杠的URL模式
    """
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # 创建两个内部路由器实例
        self.no_slash_router = SimpleRouter(*args, **kwargs)
        self.no_slash_router.trailing_slash = ''
        
        self.with_slash_router = SimpleRouter(*args, **kwargs)
        self.with_slash_router.trailing_slash = '/'
    
    def register(self, prefix, viewset, basename=None):
        """
        在两个路由器中都注册ViewSet
        """
        self.no_slash_router.register(prefix, viewset, basename)
        self.with_slash_router.register(prefix, viewset, basename)
    
    def get_urls(self):
        """
        返回合并后的URL列表
        """
        urls = []
        urls.extend(self.no_slash_router.get_urls())
        urls.extend(self.with_slash_router.get_urls())
        return urls
    
    @property
    def urls(self):
        """
        返回URL模式
        """
        return self.get_urls()

def create_optional_slash_urlpatterns(router):
    """
    创建支持可选斜杠的URL模式
    
    Args:
        router: OptionalSlashRouter实例
    
    Returns:
        包含路由的urlpatterns列表
    """
    return [
        path('', include(router.urls)),
    ]