# 第一阶段：构建 (Build)
# 使用 Node 22 (Alpine 版本更轻量)
FROM node:22-alpine AS builder

WORKDIR /app
COPY package.json ./

# 设置淘宝源加速 (可选，如果网络好可以去掉)
RUN npm config set registry https://registry.npmmirror.com/

# 安装依赖
# 注意：如果你的项目有 package-lock.json，建议也 COPY 进去并使用 npm ci
RUN npm install

# 复制源代码
COPY . .

# 执行构建，生成 dist 目录
RUN npm run build:prod

# 第二阶段：部署 (Deploy)
FROM nginx:stable-alpine

# 把构建好的 dist 目录复制到 Nginx 目录
COPY --from=builder /app/dist /usr/share/nginx/html

# 复制自定义的 Nginx 配置 (确保你有在这个路径创建该文件)
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]