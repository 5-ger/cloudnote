# 思源笔记一键部署脚本 (SiYuan Note One-click Deployment)

基于 Docker 的思源笔记一键部署方案，专为低配云服务器（2核2G）优化。

## 🚀 快速开始 (Quick Start)
1.  克隆本仓库
2.  按顺序运行脚本
3.  浏览器打开 `http://<你的IP>` 并输入授权码

## ✨ 特性 (Features)
*   **一键部署**：自动化安装Docker、配置镜像源、启动服务。
*   **数据持久化**：自动挂载Volume，重启不丢数据。
*   **包含Nginx反向代理与Gzip优化**。
*   **详尽的故障排查指南**。

## 📋 前置要求 (Prerequisites)
*   一台Ubuntu 20.04+的云服务器（建议配置：2核2G）。
*   **确保安全组开放了80或你自定义的端口**。
*   （可选）一个已解析到服务器IP的域名。

## 📖 详细步骤与排错
请参考 [部署记录.md](https://github.com/5-ger/cloudnote/blob/main/remotecode/%E9%83%A8%E7%BD%B2%E8%AE%B0%E5%BD%95.md)
