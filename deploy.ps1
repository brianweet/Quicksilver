$ErrorActionPreference = 'Stop';

Write-Host Starting deploy
"$env:ACR_PASS" | docker login --username "$env:ACR_USER" --password-stdin quicksilver.azurecr.io
docker push quicksilver.azurecr.io/quicksilver-appveyor