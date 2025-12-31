import os
import sys
import django
import json
import requests

# 设置 Django 环境 (为了方便生成测试数据，虽然这里主要用 requests)
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'UniDjango'))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'UniDjango.settings')
django.setup()

from user.models import SysUser
from menu.models import SysMenu

def test_get_all_menus_api():
    base_url = "http://127.0.0.1:8000"
    
    # 1. 确保有一个测试用户 (复用之前的逻辑)
    username = "test_admin_for_menu"
    password = "password123"
    
    # 确保用户存在 (如果被之前的清理脚本删了)
    if not SysUser.objects.filter(username=username).exists():
        SysUser.objects.create(username=username, password=password, email='test_menu_all@example.com')

    # 2. 确保有一些测试菜单数据 (包含按钮)
    # 创建一个测试根菜单
    root_menu, _ = SysMenu.objects.get_or_create(
        name='TestRootMenu_All',
        defaults={'menu_type': 'M', 'path': '/test_root', 'order_num': 999}
    )
    # 创建一个子菜单
    sub_menu, _ = SysMenu.objects.get_or_create(
        name='TestSubMenu_All',
        defaults={'menu_type': 'C', 'parent_id': root_menu.id, 'order_num': 1}
    )
    # 创建一个按钮
    btn_menu, _ = SysMenu.objects.get_or_create(
        name='TestBtn_All',
        defaults={'menu_type': 'F', 'perms': 'test:all:btn', 'parent_id': sub_menu.id, 'order_num': 1}
    )
    
    print(f"测试数据准备: Root={root_menu.id}, Sub={sub_menu.id}, Btn={btn_menu.id}")

    # 3. 获取 Token
    print("\n正在登录获取 Token...")
    login_data = {
        "username": username,
        "password": password
    }
    
    try:
        resp = requests.post(f"{base_url}/user/gen_token", json=login_data)
        if resp.status_code != 200:
            print(f"登录请求失败: {resp.status_code}")
            return
            
        resp_json = resp.json()
        if resp_json.get('code') != 200:
            print(f"登录失败: {resp_json}")
            return

        token = resp_json.get('token')
        print(f"获取 Token 成功")
        
        # 4. 请求 get_all_menus 接口
        print("\n请求全量菜单接口 (/menu/get_all_menus/)...")
        headers = {
            "Authorization": token
        }
        
        # 注意：这里是 list route，不需要 ID
        menu_resp = requests.get(f"{base_url}/menu/get_all_menus/", headers=headers)
        
        print(f"响应状态码: {menu_resp.status_code}")
        
        if menu_resp.status_code == 200:
            data = menu_resp.json()
            # print("响应内容 (前500字符):")
            # print(json.dumps(data, indent=2, ensure_ascii=False)[:500])
            
            menu_list = data.get('data', [])
            print(f"返回顶级菜单数量: {len(menu_list)}")
            
            # 验证是否包含我们的测试菜单
            found_root = False
            found_btn = False
            
            # 递归查找
            def find_menu(nodes, target_id, is_btn=False):
                for node in nodes:
                    if node['id'] == target_id:
                        return True
                    if node.get('children'):
                        if find_menu(node['children'], target_id, is_btn):
                            return True
                return False

            if find_menu(menu_list, root_menu.id):
                print("✅ 验证通过: 找到了测试根菜单")
                found_root = True
            else:
                print("❌ 验证失败: 未找到测试根菜单")
                
            if find_menu(menu_list, btn_menu.id):
                print("✅ 验证通过: 找到了测试按钮节点 (证明包含了 menu_type='F')")
                found_btn = True
            else:
                print("❌ 验证失败: 未找到测试按钮节点")

        else:
            print(f"接口调用失败: {menu_resp.text}")
        
    except Exception as e:
        print(f"发生错误: {e}")
        
    # 清理数据
    print("\n清理测试数据...")
    SysMenu.objects.filter(id__in=[root_menu.id, sub_menu.id, btn_menu.id]).delete()

if __name__ == "__main__":
    test_get_all_menus_api()
