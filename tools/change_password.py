import os
import sys
import django

# Setup Django environment
sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'UniDjango'))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'UniDjango.settings')
django.setup()

from user.models import SysUser
from django.contrib.auth.hashers import make_password

def change_admin_password():
    try:
        # 尝试获取 admin 用户
        user = SysUser.objects.get(username="admin")
        new_password = "Pm6yj3333"  # 您可以修改这里的密码
        user.password = make_password(new_password)
        user.save()
        print(f"✅ 成功修改用户 'admin' 的密码为: {new_password}")
    except SysUser.DoesNotExist:
        print("❌ 未找到用户 'admin'")
    except Exception as e:
        print(f"❌ 修改密码时发生错误: {e}")

if __name__ == "__main__":
    change_admin_password()
