import os
import sys
import django

# Set up Django environment
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'UniDjango'))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'UniDjango.settings')
django.setup()

from menu.models import SysMenu

def clean_test_menus():
    # 查找所有名字以 'Test' 开头的菜单
    # 包括 TestMenu1, TestBtn1, TestRootMenu_All 等
    test_menus = SysMenu.objects.filter(name__startswith='Test')
    count = test_menus.count()
    if count > 0:
        print(f"Found {count} test menus. Deleting...")
        for m in test_menus:
            print(f" - Deleting: {m.name} (ID: {m.id})")
        test_menus.delete()
        print("Deletion completed.")
    else:
        print("No test menus found.")

if __name__ == "__main__":
    clean_test_menus()
