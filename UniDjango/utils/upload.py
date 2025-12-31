import os
import uuid
import datetime
from django.conf import settings
from django.core.files.storage import default_storage
from django.core.files.base import ContentFile
from rest_framework import permissions
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser

class UploadFileView(APIView):
    """
    通用文件上传接口
    POST /upload/
    """
    permission_classes = [permissions.AllowAny] # 允许未登录上传，或者根据需求改为 IsAuthenticated
    parser_classes = [MultiPartParser]
    # 如果需要控制权限，可以在这里添加 permission_classes
    # permission_classes = [permissions.IsAuthenticated] 

    def post(self, request, format=None):  
        # 支持多文件上传
        files = request.FILES.getlist('file')
        print(f"DEBUG: Files found under 'file' key: {len(files)}")
        for i, f in enumerate(files):
            print(f"DEBUG: File {i+1}: name={f.name}, size={f.size}, content_type={f.content_type}")
        
        # 兼容单文件上传（如果前端只传了一个文件，且不是list形式，getlist也能处理，但如果是单个key多次提交或者数组形式，getlist是标准做法）
        # 如果 request.FILES 中 'file' 键只对应一个文件，getlist 也会返回一个列表
        
        if not files:
            return Response({
                "code": 400,
                "message": "未找到文件，请检查参数名是否为 'file'",
                "data": None
            }, status=400)

        uploaded_urls = []
        
        for file_obj in files:
            # 生成保存路径: uploads/YYYY/MM/DD/uuid.ext
            ext = os.path.splitext(file_obj.name)[1]
            unique_name = f"{uuid.uuid4().hex}{ext}"
            
            today = datetime.date.today()
            rel_path = f"uploads/{today.year}/{today.month:02d}/{today.day:02d}/{unique_name}"
            
            # 保存文件
            file_name = default_storage.save(rel_path, ContentFile(file_obj.read()))
            print(f"保存文件: {file_name}")

            # 拼接完整访问 URL (用于返回给前端展示)
            full_url = request.build_absolute_uri(settings.MEDIA_URL + file_name)
              
            uploaded_urls.append({
                "url": full_url,
                "path": file_name  # 这是 default_storage.save 返回的相对路径
            })

        # 调整返回格式以适应多文件/单文件
        if len(uploaded_urls) == 1:
            data = {"url": uploaded_urls[0]['path']} # 只返回相对路径
        else:
            data = {
                "files": [item['path'] for item in uploaded_urls], 
                "url": uploaded_urls[0]['path'], # 兼容旧字段，只返回相对路径
            }

        return Response({
            "code": 200,
            "message": "上传成功",
            "data": data
        })
