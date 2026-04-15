#!/bin/bash

# اسم الحاوية
CONTAINER_NAME="my-vps-server"
IMAGE_NAME="vps-server:latest"

# إنشاء مجلدات التخزين الدائم محلياً إذا لم تكن موجودة
mkdir -p /mnt/vps_data/root
mkdir -p /mnt/vps_data/ssh_config

echo "Starting VPS Container with Persistence and Auto-restart..."

# تشغيل الحاوية مع إعدادات Persistence و Auto-restart
docker run -d \
  --name "$CONTAINER_NAME" \
  --restart always \
  -p 2222:22 \
  -v /mnt/vps_data/root:/root \
  -v /mnt/vps_data/ssh_config:/etc/ssh \
  "$IMAGE_NAME"

echo "VPS is running on port 2222. Connect using: ssh root@localhost -p 2222"
echo "Default password: ManusVPS2026!"
