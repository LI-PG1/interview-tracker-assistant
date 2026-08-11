@echo off
chcp 65001 >nul
title 面试跟踪助手 - 启动器

echo === 面试跟踪助手 - 启动器 ===
echo.

rem [1] 环境检测
where node >nul 2>nul
if errorlevel 1 (
  echo [FAIL] 未检测到 Node.js。请先安装（推荐方式）：
  echo        winget install OpenJS.NodeJS.LTS
  echo 安装完成后重新双击本启动器。
  echo.
  pause
  exit /b 1
)

rem [2] 配置生成
if not exist config.json (
  if exist config.example.json (
    copy config.example.json config.json >nul
    echo [INFO] 已生成 config.json（默认端口 8902，可自行修改）
  )
)

rem [3] 一键自检
echo [INFO] 运行环境自检...
node server.js --selftest
if errorlevel 1 (
  echo.
  echo [FAIL] 自检未通过，请按上方提示修复后重试。
  pause
  exit /b 1
)

rem [4] 启动服务（保持本窗口开启即服务运行中，关闭窗口即停止）
echo.
echo [INFO] 正在启动服务，浏览器将自动打开...
echo [INFO] 关闭本窗口即可停止服务
echo.
node server.js
pause
