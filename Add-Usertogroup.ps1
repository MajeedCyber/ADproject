# Add a user to a specified AD group
param(
    [string]$UserSamAccountName = "sqlservice",
    [string]$GroupName = "Server Operators"
)

Import-Module ActiveDirectory

if ((Get-ADUser -Identity $UserSamAccountName -ErrorAction SilentlyContinue) -and
    (Get-ADGroup -Identity $GroupName -ErrorAction SilentlyContinue)) {
    Add-ADGroupMember -Identity $GroupName -Members $UserSamAccountName
    Write-Host "Added user $UserSamAccountName to group $GroupName"
} else {
    Write-Host "User or group not found."
}
