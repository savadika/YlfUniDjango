# Docker 开发与部署指南

本项目支持基于 Docker 的全栈开发与部署模式。

## 前置要求

- 请确保本机已安装 [Docker Desktop](https://www.docker.com/products/docker-desktop/) 并已启动。

---

## 1. 开发模式 (Development Mode)

**适用场景**：日常编码、调试。前端支持热重载（修改代码浏览器自动刷新），后端使用 Django 开发服务器。

### 启动命令

在项目根目录 (`d:\UniDjango`) 打开终端，运行：

```bash
docker-compose -f docker-compose.yml -f docker-compose-dev.yml up
```

> **注意**：首次启动时，前端容器需要下载依赖 (`npm install`)，可能需要几分钟时间，请耐心等待直到终端显示 `App running at: ...`。

### 访问地址

- **前端 (Vue)**: [http://localhost:9528](http://localhost:9528)
- **后端 (Django API)**: [http://localhost:8000](http://localhost:8000)
- **数据库 (MySQL)**: 端口 `3308`

### 常用操作

- **停止服务**: 在终端按 `Ctrl + C`。
- **重建容器** (如果修改了 Dockerfile 或依赖有问题):
  ```bash
  docker-compose -f docker-compose.yml -f docker-compose-dev.yml up --build
  ```
- **查看日志**:
  ```bash
  docker-compose -f docker-compose.yml -f docker-compose-dev.yml logs -f
  ```

---

## 2. 生产/预览模式 (Production Mode)

**适用场景**：上线部署、测试最终打包效果。前端会被构建为静态文件并由 Nginx 托管。

### 启动命令

```bash
docker-compose up -d
```

### 访问地址

- **应用主页**: [http://localhost:80](http://localhost:80) (或者直接访问 `http://localhost`)

### 常用操作

- **停止服务**:
  ```bash
  docker-compose down
  ```

---

## 常见问题

1. **端口冲突**:
   如果提示 `Bind for 0.0.0.0:8000 failed: port is already allocated`，说明本地已有程序占用了 8000 端口。请先关闭本地运行的 Django 或修改 `docker-compose.yml` 中的端口映射。

2. **前端无法访问**:
   开发模式下，请确保 `docker-compose-dev.yml` 中的 `npm install` 已经执行完毕。可以通过 `docker logs ylf-vue` 查看进度。
