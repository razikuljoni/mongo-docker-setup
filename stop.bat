@echo off
echo ============================================
echo   MongoDB Docker Shutdown
echo ============================================
echo.

REM Check if Docker is running
docker ps >nul 2>&1
if errorlevel 1 (
    echo ERROR: Docker is not running!
    pause
    exit /b 1
)

echo Stopping MongoDB and Mongo Express containers...
docker-compose down

echo.
echo ============================================
echo   ✓ MongoDB Stopped Successfully!
echo ============================================
echo.
echo Note: Data is preserved in Docker volumes
echo.
echo To remove data too, run:
echo   docker-compose down -v
echo.
pause
