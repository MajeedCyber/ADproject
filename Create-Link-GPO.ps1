param(
    [string]$GPOName = "Employee Desktop Policy",
    [string]$TargetOU = "OU=Employees,DC=xyz,DC=com"
)

Import-Module GroupPolicy

# Create GPO if not exists
$gpo = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue
if (-not $gpo) {
    $gpo = New-GPO -Name $GPOName
    Write-Host "Created GPO: $GPOName"
} else {
    Write-Host "GPO $GPOName already exists"
}

# Link GPO to OU
New-GPLink -Name $GPOName -Target $TargetOU -ErrorAction SilentlyContinue | Out-Null
Write-Host "Linked GPO '$GPOName' to '$TargetOU'"
