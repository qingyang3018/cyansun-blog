#!/bin/bash
cd ~/Workspace/Dev/my_blog

case $1 in
   "publish")
        echo "🔄 正在预拉取远程改动..."
        git pull origin $(git branch --show-current) --rebase
        
        echo "🚀 启动 Totem Bridge 同步..."
        ~/Workspace/Dev/my_blog/venv/bin/python3 ~/Workspace/Product/bridge.py
        
        git add .
        current_time=$(date "+%Y-%m-%d %H:%M:%S")
        git commit -m "GEO Update: $current_time"
        
        echo "☁️ 发射到云端..."
        git push origin $(git branch --show-current)
        ;;
    "local")
        echo "🔄 正在从 Obsidian 提取最新 GEO 内容..."
        # 使用 venv 路径调用 bridge.py 确保环境一致性
        ~/Workspace/Dev/my_blog/venv/bin/python3 ~/Workspace/Product/bridge.py
        
        echo "🏠 正在启动本地预览..."
        # 自动打开浏览器本地地址
        open "http://localhost:1313"
        # 启动 Hugo
        hugo server -D
        ;;
esac