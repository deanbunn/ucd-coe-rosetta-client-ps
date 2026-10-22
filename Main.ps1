<#
    script: Main.ps1
    project: UCD-COE-Rosetta-Client
#>

#Import Rosetta Module
using module ./Rosetta/Rosetta.psm1

#Initialize Rosetta API Worker
$rosettaAPIWrkr = [RosettaAPIWorker]::new((Get-Secret -Name "Rosetta-Base-Url" -AsPlainText -Vault "UCD-Identities"),
                                          (Get-Secret -Name "Rosetta-OAuth-Url" -AsPlainText -Vault "UCD-Identities"),
                                          (Get-Secret -Name "Rosetta-Client-ID" -AsPlainText -Vault "UCD-Identities"),
                                          (Get-Secret -Name "Rosetta-Client-Secret" -AsPlainText -Vault "UCD-Identities"));

# List for Returned List of Rosetta People
$lPeople = [System.Collections.Generic.List[RosettaPerson]]::new();

# HashSet for Unique IDs for Post People Lookup
$setMPLIDs = [System.Collections.Generic.HashSet[string]]::new();

# "1000550201,1000016201,1000438403,1000227051"
# "1000010578,1000438054,1000269748,1000004984"
# "1000505549,1000213158,1000572411,1000632980"
# "1000090068,1000054150,1000008378,1000326424"

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

#Display Returned UCD Members
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


