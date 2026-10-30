<#
    script: Main.ps1
    project: UCD-COE-Rosetta-Client-PS
#>

#Import Rosetta Module and Script Usage Help
using module ./Rosetta/Rosetta.psm1

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


#Check for Supplied Script Arguments
if($args.Count -eq 2)
{
    #Vars for Processing Arguments
    [string]$queryType = $args[0].ToString().ToLower().Trim();
    [string]$searchFor = $args[1].ToString().Trim();

    #Switch Statement to Process Arguments
    switch($queryType)
    {
        "people-iamid"{$lPeople = $rosettaAPIWrkr.GetRosettaPeopleBySearchTerm([RosettaPeopleSearchBy]::IAMID,$searchFor);}
        "people-iamids"{$lPeople = $rosettaAPIWrkr.GetRosettaPeopleBySearchTerm([RosettaPeopleSearchBy]::IAMIDS,$searchFor);}
        "people-iamids-all-state"{$lPeople = $rosettaAPIWrkr.GetRosettaPeopleBySearchTerm([RosettaPeopleSearchBy]::IAMIDSALLSTATE,$searchFor);}
        "people-login"{$lPeople = $rosettaAPIWrkr.GetRosettaPeopleBySearchTerm([RosettaPeopleSearchBy]::LOGINID,$searchFor);}
        "people-login-all-state"{$lPeople = $rosettaAPIWrkr.GetRosettaPeopleBySearchTerm([RosettaPeopleSearchBy]::LOGINIDALLSTATE,$searchFor);}
        "people-email"{$lPeople = $rosettaAPIWrkr.GetRosettaPeopleBySearchTerm([RosettaPeopleSearchBy]::EMAIL,$searchFor);}
        "people-employeeid"{$lPeople = $rosettaAPIWrkr.GetRosettaPeopleBySearchTerm([RosettaPeopleSearchBy]::EMPLOYEEID,$searchFor);}
        "people-studentid"{$lPeople = $rosettaAPIWrkr.GetRosettaPeopleBySearchTerm([RosettaPeopleSearchBy]::STUDENTID,$searchFor);}
        "people-pidm"{$lPeople = $rosettaAPIWrkr.GetRosettaPeopleBySearchTerm([RosettaPeopleSearchBy]::PIDM,$searchFor);}
        "people-mailid"{$lPeople = $rosettaAPIWrkr.GetRosettaPeopleBySearchTerm([RosettaPeopleSearchBy]::MAILID,$searchFor);}
        "people-mailid-all-state"{$lPeople = $rosettaAPIWrkr.GetRosettaPeopleBySearchTerm([RosettaPeopleSearchBy]::MAILIDALLSTATE,$searchFor);}
        "people-department"{$lPeople = $rosettaAPIWrkr.GetRosettaPeopleBySearchTerm([RosettaPeopleSearchBy]::DEPARTMENT,$searchFor);}
        "employee-iamid"{$lEmployeeAssocs = $rosettaAPIWrkr.GetRosettaEmployeeAssociationBySearchTerm([RosettaEmployeeSearchBy]::IAMID,$searchFor);}
        "employee-departmentid"{$lEmployeeAssocs = $rosettaAPIWrkr.GetRosettaEmployeeAssociationBySearchTerm([RosettaEmployeeSearchBy]::DEPARTMENTID,$searchFor);}
        "employee-divisionid"{$lEmployeeAssocs = $rosettaAPIWrkr.GetRosettaEmployeeAssociationBySearchTerm([RosettaEmployeeSearchBy]::DIVISIONID,$searchFor);}
        "employee-subdivisionid"{$lEmployeeAssocs = $rosettaAPIWrkr.GetRosettaEmployeeAssociationBySearchTerm([RosettaEmployeeSearchBy]::SUBDIVISIONID,$searchFor);}
        "employee-subdivisionl4id"{$lEmployeeAssocs = $rosettaAPIWrkr.GetRosettaEmployeeAssociationBySearchTerm([RosettaEmployeeSearchBy]::SUBDIVISIONL4ID,$searchFor);}
        "student-iam"{$lStudentAssocs = $rosettaAPIWrkr.GetRosettaStudentAssociationBySearchTerm([RosettaStudentSearchBy]::IAMID,$searchFor);}
        "student-pidm"{$lStudentAssocs = $rosettaAPIWrkr.GetRosettaStudentAssociationBySearchTerm([RosettaStudentSearchBy]::PIDM,$searchFor);}
        "student-studentid"{$lStudentAssocs = $rosettaAPIWrkr.GetRosettaStudentAssociationBySearchTerm([RosettaStudentSearchBy]::STUDENTID,$searchFor);}
        "student-majorcode"{$lStudentAssocs = $rosettaAPIWrkr.GetRosettaStudentAssociationBySearchTerm([RosettaStudentSearchBy]::MAJORCODE,$searchFor);}
        "student-collegecode"{$lStudentAssocs = $rosettaAPIWrkr.GetRosettaStudentAssociationBySearchTerm([RosettaStudentSearchBy]::COLLEGECODE,$searchFor);}
        "departments"{$lDepartments = $rosettaAPIWrkr.GetDepartments();}
        "jobtypeids"{$rosettaAPIWrkr.GetJobTypeIDs();}
    }

    #Keeping Track of Number of Errors in Error Count Property on API Worker Instance. 
    #Leaving Resetting of Error Count Up to the Developer and How They Want It to Work
    #Display Number of Errors if Any Occurred
    if($rosettaAPIWrkr.ErrorCount -gt 0)
    {
        Write-Output($rosettaAPIWrkr.ErrorCount.ToString() + " error(s) occurred during API calls");
    }

}
else
{
    Write-Output @"

    Argument Options: 
    =======================
    people-iamid <iamid>
    people-iamids <iamid,iamid,iamid>
    people-iamids-all-state <iamid,iamid,iamid>
    people-login <userid>
    people-login-all-state <userid>
    people-email <emailaddress>
    people-employeeid <employeeid>
    people-studentid <studentid>
    people-pidm <pidm>
    people-mailid <mailid>
    people-mailid-all-state <mailid>
    people-department <departmentcode>
    employee-iamid <iamid>
    employee-departmentid <departmentid>
    employee-divisionid <divisionid>
    employee-subdivisionid <subdivisionid>
    employee-subdivisionl4id <subdivisionl4id>
    student-iam <iamid>
    student-pidm <pidm>
    student-studentid <studentid>
    student-majorcode <majorcode>
    student-collegecode <collegecode>
    departments export
    jobtypeids export

"@

    #Stop Script
    exit;
}


