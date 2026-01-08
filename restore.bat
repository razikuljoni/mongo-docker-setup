@echo off
REM MongoDB Docker Restore Script for Windows
REM Usage: restore.bat [backup-path]

setlocal enabledelayedexpansion

if "%1"=="" (
    echo.
    echo Usage: restore.bat [backup-directory-path]
    echo Example: restore.bat ./backup/mongodb_backup_20240115_1430
    echo.
    pause
    exit /b 1
)

set BACKUP_PATH=%1

if not exist "%BACKUP_PATH%" (
    echo.
    echo ERROR: Backup directory not found: %BACKUP_PATH%
    echo.
    pause
    exit /b 1
)

echo ================================================
echo MongoDB Restore Script
echo ================================================
echo.
echo WARNING: This will overwrite existing data!
echo.
set /p confirm="Continue restore? (yes/no): "
if /i not "%confirm%"=="yes" (
    echo Restore cancelled.
    pause
    exit /b 0
)

echo.
echo [1/3] Copying backup to MongoDB container...
docker cp "%BACKUP_PATH%" "mongodb:/tmp/restore"

if errorlevel 1 (
    echo ERROR: Failed to copy backup!
    pause
    exit /b 1
)

echo [2/3] Restoring database...
docker exec mongodb mongorestore ^
    --authenticationDatabase admin ^
    --username admin ^
    --password changeme123 ^
    --drop ^
    /tmp/restore

if errorlevel 1 (
    echo ERROR: Restore failed!
    echo [Cleanup] Removing temporary files...
    docker exec mongodb rm -rf /tmp/restore
    pause
    exit /b 1
)

echo [3/3] Cleaning up temporary files...
docker exec mongodb rm -rf /tmp/restore

echo.
echo ================================================
echo ✓ Restore completed successfully!
echo ================================================
echo.

pause
