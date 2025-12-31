import os
import sys
import django
import requests
import time

# Setup Django environment to access models
sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'UniDjango'))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'UniDjango.settings')
django.setup()

from log.models import SysLog

BASE_URL = "http://127.0.0.1:8000"

def test_logging():
    print("Clearing old logs...")
    SysLog.objects.all().delete()

    print("--- 1. Login ---")
    resp = requests.post(f"{BASE_URL}/user/gen_token", json={
        "username": "admin",
        "password": "password123" 
    })
    print(f"Login Status: {resp.status_code}")
    print(f"Login Response: {resp.text}")
    
    token = resp.json().get('token')
    if not token:
        print("No token, switching to 'testuser'")
        resp = requests.post(f"{BASE_URL}/user/gen_token", json={
            "username": "testuser",
            "password": "password123"
        })
        token = resp.json().get('token')
        print(f"Testuser Login Status: {resp.status_code}")

    if not token:
        print("Cannot get token, aborting.")
        return

    headers = {
        "Authorization": token,
        "Origin": "http://localhost:9528"
    }

    print("\n--- 2. Get User Info ---")
    resp = requests.get(f"{BASE_URL}/user/get_user_info", headers=headers)
    print(f"Get Info Status: {resp.status_code}")

    print("\n--- 3. Add Menu ---")
    import random
    rand_suffix = random.randint(1000, 9999)
    resp = requests.post(f"{BASE_URL}/menu/", json={
        "name": f"Log Test Menu {rand_suffix}",
        "path": f"/log-test-{rand_suffix}",
        "component": "log/test",
        "menu_type": "C",
        "order_num": 99
    }, headers=headers)
    print(f"Add Menu Status: {resp.status_code}")
    if resp.status_code != 201:
        print(f"Add Menu Error: {resp.text}")

    print("\n--- Checking Logs ---")
    # Give DB a moment? usually instant
    time.sleep(1)
    logs = SysLog.objects.all().order_by('create_time')
    for log in logs:
        user_name = log.user.username if log.user else "None"
        print(f"Path: {log.path}, Method: {log.method}, User: {user_name}, Status: {log.status}")

if __name__ == "__main__":
    test_logging()
