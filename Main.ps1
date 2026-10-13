<#
    script: Main.py
    project: UCD-COE-Rosetta-Client
#>

#Import Required Rosetta Classes
using module ./Rosetta/RosettaAPIWorker.ps1
using module ./Rosetta/RosettaPeopleSearchBy.ps1
using module ./Rosetta/RosettaPerson.ps1


#Initialize Rosetta API Worker
$rosettaAPIWrkr = [RosettaAPIWorker]::new((Get-Secret -Name "Rosetta-Base-Url" -AsPlainText -Vault "UCD-Identities"),
                                          (Get-Secret -Name "Rosetta-OAuth-Url" -AsPlainText -Vault "UCD-Identities"),
                                          (Get-Secret -Name "Rosetta-Client-ID" -AsPlainText -Vault "UCD-Identities"),
                                          (Get-Secret -Name "Rosetta-Client-Secret" -AsPlainText -Vault "UCD-Identities"));


$tstPerson = [RosettaPerson]::new()

$tstPerson.DisplayName;

$tstPerson.EmployeeAssociations;



