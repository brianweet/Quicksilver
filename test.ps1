$ErrorActionPreference = 'Stop';

Write-Host Starting test

docker pull --platform linux  selenium/standalone-chrome:3.14.0-helium
docker run -d -p 4444:4444 --shm-size=2g selenium/standalone-chrome:3.14.0-helium

dotnet restore .\Sources\EPiServer.Reference.Commerce.Site.SeleniumTests\
dotnet test .\Sources\EPiServer.Reference.Commerce.Site.SeleniumTests\