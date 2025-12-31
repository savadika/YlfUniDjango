#!/bin/sh

# 等待 MySQL 启动
echo "Waiting for MySQL..."
while ! nc -z $DB_HOST 3306; do
  sleep 1
done
echo "MySQL started"

# 执行原来的命令
exec "$@"