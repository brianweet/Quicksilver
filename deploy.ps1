$ErrorActionPreference = 'Stop';

Write-Host Pushing image to ACR
# "$env:ACR_PASS" | docker login --username "$env:ACR_USER" --password-stdin quicksilver.azurecr.io
# docker push quicksilver.azurecr.io/quicksilver-appveyor
Write-Host Deploy to ACI
az login --service-principal -u "$env:AZURE_SP_USER" -p "$env:AZURE_SP_PASS" --tenant "$env:AZURE_SP_TENANT"
az container create `
            --resource-group test-aci `
            --name quicksilver-appveyor `
            --image quicksilver.azurecr.io/quicksilver-appveyor `
            --dns-name-label quicksilver-appveyor-dns `
            --ports 80 443 `
            --os-type Windows `
            --cpu 2 `
            --memory 2.5 `
            --registry-login-server quicksilver.azurecr.io `
            --registry-username "$env:ACR_USER" `
            --registry-password "$env:ACR_PASS"