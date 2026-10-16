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

# #Pull Listing of Rosetta Departments
# $lDepartments = $rosettaAPIWrkr.GetDepartments();

# #Export Department Listing to CSV in Local Directory
# $lDepartments | Export-Csv -Path ("Rosetta_Departments_" + (Get-Date).ToString("yyyy-MM-dd-HH-mm") + ".csv") -NoTypeInformation;

#########################
# Job Type IDs Listing
#########################

# #Pull Listing of Rosetta Job Type IDs
# $lJobTypeIDs = $rosettaAPIWrkr.GetJobTypeIDs();

# #Export Job Type IDs Listing to CSV in Local Directory
# $lJobTypeIDs | Export-Csv -Path ("Rosetta_JobTypeIDs_" + (Get-Date).ToString("yyyy-MM-dd-HH-mm") + ".csv") -NoTypeInformation;


################################
# Query Student Associations
################################

# #Pull list of Student Associations by Query Parameter
# $lStudentAssocs = $rosettaAPIWrkr.GetRosettaStudentAssociationBySearchTerm([RosettaStudentSearchBy]::MAJORCODE,"GMAE");

# $lStudentAssocs;

################################
# Query Employee Associations
################################

# #Pull list of Employee Associations by Query Parameter
# $lEmployeeAssocs = $rosettaAPIWrkr.GetRosettaEmployeeAssociationBySearchTerm([RosettaEmployeeSearchBy]::IAMID,"1000090068");

# $lEmployeeAssocs;


################################

$searchBy = "iamids"
$searchTerm = "1000505549,1000213158,1000572411,1000632980"

#Var for Search Result Limit
[int]$nSrchRsltLimit = 100;

#Var for Search Result Offset
[int]$nSrchRlstOffset = 0;

#Var for Retrieve More Search Results
[bool]$bRetrMoreSrchRslts = $true;

#Requests Loop
do
{

    #Check OAuth Token
    if($rosettaAPIWrkr.ChechOAuthToken() -eq $true)
    {

        #Var for Header of Endpoint Call
        $headersEPCall = @{"Authorization"="Bearer " + $rosettaAPIWrkr.OAuthToken};

        #Var for URI
        $peopleURI = $rosettaAPIWrkr.BaseURL + "people?" + $searchBy + "=" + $searchTerm + "&offset=" + $nSrchRlstOffset.ToString() + "&limit=" + $nSrchRsltLimit.ToString() + "&count=true"; 

        #Var for Returned Status Code
        [int]$statusCode = 0;

        #Var for X Total Count and X Response Count Header Information
        [int]$nTotalCnt = 0;
        [int]$nRspnCnt = 0;

        #Var for Returned Response Headers
        $responseHeaders = $null;

        #Make Rest Call to EndPoint
        $responseData = Invoke-RestMethod -Uri $peopleURI -Method GET -Headers $headersEPCall -StatusCodeVariable statusCode -ResponseHeadersVariable responseHeaders;

        #Check Returned Status Code
        if($statusCode -eq 200)
        {

            if($null -ne $responseHeaders['x-total-count'] -and $null -ne $responseHeaders['x-response-count'] -and [int]::TryParse($responseHeaders['x-total-count'],[ref]$nTotalCnt) -and [int]::TryParse($responseHeaders['x-response-count'],[ref]$nRspnCnt))
            {

                #Check Counts
                if($nTotalCnt -gt 0 -and $nRspnCnt -gt 0)
                {

                    Write-Verbose "Made it here!" -Verbose

                    $nTotalCnt

                    $nRspnCnt

                    foreach($usr in $responseData)
                    {
                        $usr.id | format-list
                    }

                    #Increment Offset
                    $nSrchRlstOffset += $nSrchRsltLimit;

                    #Check Offset to Total Count
                    if($nSrchRlstOffset -ge $nTotalCnt)
                    {
                        $bRetrMoreSrchRslts = $false;
                    }

                }
                else
                {
                    $bRetrMoreSrchRslts = $false;
                }
            
            }
            else
            {
                $bRetrMoreSrchRslts = $false;
            }

        }
        else
        {
            $bRetrMoreSrchRslts = $false;
        }

    }
    else
    {
        $bRetrMoreSrchRslts = $false;
    }

}
while($bRetrMoreSrchRslts -eq $true)

