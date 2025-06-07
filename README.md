# Active Directory Lab Project Write-Up

## Project Overview
This practical lab involved building a production-like Active Directory environment using Windows Server Core 2022, administered exclusively through PowerShell. The implementation covered essential AD components including organizational unit design, user/service account provisioning, security group management, and Group Policy deployment.

## Lab Specifications
- Domain: xyz.com  
- Domain Controller: Windows Server 2022 Core  
- Client Machine: Windows 11 Pro (Domain-joined)  
- Management Method: 100% PowerShell administration  

## Technical Implementation

1. Organizational Unit Creation  
Established the core OU structure with dedicated containers:  
```powershell
New-ADOrganizationalUnit -Name "Admins" -Path "DC=xyz,DC=com"
New-ADOrganizationalUnit -Name "Employees" -Path "DC=xyz,DC=com"
New-ADOrganizationalUnit -Name "ServiceAccounts" -Path "DC=xyz,DC=com"
New-ADOrganizationalUnit -Name "Workstations" -Path "DC=xyz,DC=com"
```

2. Account Deployment  
Created standard users, administrative accounts, and service principals:  

| Account Type        | Username   | OU Location     | Purpose                      |
|---------------------|------------|-----------------|------------------------------|
| Standard User       | jdoe       | Employees       | General access testing        |
| Restricted User     | weakuser   | Employees       | GPO restriction testing       |
| Domain Admin        | admin      | Admins          | Privileged access             |
| SQL Service Account | sqlservice | ServiceAccounts | Database authentication       |

```powershell
New-ADUser -Name "SQL Service" -SamAccountName "sqlservice" -UserPrincipalName "sqlservice@xyz.com" -Path "OU=ServiceAccounts,DC=xyz,DC=com" -AccountPassword (ConvertTo-SecureString "sql@123" -AsPlainText -Force) -Enabled $true -ServicePrincipalNames "MSSQLSvc/sql01.xyz.com"
```

3. Security Group Configuration  
Assigned privileged access to service accounts:  
```powershell
Add-ADGroupMember -Identity "Server Operators" -Members "sqlservice"
```

4. Domain Integration Verification  
Confirmed successful domain join through connectivity tests:  
```
whoami          → xyz\jdoe  
ping xyz.com    → replies from 192.168.111.155  
ipconfig        → verifies network configuration  
```

5. Group Policy Deployment  
Implemented desktop restriction policies:  
```powershell
New-GPO -Name "Employee Desktop Policy"
New-GPLink -Name "Employee Desktop Policy" -Target "OU=Employees,DC=xyz,DC=com"
Set-GPRegistryValue -Name "Employee Desktop Policy" -Key "HKCU\Software\Policies\Microsoft\Windows\System" -ValueName "DisableCMD" -Type DWord -Value 1
```

6. Policy Enforcement Validation  
Verified Command Prompt restriction through:  
- Registry policy application  
- User access attempt error message: "This operation has been cancelled due to restrictions in effect on this computer..."

## Required Documentation  
Essential screenshots to include:  
1. GPO restriction error on client  
2. PowerShell OU creation output  
3. gpresult policy application proof  
4. AD organizational unit hierarchy  
5. User account inventory  
6. Service account configuration  
7. Group membership verification  
8. Domain connectivity tests  
9. HTML GPO report  

## Roadmap for Enhancement  
1. Security Hardening:  
   - Password complexity policies  
   - Account lockout thresholds  

2. Additional GPOs:  
   - Folder redirection  
   - Session timeout controls  

3. AD Expansion:  
   - Computer object organization  
   - Delegated administration  

## Professional Summary  
This hands-on exercise delivered comprehensive Active Directory administration experience including infrastructure deployment, account lifecycle management, security group configuration, and Group Policy implementation. The PowerShell-focused approach provided authentic enterprise directory services management practice, directly relevant to system administrator and technical support roles.
