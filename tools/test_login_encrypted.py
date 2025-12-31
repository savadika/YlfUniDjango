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

def test_login():
    base_url = "http://127.0.0.1:8000"
    username = "admin"
    password = "Pm6yj3333"

    print(f"Attempting login for {username} with password {password}...")
    try:
        resp = requests.post(f"{base_url}/user/gen_token", json={"username": username, "password": password})
        
        if resp.status_code == 200:
            data = resp.json()
            if data.get('code') == 200:
                print("✅ Login Success! Token generated.")
                print(f"Token: {data.get('token')[:20]}...")
            else:
                print(f"❌ Login Failed: {data}")
        else:
            print(f"❌ Request Failed: {resp.status_code}")
    except Exception as e:
        print(f"Exception: {e}")

if __name__ == "__main__":
    test_login()
