# PowerShell script to build and package A K Construction for AWS Elastic Beanstalk
param (
    [string]$JavaHome = "C:\Program Files\Java\jdk-25.0.2"
)

$ErrorActionPreference = "Stop"

Write-Host "=============================================" -ForegroundColor Cyan
Write-Host " Building AWS Elastic Beanstalk Bundle       " -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

# Set environment
if ($env:JAVA_HOME -eq $null -or -not (Test-Path $env:JAVA_HOME)) {
    if (Test-Path $JavaHome) {
        $env:JAVA_HOME = $JavaHome
        $env:PATH = "$env:JAVA_HOME\bin;$env:PATH"
    }
}

$mvnCmd = "mvn"
if (-not (Get-Command mvn -ErrorAction SilentlyContinue)) {
    $wrapperMvn = "C:\Users\1\.m2\wrapper\dists\apache-maven-3.9.6-bin\3311e1d4\apache-maven-3.9.6\bin\mvn.cmd"
    if (Test-Path $wrapperMvn) {
        $mvnCmd = $wrapperMvn
    } else {
        Write-Error "Maven could not be found. Please ensure Maven is installed and on your PATH."
    }
}

Write-Host "[1/3] Packaging project with Maven..." -ForegroundColor Green
cmd.exe /c "`"$mvnCmd`" clean package -DskipTests"
if ($LASTEXITCODE -ne 0) {
    Write-Error "Maven build failed."
}

$jarFile = Get-ChildItem -Path "target" -Filter "ak-construction-*.jar" | Select-Object -First 1
if (-not $jarFile) {
    Write-Error "Build failed: JAR file not found in target/."
}

Write-Host "[2/3] Preparing deployment bundle..." -ForegroundColor Green
$bundleDir = Join-Path $PSScriptRoot "deploy_bundle_temp"
if (Test-Path $bundleDir) {
    Remove-Item -Path $bundleDir -Recurse -Force
}
New-Item -ItemType Directory -Path $bundleDir | Out-Null

Copy-Item -Path $jarFile.FullName -Destination (Join-Path $bundleDir "ak-construction-1.0.0.jar")
if (Test-Path (Join-Path $PSScriptRoot "Procfile")) {
    Copy-Item -Path (Join-Path $PSScriptRoot "Procfile") -Destination (Join-Path $bundleDir "Procfile")
}
if (Test-Path (Join-Path $PSScriptRoot ".ebextensions")) {
    Copy-Item -Path (Join-Path $PSScriptRoot ".ebextensions") -Destination (Join-Path $bundleDir ".ebextensions") -Recurse
}

$zipOutput = Join-Path $PSScriptRoot "ak-construction-aws-bundle.zip"
if (Test-Path $zipOutput) {
    Remove-Item -Path $zipOutput -Force
}

Write-Host "[3/3] Creating zip package: $zipOutput..." -ForegroundColor Green
Compress-Archive -Path "$bundleDir\*" -DestinationPath $zipOutput

Remove-Item -Path $bundleDir -Recurse -Force

Write-Host "=============================================" -ForegroundColor Cyan
Write-Host " SUCCESS! Elastic Beanstalk bundle created:  " -ForegroundColor Green
Write-Host " $zipOutput" -ForegroundColor Yellow
Write-Host " Upload this zip file directly to AWS Elastic Beanstalk!" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Cyan
