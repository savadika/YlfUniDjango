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

## 🚀 部署到阿里云/Linux 服务器 (详细指南)

本指南将帮助你将项目部署到阿里云 ECS 或任何 Linux 云服务器。

### 1. 准备工作

#### 1.1 购买服务器 (ECS)
*   **操作系统**: 推荐 **Ubuntu 20.04/22.04 LTS** (CentOS 也可以，但 Ubuntu 对 Docker 支持更友好)。
*   **配置**: 至少 **2核 4G** (因为需要运行 MySQL + Django + Vue构建 + Nginx)。
*   **安全组 (防火墙)**: 记得在阿里云控制台开放以下端口：
    *   `80`: 前端访问 (可选，如果配置了 80)
    *   `8080`: 前端访问 (如果 docker-compose 映射的是 8080)
    *   `22`: SSH 连接

#### 1.2 连接服务器
使用 SSH 工具 (如 PuTTY, XShell, 或 VS Code Remote SSH) 连接到你的服务器。

```bash
ssh root@你的服务器公网IP
```

### 2. 环境安装

在服务器上执行以下命令安装 Docker 和 Docker Compose：

```bash
# 更新软件源
sudo apt-get update

# 安装 Docker
sudo apt-get install -y docker.io

# 启动 Docker 并设置开机自启
sudo systemctl start docker
sudo systemctl enable docker

# 安装 Docker Compose
sudo apt-get install -y docker-compose
```

### 3. 上传代码

你可以通过以下两种方式之一上传代码：

#### 方式 A：使用 Git (推荐)
如果你的代码托管在 GitHub/Gitee/GitLab：
```bash
git clone https://你的仓库地址.git
cd 你的项目目录
```

#### 方式 B：直接上传文件 (适合本地开发)
使用 SCP 或 SFTP 工具 (如 WinSCP, FileZilla) 将本地的项目文件夹上传到服务器的 `/opt/` 或 `/home/` 目录下。

### 4. 启动部署

进入项目目录，运行生产环境启动命令：

```bash
# 1. 进入目录
cd /path/to/your/project

# 2. 启动服务 (后台运行)
# 注意：只使用 docker-compose.yml (生产配置)，不要加 -dev.yml
sudo docker-compose -f docker-compose.yml up -d --build
```

### 5. 验证部署

*   **查看运行状态**:
    ```bash
    sudo docker-compose ps
    ```
    你应该能看到 `frontend`, `backend`, `db` 三个容器都在 `Up` 状态。

*   **查看日志** (如果启动失败):
    ```bash
    sudo docker-compose logs -f
    ```

*   **访问网站**:
    打开浏览器，访问 `http://你的服务器公网IP:8080` (取决于 docker-compose.yml 中 frontend 的端口映射)。

### 6. 常见问题

#### 端口冲突
如果提示端口被占用，请修改 `docker-compose.yml` 中的 `ports` 部分，例如将 `8080:80` 改为 `8081:80`。

#### 数据库数据
首次启动时，数据库是空的。如果需要导入数据：
1.  将本地的 SQL 文件上传到服务器。
2.  进入数据库容器导入：
    ```bash
    cat backup.sql | sudo docker exec -i 容器名 mysql -u root -p密码 数据库名
    ```


