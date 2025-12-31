import requests
import json

BASE_URL = "http://127.0.0.1:8000"

def test_get_user_info():
    print("Testing Get User Info for admin...")
    
    # 1. Login to get token
    login_resp = requests.post(f"{BASE_URL}/user/gen_token", json={
        "username": "admin",
        "password": "password123"
    })
    
    if login_resp.status_code != 200:
        print(f"Login failed: {login_resp.text}")
        return

    token = login_resp.json().get('token')
    print("Token obtained.")
    
    headers = {
        "Authorization": token
    }

    # 2. Get User Info
    info_resp = requests.get(f"{BASE_URL}/user/get_user_info", headers=headers)
    
    print(f"Status: {info_resp.status_code}")
    if info_resp.status_code == 200:
        data = info_resp.json()
        print("Response Data:")
        print(json.dumps(data, indent=4, ensure_ascii=False))
        
        user_data = data.get('data', {})
        avatar = user_data.get('avatar')
        print(f"\nAvatar URL: {avatar}")
    else:
        print(f"Failed: {info_resp.text}")

if __name__ == "__main__":
    test_get_user_info()
