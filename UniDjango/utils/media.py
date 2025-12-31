from typing import Optional
from django.conf import settings


def build_absolute_media_url(request, path: Optional[str]) -> Optional[str]:
    """
    将头像/媒体资源路径补全为可直接访问的绝对 URL：
    - 若 path 为空，则使用默认头像 avatars/default.png
    - 若为完整 http(s) 链接，原样返回
    - 若以 "/" 开头，当作站内绝对路径，直接用 request.build_absolute_uri 补全
    - 其他情况，先用 MEDIA_URL 拼接为 /media/xxx，再用 build_absolute_uri 补全
    """
    default_rel = 'avatars/default.png'
    if not path:
        path = default_rel

    # 已是完整 URL
    if isinstance(path, str) and (path.startswith('http://') or path.startswith('https://')):
        return path

    # 以 / 开头，视为站内绝对路径
    if path.startswith('/'):
        return request.build_absolute_uri(path)

    # 其余情况，拼接 MEDIA_URL
    media_url = getattr(settings, 'MEDIA_URL', '/media/') or '/media/'
    if not media_url.endswith('/'):
        media_url = media_url + '/'

    # 去掉可能的前缀 'media/'，避免重复
    if path.startswith('media/'):
        path = path[len('media/'):]

    url_path = f"{media_url}{path}"
    return request.build_absolute_uri(url_path)