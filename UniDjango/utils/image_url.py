from rest_framework import serializers
from django.conf import settings
import json

class AbsoluteUrlField(serializers.Field):
    """
    自定义字段：将相对路径转换为带域名的完整绝对路径
    适用于图片、文件等需要前端直接访问的资源字段
    支持：
    1. 单个路径字符串/FieldFile对象
    2. 逗号分隔的路径字符串 ("path1,path2")
    3. 路径列表 (["path1", "path2"])
    """
    def _get_absolute_url(self, path, request):
        if not path:
            return None
        
        # 将 value 转为字符串，如果是 FieldFile 对象会自动获取其 url 属性或字符串表示
        url_str = str(path)

        # 如果已经是绝对路径 (http开头)，直接返回
        if url_str.startswith('http'):
            return url_str
            
        if request:
            # 如果 value 是 FileField/ImageField 对象，它通常有 .url 属性（带 /media/ 前缀）
            if hasattr(path, 'url'):
                final_path = path.url
            else:
                # 检查是否已经包含了 MEDIA_URL 前缀，防止重复拼接
                if url_str.startswith(settings.MEDIA_URL):
                    final_path = url_str
                else:
                    # 确保 MEDIA_URL 末尾有 / 而 url_str 开头没有 /，或者处理好拼接
                    media_url = settings.MEDIA_URL
                    if not media_url.endswith('/'):
                        media_url += '/'
                    
                    if url_str.startswith('/'):
                        url_str = url_str[1:]
                        
                    final_path = media_url + url_str

            return request.build_absolute_uri(final_path)
            
        # 如果没有 request 上下文，尽量返回原本的值或者相对路径
        return url_str

    def to_representation(self, value):
        if not value:
            return None
            
        request = self.context.get('request')
        
        # 情况1: 列表或元组 (直接是Python列表对象)
        if isinstance(value, (list, tuple)):
            return [self._get_absolute_url(item, request) for item in value]
            
        # 情况2: 字符串处理
        if isinstance(value, str):
            # 尝试解析 JSON (如果是 JSON 字符串存储的列表)
            if value.strip().startswith('[') and value.strip().endswith(']'):
                try:
                    json_value = json.loads(value)
                    if isinstance(json_value, list):
                        return [self._get_absolute_url(item, request) for item in json_value]
                except (json.JSONDecodeError, TypeError):
                    pass

            # 尝试按逗号分隔 (如果是逗号分隔的字符串，且包含多个文件)
            # 注意：如果文件名本身包含逗号可能会有问题，但通常文件路径不建议包含逗号
            if ',' in value:
                paths = [item.strip() for item in value.split(',') if item.strip()]
                # 如果分割后确实有多个，返回列表；如果只有一个（比如末尾逗号），还是当做单个处理也可以，这里统一返回列表
                return [self._get_absolute_url(item, request) for item in paths]
                
        # 情况3: 单个对象/字符串 (包括单个 FieldFile 对象)
        return self._get_absolute_url(value, request)
