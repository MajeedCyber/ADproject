# ADproject

# Active Directory Lab Project Write-Up

## Project Overview

The purpose of this lab project was to build a basic Active Directory (AD) environment on Windows Server Core, using PowerShell for management. The goal was to practice creating organizational units (OUs), service accounts, managing group memberships, and exploring AD structure — foundational skills for real-world AD administration.

---

## What Was Done

1. **Created Organizational Units (OUs)**  
   Created multiple OUs to organize users and computers logically within the domain:
   - Admins  
   - Employees  
   - ServiceAccounts  
   - Workstations  
   - Domain Controllers  

2. **Created a Service Account**  
   Created a user account named `SQL Service` in the `ServiceAccounts` OU with the following properties:  
   - SAM Account Name: `sqlservice`  
   - User Principal Name: `sqlservice@xyz.com`  
   - Password: `sql@123` (securely converted)  
   - Enabled account  
   - Set Service Principal Name (SPN) for SQL Server service  

3. **Group Membership Management**  
   Added the service account `sqlservice` to the built-in **Server Operators** group, which grants the necessary permissions for server management tasks.

4. **Verification and Idempotency**  
   Used PowerShell logic to check if OUs and users exist before creating them to prevent duplicates. Also confirmed the group membership was successfully added using error handling.

5. **Explored AD Structure**  
   Retrieved and reviewed existing OUs, groups containing “operators,” and user accounts with their distinguished names to understand the domain hierarchy and object placement.

---

## Summary

This lab provided practical experience in managing AD via PowerShell on a Server Core installation, including creating organizational units, managing users and service accounts, handling group memberships, and querying the AD structure. These are essential skills for Active Directory administration and form a solid foundation for further projects such as Group Policy management, delegated administration, and service account security.

---
