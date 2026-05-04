@echo off
setlocal

:: Java and Maven paths
set "JAVA_HOME=C:\Program Files\Java\jdk-25.0.2"
set "PATH=%JAVA_HOME%\bin;C:\Users\1\.m2\wrapper\dists\apache-maven-3.9.6-bin\3311e1d4\apache-maven-3.9.6\bin;%PATH%"

echo =============================================
echo   A K Construction - Spring Boot Launcher
echo =============================================
echo.

echo Importing MySQL database...
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -pyash < "d:\A-K-Construction-\database\ak_construction.sql" 2>nul
echo Done.
echo.
echo Starting application on http://localhost:8080
echo Press Ctrl+C to stop.
echo.

mvn.cmd spring-boot:run

pause
