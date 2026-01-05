# UniDjango 开发指南

基于 Docker 的 Django + Vue 前后端分离全栈开发环境。

## 🚀 快速开始

# 🚀 快速开发部署指南 / Quick Start Development Guide

本文档介绍如何从 Git 拉取代码后，在服务器上快速启动**开发模式**。

This guide explains how to pull code from Git and quickly start **development mode** on your server.

---

## 1. 环境准备 (Prerequisites)

在开始之前，请确保服务器已安装以下软件：
- **Git**: 用于拉取代码
- **Docker Engine**: 用于运行容器
- **Docker Compose**: 用于编排服务

## 2. 部署步骤 (Steps)

### 第一步：克隆代码 (Clone Repository)

```bash
git clone https://github.com/savadika/YlfUniDjango.git
cd YlfUniDjango
```

### 第二步：配置环境变量 (Setup Environment)

项目根目录包含一个 `.env.example` 模板文件。你需要将其复制为 `.env` 并根据需要修改。

```bash
# 复制配置文件
cp .env.example .env

# (可选) 修改配置，例如数据库密码或端口
# vim .env
```

**⚠️ 注意**：如果你的服务器端口（如 8080, 8000, 3306）已被占用，请在 `.env` 中修改对应的对外端口（`FRONTEND_DEV_PORT`, `BACKEND_PORT`, `MYSQL_PORT`）。

### 第三步：启动开发模式 (Start Development Mode)

使用 `docker-compose-dev.yml` 启动容器。这会挂载当前目录的代码，实现热重载（修改代码后自动生效）。

```bash
# 后台构建并启动
docker-compose -f docker-compose-dev.yml up -d --build

# 查看日志 (按 Ctrl+C 退出)
docker-compose -f docker-compose-dev.yml logs -f
```

### 第四步：初始化数据库 (Initialize Database)

```
# 停止容器
docker-compose -f docker-compose-dev.yml down
# 删除旧的数据库文件 (这步是关键) 
Remove-Item -Recurse -Force .\db_data
# 重新构建并启动 (需要等待一段时间，1分钟左右)
docker-compose -f docker-compose-dev.yml up -d --build

```


## 🛠 常用操作

| 目标 | 命令 |
| --- | --- |
| **重启后端** | `docker-compose -f docker-compose.yml -f docker-compose-dev.yml restart backend` |
| **重启前端** | `docker-compose -f docker-compose.yml -f docker-compose-dev.yml restart frontend` |
| **查看日志** | `docker logs -f ylf-django` 或 `docker logs -f ylf-vue` |
| **进入容器** | `docker exec -it ylf-django bash` |
| **创建APP** | `docker exec -it ylf-django python manage.py startapp <app_name>` |
| **完全重置** | `docker-compose -f docker-compose.yml -f docker-compose-dev.yml down -v` (慎用，会删数据) |