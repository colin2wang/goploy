@echo off
setlocal enabledelayedexpansion

where go >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Go not found, please install Go first.
    pause
    exit /b 1
)

if not exist "build" mkdir build

echo.
echo ^>^> GOOS=linux GOARCH=amd64 -^> build/goploy
set GOOS=linux
set GOARCH=amd64
go build -o build/goploy cmd/server/main.go
if %ERRORLEVEL% equ 0 (echo goploy (linux/amd64^) done) else (echo [ERROR] linux/amd64 build failed)

echo.
echo ^>^> GOOS=windows GOARCH=amd64 -^> build/goploy.exe
set GOOS=windows
set GOARCH=amd64
go build -o build/goploy.exe cmd/server/main.go
if %ERRORLEVEL% equ 0 (echo goploy.exe (windows/amd64^) done) else (echo [ERROR] windows/amd64 build failed)

set GOOS=
set GOARCH=

echo.
echo ============ Build Complete ============
echo Output directory: build\
dir build\ /b
echo ========================================
pause
