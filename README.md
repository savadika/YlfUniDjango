# UniDjango 开发指南

基于 Docker 的 Django + Vue 前后端分离全栈开发环境。

## 🚀 快速开始

### 1. 启动开发环境
修改代码后浏览器自动刷新 (Hot Reload)。

```bash
docker-compose  -f docker-compose-dev.yml up
```

- **前端**: http://localhost:9528
- **后端**: http://localhost:8000
- **数据库**: localhost:3308

### 2. 部署上线 (生产模式)
使用 Nginx 托管前端静态文件。

```bash
docker-compose up -d --build
```

- **访问**: http://localhost (默认 80 端口)

---

## 🛠 常用操作

| 目标 | 命令 |
| --- | --- |
| **重启后端** | `docker-compose -f docker-compose.yml -f docker-compose-dev.yml restart backend` |
| **重启前端** | `docker-compose -f docker-compose.yml -f docker-compose-dev.yml restart frontend` |
| **查看日志** | `docker logs -f ylf-django` 或 `docker logs -f ylf-vue` |
| **进入容器** | `docker exec -it ylf-django bash` |
| **创建APP** | `docker exec -it ylf-django python manage.py startapp <app_name>` |
| **完全重置** | `docker-compose -f docker-compose.yml -f docker-compose-dev.yml down -v` (慎用，会删数据) |