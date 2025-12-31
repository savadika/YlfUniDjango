import os
import sys
import django
import json
import requests

# Set up Django environment
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'UniDjango'))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'UniDjango.settings')
django.setup()

from user.models import SysUser
from role.models import SysRole
from menu.models import SysMenu, SysRoleMenu

def test_update_permissions():
    base_url = "http://127.0.0.1:8000"
    username = "test_perm_updater"
    password = "password123"

    # 1. 准备数据
    # 创建测试用户
    if not SysUser.objects.filter(username=username).exists():
        SysUser.objects.create(username=username, password=password, email='test_perm@example.com')
    
    # 创建测试角色
    role, _ = SysRole.objects.get_or_create(name="TestRole_PermUpdate", defaults={'code': 'test_perm'})
    print(f"测试角色 ID: {role.id}")

    # 创建几个测试菜单
    menu1, _ = SysMenu.objects.get_or_create(name="TestMenu_P1", defaults={'order_num': 1})
    menu2, _ = SysMenu.objects.get_or_create(name="TestMenu_P2", defaults={'order_num': 2})
    menu3, _ = SysMenu.objects.get_or_create(name="TestMenu_P3", defaults={'order_num': 3})
    
    # 初始状态：只给角色分配 menu1
    SysRoleMenu.objects.filter(role=role).delete()
    SysRoleMenu.objects.create(role=role, menu=menu1)
    print(f"初始权限: {[menu1.id]}")

    # 2. 登录获取 Token
    resp = requests.post(f"{base_url}/user/gen_token", json={"username": username, "password": password})
    if resp.status_code != 200:
        print("登录失败")
        return
    token = resp.json().get('token')

    # 3. 调用更新接口
    # 目标：把权限更新为 [menu2, menu3] (去掉了 menu1)
    new_perms = [menu2.id, menu3.id]
    print(f"\n正在更新权限为: {new_perms} ...")
    
    headers = {"Authorization": token}
    update_url = f"{base_url}/role/{role.id}/permissions/"
    update_resp = requests.put(update_url, json={"permissions": new_perms}, headers=headers)

    print(f"响应状态码: {update_resp.status_code}")
    print(f"响应内容: {update_resp.text}")

    # 4. 验证数据库
    current_perms = list(SysRoleMenu.objects.filter(role=role).values_list('menu_id', flat=True))
    current_perms.sort()
    expected_perms = sorted(new_perms)
    
    if current_perms == expected_perms:
        print(f"\n✅ 验证成功! 数据库当前权限: {current_perms}")
    else:
        print(f"\n❌ 验证失败! 预期: {expected_perms}, 实际: {current_perms}")

    # 5. 清理数据
    print("\n清理测试数据...")
    SysRoleMenu.objects.filter(role=role).delete()
    role.delete()
    menu1.delete()
    menu2.delete()
    menu3.delete()
    SysUser.objects.filter(username=username).delete()

if __name__ == "__main__":
    test_update_permissions()
