#!/bin/bash
cd ~/Workspace/Dev/my_blog

case $1 in
    "publish")
        echo "🚀 正在提取 Obsidian 内容并发布到云端..."
        # 运行桥接脚本
        python3 ~/Workspace/Product/bridge.py
        
        # Git 提交
        git add .
        current_time=$(date "+%Y-%m-%d %H:%M:%S")
        git commit -m "Content Update: $current_time"
        
        # 推送
        git push origin main
        
        # 📢 系统通知
        osascript -e 'display notification "代码已上传，Vercel 正在构建..." with title "CyanSun 博客发布"'
        
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