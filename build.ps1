$ErrorActionPreference = 'Stop';

Write-Host Starting build
# docker build -t quicksilver.azurecr.io/quicksilver-appveyor .
Write-Host Pushing image to ACR
# "$env:ACR_PASS" | docker login --username "$env:ACR_USER" --password-stdin quicksilver.azurecr.io
# docker push quicksilver.azurecr.io/quicksilver-appveyor
Write-Host Completed build

./deploy.ps1
./test.ps1