@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo ====================================
echo   Deploying blog to GitHub + Vercel
echo ====================================
echo.
git add .
git commit -m "update blog"
git push
echo.
echo ====================================
echo   Done! Vercel will publish in 1-2 min.
echo   Check your site in a moment.
echo ====================================
echo.
pause
