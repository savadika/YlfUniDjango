# UniDjango 开发指南

基于 Docker 的 Django + Vue 前后端分离全栈开发环境。

## 🚀 快速开始

### 1. 启动开发环境
修改代码后浏览器自动刷新 (Hot Reload)。

```bash
docker-compose -f docker-compose.yml -f docker-compose-dev.yml up
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

## 📦 如何基于本项目新建一个项目

如果您想完全复制这套环境来开发一个新的项目（例如 `MyNewProject`），请按照以下步骤操作：

### 1. 复制与清理
1. 复制整个 `UniDjango` 文件夹，重命名为 `MyNewProject`。
2. 进入新文件夹，**删除**以下目录（以清除旧项目状态）：
   - `db_data/` (旧数据库数据，必须删)
   - `frontend/node_modules/` (旧依赖，必须删)
   - `frontend/dist/` (旧构建产物，可选)

### 2. 修改配置 (防止端口和容器名冲突)
如果不修改，两个项目无法同时运行。请在新项目中修改以下文件：

**文件 1: `docker-compose.yml`**
- 修改所有 `container_name`（例如 `ylf-django` -> `new-django`）。
- 修改 `ports`（例如 `8000:8000` -> `8001:8000`, `3308:3306` -> `3309:3306`）。

**文件 2: `docker-compose-dev.yml`**
- 修改前端端口映射：`9528:9528` -> `9529:9528`。

**文件 3: `UniDjango/UniDjango/settings.py`**
- 修改 `DATABASES` 中的 `HOST` 为新的数据库容器名（例如 `new-mysql`）。

**文件 4: `frontend/vue.config.js`**
- 修改 `port` 为新的前端端口（例如 `9529`）。

**文件 5: `frontend/src/utils/request.js`**
- 修改 `baseURL` 为新的后端地址（例如 `http://localhost:8001`）。

### 3. 启动新项目
```bash
docker-compose -f docker-compose.yml -f docker-compose-dev.yml up -d --build
```
Docker 会自动构建新镜像并初始化干净的数据库。

> **💡 提示**: 您也可以使用 `tools/project_cloner.html` 工具来生成自动克隆脚本。双击打开该文件即可使用。

## 🚀 部署到服务器 (生产环境)

当您在本地开发完成，准备部署到 Linux 服务器（如 CentOS/Ubuntu）时，请遵循以下步骤：

### 1. 服务器准备
确保服务器已安装 Docker 和 Docker Compose。
```bash
# 以 Ubuntu 为例安装 Docker
curl -fsSL https://get.docker.com | bash
```

### 2. 代码上传
将项目代码上传到服务器（可以使用 Git 或 SCP）。
```bash
# 方式 A: Git (推荐)
git clone https://your-repo.com/UniDjango.git
cd UniDjango

# 方式 B: SCP 上传
scp -r d:\UniDjango root@your-server-ip:/opt/
```

### 3. 启动服务
在服务器上，我们只需要运行**生产模式**（不需要 `-dev` 文件）。
```bash
# 1. 进入目录
cd /opt/UniDjango

# 2. 启动 (后台运行)
docker-compose up -d --build
```

### 4. 数据迁移 (可选)
如果是首次部署，Docker 会自动读取 `backup.sql` 初始化数据库。
如果是后续更新代码，可能需要执行数据库迁移：
```bash
docker exec -it ylf-django python manage.py migrate
```

### 5. 访问
直接访问服务器 IP 即可：`http://your-server-ip`。前端 Nginx 会自动处理静态文件转发和反向代理。


