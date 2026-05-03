#!/bin/bash
set -e

# 1. 更新软件源
sudo apt update -y

# 2. 安装前置依赖
sudo apt install -y ca-certificates curl

# 3. 创建密钥目录
sudo install -m 0755 -d /etc/apt/keyrings

# 4. 下载 Docker GPG 密钥
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# 5. 添加 Docker 软件源
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 6. 安装 Docker
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 7. 启动 Docker 并设开机自启
sudo systemctl enable docker --now

# 8. 验证
docker --version