#######################################
# Display Employee Associations
#######################################

if($lEmployeeAssocs.Count -gt 0)
{
    foreach($empAssoc in $lEmployeeAssocs)
    {
        # Add Employee's IAM to MPL IDs Set for People Post Lookup 
        $null = $setMPLIDs.Add($empAssoc.IAMID);

        #Display Employee Association Info
        $empAssoc;
    }
}

#######################################
# Display Student Associations 
#######################################

if($lStudentAssocs.Count -gt 0)
{
    foreach($stdntAssoc in $lStudentAssocs)
    {
        # Add Student's IAM to MPL IDs Set for People Post Lookup 
        $null = $setMPLIDs.Add($stdntAssoc.IAMID)
        
        #Display Student Association Info
        $stdntAssoc 
    }
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
# Display Rosetta People
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
# Display Departments
########################

if($lDepartments.Count -gt 0)
{
    #Export Department Listing to CSV in Local Directory
    $lDepartments | Export-Csv -Path ("Rosetta_Departments_" + (Get-Date).ToString("yyyy-MM-dd-HH-mm") + ".csv") -NoTypeInformation;
}

#########################
# Display Job Type IDs 
#########################

if($lJobTypeIDs.Count -gt 0)
{
    #Export Job Type IDs Listing to CSV in Local Directory
    $lJobTypeIDs | Export-Csv -Path ("Rosetta_JobTypeIDs_" + (Get-Date).ToString("yyyy-MM-dd-HH-mm") + ".csv") -NoTypeInformation;

}



