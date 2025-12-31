import os
import sys
import django
import requests
import time

# Set up Django environment
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'UniDjango'))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'UniDjango.settings')
django.setup()

from log.models import SysLog

def test_error_logging():
    base_url = "http://127.0.0.1:8000"
    url = f"{base_url}/user/test_error"
    
    print(f"Calling error endpoint: {url}")
    try:
        response = requests.get(url)
        print(f"Response status: {response.status_code}")
    except Exception as e:
        print(f"Request failed (as expected if server crashes? No, django handles 500): {e}")

    # Wait a bit for log to be written (sync but just in case)
    time.sleep(1)
    
    # Check DB
    print("Checking SysLog...")
    # Get latest log
    log = SysLog.objects.filter(path='/user/test_error').order_by('-create_time').first()
    
    if log:
        print("✅ Found log entry!")
        print(f"ID: {log.id}")
        print(f"Type: {log.log_type}")
        print(f"Status: {log.status}")
        print(f"Error Msg: {log.error_msg}")
        print(f"Traceback len: {len(log.traceback) if log.traceback else 0}")
        
        if log.log_type == 'ERROR' and 'division by zero' in log.error_msg:
            print("✅ Verification Success: Error was logged correctly.")
        else:
            print("❌ Verification Failed: Log content incorrect.")
    else:
        print("❌ Verification Failed: No log entry found.")

if __name__ == "__main__":
    test_error_logging()
