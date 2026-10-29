<#
.SYNOPSIS
    Script demostrating how to access the UCD Rosetta API

.DESCRIPTION
    Queries the UCD Rosetta API for member identity information.

.PARAMETER QueryType
    The Type of Rosetta Query

.PARAMETER QueryTerm
    The Search Term Used in the Query

.EXAMPLE
    ./Main.ps1 -QueryType People-Login -QueryTerm dbunn
#>

#Import Rosetta Module
using module ./Rosetta/Rosetta.psm1

#Script parameters
param(
    [string]$QueryType,
    [string]$QueryTerm,
    [switch]$Help
)

#Display Help for Missing Values
if($Help -or [string]::IsNullOrWhiteSpace($QueryType) -or [string]::IsNullOrWhiteSpace($QueryTerm))
{
    Write-Output(" ")
    Write-Output("Argument Options:")
    Write-Output("=======================")
    Write-Output("people-iamid <iamid>")
    Write-Output("people-iamids <iamid>")
    Write-Output("people-iamids-all-state <iamids>")
    Write-Output("people-login <userid>")
    Write-Output("people-login-all-state <userid>")
    Write-Output("people-email <emailaddress>")
    Write-Output("people-employeeid <employeeid>")
    Write-Output("people-studentid <studentid>")
    Write-Output("people-pidm <pidm>")
    Write-Output("people-mailid <mailid>")
    Write-Output("people-mailid-all-state <mailid>")
    Write-Output("people-department <departmentcode>")
    Write-Output("employee-iamid <iamid>")
    Write-Output("employee-departmentid <departmentid>")
    Write-Output("employee-divisionid <divisionid>")
    Write-Output("employee-subdivisionid <subdivisionid>")
    Write-Output("employee-subdivisionl4id <subdivisionl4id>")
    Write-Output("student-iam <iamid>")
    Write-Output("student-pidm <pidm>")
    Write-Output("student-studentid <studentid>")
    Write-Output("student-majorcode <majorcode>")
    Write-Output("student-collegecode <collegecode>")
    Write-Output("departments show")
    Write-Output("jobtypeids show")
    Write-Output(" ")
    Write-Output(" ")
}#End of Help Section

#Initialize Rosetta API Worker
$rosettaAPIWrkr = [RosettaAPIWorker]::new((Get-Secret -Name "Rosetta-Base-Url" -AsPlainText -Vault "UCD-Identities"),
                                          (Get-Secret -Name "Rosetta-OAuth-Url" -AsPlainText -Vault "UCD-Identities"),
                                          (Get-Secret -Name "Rosetta-Client-ID" -AsPlainText -Vault "UCD-Identities"),
                                          (Get-Secret -Name "Rosetta-Client-Secret" -AsPlainText -Vault "UCD-Identities"));

#List for Returned List of Rosetta People
$lPeople = [System.Collections.Generic.List[RosettaPerson]]::new();

#List for Returned List of Employee Associations
$lEmployeeAssocs = [System.Collections.Generic.List[RosettaEmployeeAssociation]]::new();

#List for Returned List of Student Associations
$lStudentAssocs = [System.Collections.Generic.List[RosettaStudentAssociation]]::new();

#List for Returned List of Job Type IDs
$lJobTypeIDs = [System.Collections.Generic.List[RosettaJobTypeID]]::new();

#List for Returned List of Departments
$lDepartments = [System.Collections.Generic.List[RosettaDepartment]]::new();

# HashSet for Unique IDs for Post People Lookup
$setMPLIDs = [System.Collections.Generic.HashSet[string]]::new();



<#
################################
# People Get EndPoint Query
################################

#Pull People by Search Term
$lPeople = $rosettaAPIWrkr.GetRosettaPeopleBySearchTerm([RosettaPeopleSearchBy]::IAMIDSALLSTATE,"1000505549,1000213158,1000572411,1000632980");


################################
# Query Student Associations
################################

#Pull list of Student Associations by Query Parameter
$lStudentAssocs = $rosettaAPIWrkr.GetRosettaStudentAssociationBySearchTerm([RosettaStudentSearchBy]::MAJORCODE,"GMAE");


foreach($stdntAssoc in $lStudentAssocs)
{
    
    # Add Student's IAM to MPL IDs Set for People Post Lookup 
    $null = $setMPLIDs.Add($stdntAssoc.IAMID)
    
    #Display Student Association Info
    $stdntAssoc
    
}

################################
# Query Employee Associations
################################

#Pull list of Employee Associations by Query Parameter
$lEmployeeAssocs = $rosettaAPIWrkr.GetRosettaEmployeeAssociationBySearchTerm([RosettaEmployeeSearchBy]::DEPARTMENTID,"024000");

#Display Employee Associations API Query Results
foreach($empAssoc in $lEmployeeAssocs)
{
    # Add Employee's IAM to MPL IDs Set for People Post Lookup 
    $null = $setMPLIDs.Add($empAssoc.IAMID);

    #Display Employee Association Info
    $empAssoc;

}

#######################################
# People Lookup by Post Query
#######################################

#Check MPL IDs Set Count
if($setMPLIDs.Count -gt 0)
{
    #Pull List of Rosetta People by Post Lookup
    $lPeople = $rosettaAPIWrkr.PostMassRosettaPeopleLookup([RosettaPeoplePostLookupBy]::IAMIDS,$setMPLIDs)
}

#######################################
# Display List of Rosetta People
#######################################

if($lPeople.Count -gt 0)
{
    foreach($ucdPerson in $lPeople | Sort-Object -Property DisplayName)
    {

        #Separator with Display Name
        Write-Output ("`n================= " + $ucdPerson.DisplayName + " ================`n")

        #Display User Information
        $ucdPerson

        #Display Employment Associations If Any
        if($ucdPerson.EmployeeAssociations.Count -gt 0)
        {
            foreach($empAssoc in $ucdPerson.EmployeeAssociations)
            {
                $empAssoc
            }
        }

        #Display Student Associations If Any
        if($ucdPerson.StudentAssociations.Count -gt 0)
        {
            foreach($stdntAssoc in $ucdPerson.StudentAssociations)
            {
                $stdntAssoc
            }
        }

    }#End of lPeople Foreach
}


########################
# Departments Listing
########################

#Pull Listing of Rosetta Departments
$lDepartments = $rosettaAPIWrkr.GetDepartments();

#Export Department Listing to CSV in Local Directory
$lDepartments | Export-Csv -Path ("Rosetta_Departments_" + (Get-Date).ToString("yyyy-MM-dd-HH-mm") + ".csv") -NoTypeInformation;

#########################
# Job Type IDs Listing
#########################

#Pull Listing of Rosetta Job Type IDs
$lJobTypeIDs = $rosettaAPIWrkr.GetJobTypeIDs();

#Export Job Type IDs Listing to CSV in Local Directory
$lJobTypeIDs | Export-Csv -Path ("Rosetta_JobTypeIDs_" + (Get-Date).ToString("yyyy-MM-dd-HH-mm") + ".csv") -NoTypeInformation;


#>