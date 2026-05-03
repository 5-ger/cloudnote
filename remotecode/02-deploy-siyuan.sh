#!/bin/bash
set -e

# 1. 创建目录结构
mkdir -p ~/cloudnote/nginx/conf.d
mkdir -p ~/cloudnote/siyuan-data/conf

# 2. 生成 docker-compose.yml
cat > ~/cloudnote/docker-compose.yml << 'EOF'
services:
  siyuan:
    image: b3log/siyuan:latest
    restart: unless-stopped
    container_name: siyuan
    command: ['--workspace=/siyuan/workspace/', '--accessAuthCode=cloudnote']
    volumes:
      - /home/ubuntu/cloudnote/siyuan-data:/siyuan/workspace
    networks:
      - cloudnote

  nginx:
    image: nginx:alpine
    restart: unless-stopped
    container_name: nginx
    ports:
      - "80:80"
    volumes:
      - /home/ubuntu/cloudnote/nginx/conf.d:/etc/nginx/conf.d:ro
    depends_on:
      - siyuan
    networks:
      - cloudnote

networks:
  cloudnote:
    driver: bridge
EOF

# 3. 生成 Nginx 配置
cat > ~/cloudnote/nginx/conf.d/default.conf << 'EOF'
server {
    listen 80 default_server;

    client_max_body_size 100m;
    resolver 127.0.0.11 valid=30s;

    gzip on;
    gzip_comp_level 4;
    gzip_min_length 1024;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml text/javascript image/svg+xml;
    gzip_vary on;

    location / {
        proxy_pass http://siyuan:6806;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_read_timeout 86400;
        proxy_buffering off;
    }
}
EOF

# 4. 预置中文配置
cat > ~/cloudnote/siyuan-data/conf/conf.json << 'EOF'
{
  "lang": "zh_CN"
}
EOF

# 5. 启动服务
cd ~/cloudnote
sudo docker compose up -d

# 6. 等待服务就绪
echo "等待服务就绪..."
sleep 10

# 7. 配置防火墙
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
echo "y" | sudo ufw enable 2>/dev/null || true

# 8. 获取 IP 并输出结果
IP=$(curl -s ifconfig.me 2>/dev/null || echo "你的服务器IP")
echo ""
echo "============================================"
echo "  部署完成！"
echo "  访问地址: http://${IP}"
echo "============================================"
