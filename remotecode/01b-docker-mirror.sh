#!/bin/bash
set -e

# 配置 Docker 镜像加速（国内必需）
sudo tee /etc/docker/daemon.json > /dev/null << 'EOF'
{
    "registry-mirrors": ["https://mirror.ccs.tencentyun.com"]
}
EOF

sudo systemctl daemon-reload
sudo systemctl restart docker

echo "镜像加速配置完成"
