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

def show_menus():
    base_url = "http://127.0.0.1:8000"
    username = "temp_viewer_001"
    password = "password123"

    # Ensure user exists
    user = SysUser.objects.filter(username=username).first()
    if not user:
        SysUser.objects.create(username=username, password=password, email='temp@example.com')
    else:
        # Ensure password matches (simple update)
        if user.password != password:
            user.password = password
            user.save()

    # Login
    print(f"Logging in as {username}...")
    resp = requests.post(f"{base_url}/user/gen_token", json={"username": username, "password": password})
    
    if resp.status_code != 200:
        print(f"Login request failed: {resp.status_code}")
        return
        
    resp_data = resp.json()
    if resp_data.get('code') != 200:
        print(f"Login failed: {resp_data}")
        return

    token = resp_data.get('token')
    print("Login successful. Fetching menus...")
    
    # Get Menus
    headers = {"Authorization": token}
    menu_resp = requests.get(f"{base_url}/menu/get_all_menus/", headers=headers)
    
    if menu_resp.status_code == 200:
        print("\n=== Menu Data Response ===")
        print(json.dumps(menu_resp.json(), indent=2, ensure_ascii=False))
        print("==========================")
    else:
        print(f"Error fetching menus: {menu_resp.status_code}")
        print(menu_resp.text)

if __name__ == "__main__":
    show_menus()
