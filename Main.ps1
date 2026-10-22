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


################################
# People Get EndPoint Query
################################
#Pull People by Search Term
$lPeople = $rosettaAPIWrkr.GetRosettaPeopleBySearchTerm([RosettaPeopleSearchBy]::IAMIDSALLSTATE,"1000505549,1000213158,1000572411,1000632980");

# "1000550201,1000016201,1000438403,1000227051"
# "1000010578,1000438054,1000269748,1000004984"
# "1000505549,1000213158,1000572411,1000632980"
# "1000090068,1000054150,1000008378,1000326424"

#Display Returned UCD Members
foreach($ucdPerson in $lPeople)
{

    #Display UCD Person
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

################################################
# HashSet for Unique IDs for Post People Lookup
################################################
$setMPLIDs = [System.Collections.Generic.HashSet[string]]::new();


################################
# Query Student Associations
################################

#Pull list of Student Associations by Query Parameter
$lStudentAssocs = $rosettaAPIWrkr.GetRosettaStudentAssociationBySearchTerm([RosettaStudentSearchBy]::MAJORCODE,"GMAE");

foreach($stndtAssoc in $lStudentAssocs)
{
    # Add Student's IAM to MPL IDs Set for People Post Lookup
    $setMPLIDs.Add($stdntAssoc.IAMID)

    #Display Student Association Info
    $stndtAssoc
}

################################
# Query Employee Associations
################################

#Pull list of Employee Associations by Query Parameter
$lEmployeeAssocs = $rosettaAPIWrkr.GetRosettaEmployeeAssociationBySearchTerm([RosettaEmployeeSearchBy]::IAMID,"1000550201");

#Display Employee Associations API Query Results
foreach($empAssoc in $lEmployeeAssocs)
{
    # Add Employee's IAM to MPL IDs Set for People Post Lookup 
    $setMPLIDs.Add($empAssoc.IAMID);

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
    $lUCDPeeps = $rosettaAPIWrkr.PostMassRosettaPeopleLookup([RosettaPeoplePostLookupBy]::IAMIDS,$setMPLIDs)

    $lUCDPeeps | Format-List;

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


