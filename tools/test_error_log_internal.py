import os
import sys
import django

# Set up Django environment FIRST
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'UniDjango'))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'UniDjango.settings')
django.setup()

# THEN import models and middleware
from django.test import RequestFactory
from django.contrib.auth.models import AnonymousUser
from user.views import TestErrorView
from log.models import SysLog
from log.middleware import RequestLogMiddleware

def test_error_logging_internal():
    factory = RequestFactory()
    request = factory.get('/user/test_error')
    request.user = AnonymousUser() # Mock user
    
    middleware = RequestLogMiddleware(lambda req: TestErrorView.as_view()(req))
    
    print("Processing request via Middleware...")
    try:
        response = middleware(request)
        print(f"Response status: {response.status_code}")
    except Exception as e:
        print(f"Caught expected exception: {e}")
        # Manually trigger process_exception
        middleware.process_exception(request, e)

    # Check DB
    print("Checking SysLog...")
    log = SysLog.objects.filter(path='/user/test_error').order_by('-create_time').first()
    
    if log:
        print("✅ Found log entry!")
        print(f"ID: {log.id}")
        print(f"Type: {log.log_type}")
        print(f"Status: {log.status}")
        print(f"Error Msg: {log.error_msg}")
        
        if log.log_type == 'ERROR' and 'division by zero' in str(log.error_msg):
            print("✅ Verification Success: Error was logged correctly.")
        else:
            print("❌ Verification Failed: Log content incorrect.")
    else:
        print("❌ Verification Failed: No log entry found.")

if __name__ == "__main__":
    test_error_logging_internal()
