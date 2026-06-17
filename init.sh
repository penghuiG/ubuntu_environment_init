#!/bin/bash

set -e

cd "$(dirname "$0")"

echo "=== 更新软件源 ==="
sudo apt update

echo "=== 安装依赖包 ==="
sudo apt install -y make cmake gcc g++ libmysqlcppconn-dev doxygen libssl-dev libcurl4-openssl-dev wiringpi libwiringpi-dev

echo "=== 解压 frp ==="
tar -zxvf frp_0.61.1_linux_arm64.tar.gz

echo "=== 安装 frpc ==="
sudo cp frp_0.61.1_linux_arm64/frpc /usr/local/bin/
sudo chmod +x /usr/local/bin/frpc

echo "=== 配置 frpc ==="
sudo mkdir -p /etc/frp
sudo cp frpc.toml /etc/frp/
sudo cp frpc.service /etc/systemd/system/

echo "=== 启动 frpc 服务 ==="
sudo systemctl daemon-reload
sudo systemctl enable frpc
sudo systemctl start frpc

echo "=== 初始化完成 ==="