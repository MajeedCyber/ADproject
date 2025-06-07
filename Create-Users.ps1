# Create test users in specified OUs
Import-Module ActiveDirectory

# Define users as hashtables for easy addition
$users = @(
    @{Name="John Doe"; SamAccountName="jdoe"; OU="Employees"; Password="P@ssw0rd1"},
    @{Name="Weak User"; SamAccountName="weakuser"; OU="Employees"; Password="WeakPass123"},
    @{Name="Admin User"; SamAccountName="admin"; OU="Admins"; Password="AdminPass!23"},
    @{Name="SQL Service"; SamAccountName="sqlservice"; OU="ServiceAccounts"; Password="sql@123"}
)

foreach ($user in $users) {
    $userDN = "OU=$($user.OU),DC=xyz,DC=com"
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$($user.SamAccountName)'" -ErrorAction SilentlyContinue)) {
        New-ADUser -Name $user.Name `
                   -SamAccountName $user.SamAccountName `
                   -UserPrincipalName "$($user.SamAccountName)@xyz.com" `
                   -Path $userDN `
                   -AccountPassword (ConvertTo-SecureString $user.Password -AsPlainText -Force) `
                   -Enabled $true
        Write-Host "Created user: $($user.Name)"
    } else {
        Write-Host "User $($user.SamAccountName) already exists"
    }
}
