# Create Organizational Units in the domain
$domainDN = "DC=xyz,DC=com"

$ous = @("Admins", "Employees", "ServiceAccounts", "Workstations", "Domain Controllers")

foreach ($ou in $ous) {
    if (-not (Get-ADOrganizationalUnit -Filter "Name -eq '$ou'" -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name $ou -Path $domainDN
        Write-Host "Created OU: $ou"
    } else {
        Write-Host "OU $ou already exists"
    }
}
