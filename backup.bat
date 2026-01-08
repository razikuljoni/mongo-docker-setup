@echo off
REM MongoDB Docker Backup Script for Windows
REM Usage: backup.bat [backup-name]

setlocal enabledelayedexpansion

set BACKUP_DIR=.\backup
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c%%a%%b)
for /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a%%b)
set TIMESTAMP=%mydate%_%mytime%

if "%1"=="" (
    set BACKUP_NAME=mongodb_backup_%TIMESTAMP%
) else (
    set BACKUP_NAME=%1
)

echo ================================================
echo MongoDB Backup Script
echo ================================================
echo.

REM Create backup directory
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

echo [1/3] Creating backup: %BACKUP_NAME%
echo.

REM Backup using mongodump
docker exec mongodb mongodump ^
    --authenticationDatabase admin ^
    --username admin ^
    --password changeme123 ^
    --out "/tmp/%BACKUP_NAME%"

if errorlevel 1 (
    echo.
    echo ✗ Backup failed!
    pause
    exit /b 1
)

echo [2/3] Copying backup to host...
docker cp "mongodb:/tmp/%BACKUP_NAME%" "%BACKUP_DIR%\"

echo [3/3] Cleaning up temporary files...
docker exec mongodb rm -rf "/tmp/%BACKUP_NAME%"

echo.
echo ================================================
echo ✓ Backup completed successfully!
echo ================================================
echo.
echo Location: %BACKUP_DIR%\%BACKUP_NAME%
echo.
dir /S "%BACKUP_DIR%"

pause
