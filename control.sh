#!/bin/bash
cd ~/Workspace/Dev/my_blog

case $1 in
   "publish")
        echo "🚀 正在提取 Obsidian 内容并发布到云端..."
        ~/Workspace/Dev/my_blog/venv/bin/python3 ~/Workspace/Product/bridge.py # [cite: 4]
        git add .
        current_time=$(date "+%Y-%m-%d %H:%M:%S") # 
        git commit -m "GEO Update: $current_time"
        
        # 【核心修改】识别当前分支并推送
        current_branch=$(git branch --show-current)
        git push origin $current_branch #  改为动态分支
        
        osascript -e 'display notification "GEO 分支已上传..." with title "CyanSun 博客发布"'
        open "https://www.cyansun.art" # [cite: 6]
        
        # 🌍 自动打开官网预览
        sleep 2 # 等待2秒确保推送反馈完成
        open "https://www.cyansun.art"
        ;;
    "local")
        echo "🏠 正在启动本地预览..."
        # 自动打开浏览器本地地址
        open "http://localhost:1313"
        # 启动 Hugo
        hugo server -D
        ;;
esac