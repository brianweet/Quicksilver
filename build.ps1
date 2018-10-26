$ErrorActionPreference = 'Stop';

Write-Host Starting build
# docker build -t quicksilver.azurecr.io/quicksilver-appveyor .
Write-Host Completed build

./deploy.ps1
./test.ps1