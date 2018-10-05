$ErrorActionPreference = 'Stop';

Write-Host Starting deploy
"$env:DOCKER_PASS" | docker login --username "$env:DOCKER_USER" --password-stdin
docker push brianweet/quicksilver-appveyor