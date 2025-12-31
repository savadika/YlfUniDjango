import os
import sys
import django
from django.contrib.auth.hashers import make_password

# Set up Django environment
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'UniDjango'))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'UniDjango.settings')
django.setup()

from user.models import SysUser

def update_passwords():
    usernames = ["admin", "ylf"]
    raw_password = "Pm6yj3333"
    
    for username in usernames:
        try:
            user = SysUser.objects.get(username=username)
            # Check if password needs update (optional, but here we force update as requested)
            print(f"Updating password for user: {username}")
            user.set_password(raw_password)
            user.save()
            print(f"Password updated successfully for {username}")
        except SysUser.DoesNotExist:
            print(f"User {username} not found")
        except Exception as e:
            print(f"Error updating {username}: {e}")

if __name__ == "__main__":
    update_passwords()
