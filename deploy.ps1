$ErrorActionPreference = 'Stop';

Write-Host Deploy to ACI
az login --service-principal -u "$env:AZURE_SP_USER" -p "$env:AZURE_SP_PASS" --tenant "$env:AZURE_SP_TENANT"
az container create `
            --resource-group test-aci `
            --name quicksilver-appveyor `
            --image quicksilver.azurecr.io/quicksilver-appveyor-build `
            --dns-name-label quicksilver-appveyor-dns `
            --ports 80 443 `
            --os-type Windows `
            --cpu 1 `
            --memory 2 `
            --registry-login-server quicksilver.azurecr.io `
            --registry-username "$env:ACR_USER" `
            --registry-password "$env:ACR_PASS"