<#
    script: Main.py
    project: UCD-COE-Rosetta-Client
#>

#Import Rosetta Module
using module ./Rosetta/Rosetta.psm1

#Initialize Rosetta API Worker
$rosettaAPIWrkr = [RosettaAPIWorker]::new((Get-Secret -Name "Rosetta-Base-Url" -AsPlainText -Vault "UCD-Identities"),
                                          (Get-Secret -Name "Rosetta-OAuth-Url" -AsPlainText -Vault "UCD-Identities"),
                                          (Get-Secret -Name "Rosetta-Client-ID" -AsPlainText -Vault "UCD-Identities"),
                                          (Get-Secret -Name "Rosetta-Client-Secret" -AsPlainText -Vault "UCD-Identities"));


########################
# Departments Listing
########################

#Pull Listing of Rosetta Departments
$lDepartments = $rosettaAPIWrkr.GetDepartments();

#Export Department Listing to CSV in Local Directory
$lDepartments | Export-Csv -Path ("Rosetta_Departments_" + (Get-Date).ToString("yyyy-MM-dd-HH-mm") + ".csv") -NoTypeInformation;
