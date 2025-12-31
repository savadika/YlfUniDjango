import os
import sys
import django
from django.urls import resolve, reverse
from django.core.exceptions import ImproperlyConfigured
from django.test.utils import override_settings

# 设置Django环境
project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, project_root)
sys.path.insert(0, os.path.join(project_root, 'UniDjango'))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'UniDjango.settings')
django.setup()

# 添加testserver到ALLOWED_HOSTS
from django.conf import settings
if 'testserver' not in settings.ALLOWED_HOSTS:
    settings.ALLOWED_HOSTS.append('testserver')

def test_url_patterns():
    """测试所有URL模式是否支持可选斜杠"""
    from django.test import Client
    
    # 测试用户模块路由
    user_urls = [
        '/user',
        '/user/',
        '/user/1',
        '/user/1/',
        '/user/test',
        '/user/gen_token',
        '/user/use_token',
        '/user/get_user_info',
        '/user/logout',
    ]
    
    # 测试部门模块路由
    department_urls = [
        '/department',
        '/department/',
        '/department/1',
        '/department/1/',
    ]
    
    # 测试HTTP方法的URL
    api_test_urls = [
        ('/user', ['GET', 'POST']),
        ('/user/', ['GET', 'POST']),
        ('/user/1', ['GET', 'PUT', 'PATCH', 'DELETE']),
        ('/user/1/', ['GET', 'PUT', 'PATCH', 'DELETE']),
        ('/department', ['GET', 'POST']),
        ('/department/', ['GET', 'POST']),
        ('/department/1', ['GET', 'PUT', 'PATCH', 'DELETE']),
        ('/department/1/', ['GET', 'PUT', 'PATCH', 'DELETE']),
    ]
    
    print("=== 用户模块路由测试 ===")
    for url in user_urls:
        try:
            match = resolve(url)
            print(f"✓ {url} -> {match.view_name} ({match.func.__name__ if hasattr(match.func, '__name__') else match.func.__class__.__name__})")
        except Exception as e:
            print(f"✗ {url} -> {type(e).__name__}: {e}")
    
    print("\n=== 部门模块路由测试 ===")
    for url in department_urls:
        try:
            match = resolve(url)
            print(f"✓ {url} -> {match.view_name} ({match.func.__name__ if hasattr(match.func, '__name__') else match.func.__class__.__name__})")
        except Exception as e:
            print(f"✗ {url} -> {type(e).__name__}: {e}")
    
    print("\n=== HTTP方法测试 ===")
    client = Client()
    for url, methods in api_test_urls:
        print(f"\n测试URL: {url}")
        for method in methods:
            try:
                if method == 'GET':
                    response = client.get(url)
                elif method == 'POST':
                    response = client.post(url, {'test': 'data'}, content_type='application/json')
                elif method == 'PUT':
                    response = client.put(url, {'test': 'data'}, content_type='application/json')
                elif method == 'PATCH':
                    response = client.patch(url, {'test': 'data'}, content_type='application/json')
                elif method == 'DELETE':
                    response = client.delete(url)
                
                # 检查响应状态码（不是404说明路由匹配成功）
                if response.status_code != 404:
                    print(f"  ✓ {method} -> {response.status_code}")
                else:
                    print(f"  ✗ {method} -> 404 (路由未匹配)")
                    
            except Exception as e:
                print(f"  ✗ {method} -> {type(e).__name__}: {e}")
    
    print("\n=== 反向路由测试 ===")
    try:
        # 测试用户模块反向路由
        user_list_url = reverse('user-list')
        user_detail_url = reverse('user-detail', kwargs={'pk': 1})
        print(f"✓ user-list -> {user_list_url}")
        print(f"✓ user-detail -> {user_detail_url}")
        
        # 测试部门模块反向路由
        dept_list_url = reverse('department-list')
        dept_detail_url = reverse('department-detail', kwargs={'pk': 1})
        print(f"✓ department-list -> {dept_list_url}")
        print(f"✓ department-detail -> {dept_detail_url}")
        
    except Exception as e:
        print(f"✗ 反向路由错误: {type(e).__name__}: {e}")

if __name__ == '__main__':
    test_url_patterns()