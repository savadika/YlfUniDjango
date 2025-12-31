# 使用官方 Python 3.12 镜像作为基础镜像 (Django 5.x 需要 Python 3.10+)
FROM python:3.12-slim

# 设置工作目录
WORKDIR /app

# 设置环境变量
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 复制 requirements.txt 到工作目录
COPY requirements.txt /app/

# 安装项目依赖
RUN pip install --upgrade pip -i https://pypi.tuna.tsinghua.edu.cn/simple && \
    pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

# 复制当前目录下的所有文件到工作目录
COPY . /app/

# 添加等待脚本
COPY wait-for-mysql.sh /wait-for-mysql.sh
RUN chmod +x /wait-for-mysql.sh
RUN apt-get update && apt-get install -y netcat-openbsd

# 暴露端口 8000
EXPOSE 8000

# 启动命令
ENTRYPOINT ["/wait-for-mysql.sh"]
CMD ["gunicorn", "UniDjango.wsgi:application", "--bind", "0.0.0.0:8000"]
