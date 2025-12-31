import os
import sys
import django
from django.urls import resolve, reverse

# Configure Django (ensure project root with manage.py is on sys.path)
CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_ROOT = os.path.join(os.path.dirname(CURRENT_DIR), 'UniDjango')  # .../UniDjango/UniDjango
if PROJECT_ROOT not in sys.path:
    sys.path.insert(0, PROJECT_ROOT)

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'UniDjango.settings')
django.setup()

TEST_URLS = [
    '/department',
    '/department/',
    '/department/1',
    '/department/1/',
]

print('=== reverse() checks for named routes ===')
try:
    list_url = reverse('department-list')
    print(f"reverse('department-list') -> {list_url}")
except Exception as e:
    print(f"reverse('department-list') -> ERROR: {e}")

try:
    detail_url = reverse('department-detail', args=[1])
    print(f"reverse('department-detail', args=[1]) -> {detail_url}")
except Exception as e:
    print(f"reverse('department-detail', args=[1]) -> ERROR: {e}")

print('\n=== resolve() checks ===')
for url in TEST_URLS:
    try:
        match = resolve(url)
        view_name = getattr(match, 'view_name', None)
        url_name = getattr(match, 'url_name', None)
        func = match.func
        actions = getattr(func, 'actions', None)
        print(f"OK  {url:15} -> view_name={view_name!r} url_name={url_name!r} actions={actions}")
    except Exception as e:
        print(f"ERR {url:15} -> {e.__class__.__name__}: {e}")

# --- Inspect department router urls directly ---
print('\n=== Inspect department.urls.router.urls ===')
from importlib import import_module
mod = import_module('department.urls')
for p in mod.router.urls:
    try:
        pattern = getattr(p.pattern, 'regex', None) or getattr(p.pattern, '_regex', None)
    except Exception:
        pattern = None
    name = getattr(p, 'name', None)
    print(f"name={name!r} pattern={getattr(p.pattern, 'regex', None) or getattr(p.pattern, '_regex', None)}")

print('\n=== Router internals ===')
from department.urls import router as dep_router
print('router class =', dep_router.__class__.__name__)
print('router.trailing_slash =', repr(dep_router.trailing_slash))
try:
    routes = dep_router.routes
    for idx, r in enumerate(routes):
        print(f'route[{idx}] url={getattr(r, "url", None)!r} name={getattr(r, "name", None)!r} mapping={getattr(r, "mapping", None)}')
except Exception as e:
    print('error reading routes:', e)