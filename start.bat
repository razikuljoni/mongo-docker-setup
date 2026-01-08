@echo off
echo ============================================
echo   MongoDB Docker Startup
echo ============================================
echo.

REM Check if Docker is running
docker ps >nul 2>&1
if errorlevel 1 (
    echo ERROR: Docker is not running!
    echo Please start Docker Desktop and try again.
    pause
    exit /b 1
)

echo [1/3] Starting MongoDB and Mongo Express containers...
docker-compose up -d

if errorlevel 1 (
    echo ERROR: Failed to start containers!
    pause
    exit /b 1
)

echo [2/3] Waiting for services to be ready...
timeout /t 10 /nobreak

echo [3/3] Checking container status...
docker-compose ps

echo.
echo ============================================
echo   ✓ MongoDB Started Successfully!
echo ============================================
echo.
echo Access Points:
echo   - MongoDB: localhost:27017
echo   - Mongo Express Web UI: http://localhost:8081
echo.
echo Credentials: See .env file
echo.
echo Useful Commands:
echo   docker-compose logs -f mongodb        (View logs)
echo   docker-compose ps                     (Check status)
echo   docker-compose down                   (Stop all)
echo.
pause
