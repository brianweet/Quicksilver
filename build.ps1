$ErrorActionPreference = 'Stop';

Write-Host Starting build
docker build -t brianweet/quicksilver-appveyor .
