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
git clone <你的Git仓库地址>
cd YlfUniDjango_V1
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

如果是首次启动，数据库是空的，需要执行迁移。

```bash
# 执行数据库迁移
docker-compose -f docker-compose-dev.yml exec backend python manage.py migrate

# (可选) 创建超级管理员
docker-compose -f docker-compose-dev.yml exec backend python manage.py createsuperuser
```

---

## 3. 访问地址 (Access)

启动成功后，你可以通过浏览器访问：

| 服务 (Service) | 地址 (URL) | 说明 (Note) |
| :--- | :--- | :--- |
| **前端 (Frontend)** | `http://<服务器IP>:9530` | 对应 .env 中的 `FRONTEND_DEV_PORT` |
| **后端 API (Backend)** | `http://<服务器IP>:8002` | 对应 .env 中的 `BACKEND_PORT` |
| **数据库 (MySQL)** | `tcp://<服务器IP>:3310` | 对应 .env 中的 `MYSQL_PORT` |

---

## 4. 常用命令 (Common Commands)

```bash
# 停止所有容器
docker-compose -f docker-compose-dev.yml down

# 重启后端服务 (如果修改了 Dockerfile 或 requirements.txt)
docker-compose -f docker-compose-dev.yml restart backend

# 查看容器状态
docker-compose -f docker-compose-dev.yml ps
```
