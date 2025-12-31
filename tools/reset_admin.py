import os
import sys
import django

sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'UniDjango'))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'UniDjango.settings')
django.setup()

from user.models import SysUser
from django.contrib.auth.hashers import make_password

def reset_admin():
    username = "admin"
    password = "password123"
    
    try:
        user = SysUser.objects.get(username=username)
        print(f"User {username} found. Resetting password.")
        user.password = make_password(password)
        user.save()
        print("Done.")
    except SysUser.DoesNotExist:
        print(f"User {username} not found! Creating...")
        user = SysUser(
            username=username,
            password=make_password(password),
            email="admin@example.com",
            phone="13800138000",
            status=1
        )
        user.save()
        print("Created.")

if __name__ == "__main__":
    reset_admin()
