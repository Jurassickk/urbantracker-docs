@echo off
setlocal
cd /d "%~dp0"
docker compose run --rm latex
exit /b %ERRORLEVEL%
