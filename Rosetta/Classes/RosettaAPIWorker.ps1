

class RosettaAPIWorker
{

    [string]$BaseURL
    [string]$TokenURL
    [string]$ClientID
    [string]$ClientSecret
    [string]$OAuthToken
    [datetime]$ExpiresIn

    #Constructor
    RosettaAPIWorker([string]$baseURL, [string]$tokenURL, [string]$clientID, [string]$clientSecret)
    {
        $this.BaseURL = $baseURL
        $this.TokenURL = $tokenURL
        $this.ClientID = $clientID
        $this.ClientSecret = $clientSecret
        $this.ExpiresIn = (Get-Date).AddHours(-1)
    }

    #################################
    # Parsing Rosetta Json Functions
    #################################

    [RosettaDepartment] ParseRosettaDepartmentData([object]$data)
    {
        #Initialize Returned Object
        $rosettaDept = [RosettaDepartment]::new();

        #Retrieve Department ID
        if($null -ne $data.PSObject.Properties['department_id'] -and $null -ne $data.department_id)
        {
            $rosettaDept.DepartmentID = $data.department_id;
        }

        #Retrieve Department Title
        if($null -ne $data.PSObject.Properties['department_title'] -and $null -ne $data.department_title)
        {
            $rosettaDept.DepartmentTitle = $data.department_title;
        }

        #Retrieve Department Short Title
        if($null -ne $data.PSObject.Properties['department_short_title'] -and $null -ne $data.department_short_title)
        {
            $rosettaDept.DepartmentShortTitle = $data.department_short_title;
        }
        
        #Retrieve Subdivision ID
        if($null -ne $data.PSObject.Properties['subdivision_id'] -and $null -ne $data.subdivision_id)
        {
            $rosettaDept.SubdivisionID = $data.subdivision_id;
        }

        #Retrieve Subdivision Title
        if($null -ne $data.PSObject.Properties['subdivision_title'] -and $null -ne $data.subdivision_title)
        {
            $rosettaDept.SubdivisionTitle = $data.subdivision_title;
        }
        
        #Retrieve SubDivision L4 ID
        if($null -ne $data.PSObject.Properties['subdivision_l4_id'] -and $null -ne $data.subdivision_l4_id)
        {
            $rosettaDept.SubDivisionL4ID = $data.subdivision_l4_id;
        }

        #Retrieve SubDivision L4 Title
        if($null -ne $data.PSObject.Properties['subdivision_l4_title'] -and $null -ne $data.subdivision_l4_title)
        {
            $rosettaDept.SubdivisionL4Title = $data.subdivision_l4_title;
        }

        #Retrieve Division ID
        if($null -ne $data.PSObject.Properties['division_id'] -and $null -ne $data.division_id)
        {
            $rosettaDept.DivisionID = $data.division_id;
        }

        #Retrieve Division Title
        if($null -ne $data.PSObject.Properties['division_title'] -and $null -ne $data.division_title)
        {
            $rosettaDept.DivisionTitle = $data.division_title;
        }

        #Retrieve Organization ID
        if($null -ne $data.PSObject.Properties['organization_id'] -and $null -ne $data.organization_id)
        {
            $rosettaDept.OrganizationID = $data.organization_id;
        }

        #Retrieve Organization Title
        if($null -ne $data.PSObject.Properties['organization_title'] -and $null -ne $data.organization_title)
        {
            $rosettaDept.OrganizationTitle = $data.organization_title;
        }
       
        return $rosettaDept

    }

    [RosettaEmployeeAssociation] ParseRosettaEmployeeAssocData([object]$data)
    {
        #Initialize Returned Object
        $rosettaEmployeeAssoc = [RosettaEmployeeAssociation]::new();

        #Retrieve IAM ID
        if($null -ne $data.PSObject.Properties['iam_id'] -and $null -ne $data.iam_id)
        {
            $rosettaEmployeeAssoc.IAMID = $data.iam_id;
        }

        #Retrieve Reports to IAM ID
        if($null -ne $data.PSObject.Properties['reports_to_iam_id'] -and $null -ne $data.reports_to_iam_id)
        {
            $rosettaEmployeeAssoc.ReportsToIAMID = $data.reports_to_iam_id;
        }

        #Retrieve Reports to Employee ID
        if($null -ne $data.PSObject.Properties['reports_to_employee_id'] -and $null -ne $data.reports_to_employee_id)
        {
            $rosettaEmployeeAssoc.ReportsToEmployeeID = $data.reports_to_employee_id;
        }

        #Retrieve Employee ID
        if($null -ne $data.PSObject.Properties['employee_id'] -and $null -ne $data.employee_id)
        {
            $rosettaEmployeeAssoc.EmployeeID = $data.employee_id;
        }

        #Retrieve Employee Record
        if($null -ne $data.PSObject.Properties['employee_record'] -and $null -ne $data.employee_record)
        {
            $rosettaEmployeeAssoc.EmployeeRecord = $data.employee_record;
        }

        #Retrieve Position Number
        if($null -ne $data.PSObject.Properties['position_number'] -and $null -ne $data.position_number)
        {
            $rosettaEmployeeAssoc.PositionNumber = $data.position_number;
        }

        #Retrieve Position Title
        if($null -ne $data.PSObject.Properties['position_title'] -and $null -ne $data.position_title)
        {
            $rosettaEmployeeAssoc.PositionTitle = $data.position_title;
        }

        #Retrieve Job Indicator
        if($null -ne $data.PSObject.Properties['job_indicator'] -and $null -ne $data.job_indicator)
        {
            $rosettaEmployeeAssoc.JobIndicator = $data.job_indicator;
        }

        #Retrieve Relationship to Organization
        if($null -ne $data.PSObject.Properties['relationship_to_organization'] -and $null -ne $data.relationship_to_organization)
        {
            $rosettaEmployeeAssoc.RelationshipToOrganization = $data.relationship_to_organization;
        }

        #Retrieve Employee Classification
        if($null -ne $data.PSObject.Properties['employee_classification'] -and $null -ne $data.employee_classification)
        {
            $rosettaEmployeeAssoc.EmployeeClassification = $data.employee_classification;
        }

        #Retrieve Employee Classification Description
        if($null -ne $data.PSObject.Properties['employee_classification_description'] -and $null -ne $data.employee_classification_description)
        {
            $rosettaEmployeeAssoc.EmployeeClassificationDescription = $data.employee_classification_description;
        }

        #Retrieve Status
        if($null -ne $data.PSObject.Properties['status'] -and $null -ne $data.status)
        {
            $rosettaEmployeeAssoc.Status = $data.status;
        }

        #Retrieve Hire Date
        if($null -ne $data.PSObject.Properties['hire_date'] -and $null -ne $data.hire_date)
        {
            $rosettaEmployeeAssoc.HireDate = $data.hire_date;
        }

        #Retrieve Start Date
        if($null -ne $data.PSObject.Properties['start_date'] -and $null -ne $data.start_date)
        {
            $rosettaEmployeeAssoc.StartDate = $data.start_date;
        }

        #Retrieve FTE Percentage
        if($null -ne $data.PSObject.Properties['fte_percentage'] -and $null -ne $data.fte_percentage)
        {
            $rosettaEmployeeAssoc.FTEPercentage = $data.fte_percentage;
        }

        #Retrieve Reports to Position
        if($null -ne $data.PSObject.Properties['reports_to_position'] -and $null -ne $data.reports_to_position)
        {
            $rosettaEmployeeAssoc.ReportsToPosition = $data.reports_to_position;
        }

        #Retrieve Job Type ID
        if($null -ne $data.PSObject.Properties['job_type_id'] -and $null -ne $data.job_type_id)
        {
            $rosettaEmployeeAssoc.JobTypeID = $data.job_type_id;
        }

        #Retrieve Job Type Description
        if($null -ne $data.PSObject.Properties['job_type_description'] -and $null -ne $data.job_type_description)
        {
            $rosettaEmployeeAssoc.JobTypeDescription = $data.job_type_description;
        }

        #Retrieve Organization ID
        if($null -ne $data.PSObject.Properties['organization_id'] -and $null -ne $data.organization_id)
        {
            $rosettaEmployeeAssoc.OrganizationID = $data.organization_id;
        }

        #Retrieve Organization Title
        if($null -ne $data.PSObject.Properties['organization_title'] -and $null -ne $data.organization_title)
        {
            $rosettaEmployeeAssoc.OrganizationTitle = $data.organization_title;
        }

        #Retrieve Division ID
        if($null -ne $data.PSObject.Properties['division_id'] -and $null -ne $data.division_id)
        {
            $rosettaEmployeeAssoc.DivisionID = $data.division_id;
        }

        #Retrieve Division Title
        if($null -ne $data.PSObject.Properties['division_title'] -and $null -ne $data.division_title)
        {
            $rosettaEmployeeAssoc.DivisionTitle = $data.division_title;
        }

        #Retrieve Subdivision ID
        if($null -ne $data.PSObject.Properties['subdivision_id'] -and $null -ne $data.subdivision_id)
        {
            $rosettaEmployeeAssoc.SubdivisionID = $data.subdivision_id;
        }

        #Retrieve Subdivision Title
        if($null -ne $data.PSObject.Properties['subdivision_title'] -and $null -ne $data.subdivision_title)
        {
            $rosettaEmployeeAssoc.SubdivisionTitle = $data.subdivision_title;
        }

        #Retrieve Subdivision L4 ID
        if($null -ne $data.PSObject.Properties['subdivision_l4_id'] -and $null -ne $data.subdivision_l4_id)
        {
            $rosettaEmployeeAssoc.SubDivisionL4ID = $data.subdivision_l4_id;
        }

        #Retrieve Subdivision L4 Title
        if($null -ne $data.PSObject.Properties['subdivision_l4_title'] -and $null -ne $data.subdivision_l4_title)
        {
            $rosettaEmployeeAssoc.SubdivisionL4ID = $data.subdivision_l4_title;
        }

        #Retrieve Business Unit ID
        if($null -ne $data.PSObject.Properties['business_unit_id'] -and $null -ne $data.business_unit_id)
        {
            $rosettaEmployeeAssoc.BusinessUnitID = $data.business_unit_id;
        }

        #Retrieve Business Unit Title
        if($null -ne $data.PSObject.Properties['business_unit_title'] -and $null -ne $data.business_unit_title)
        {
            $rosettaEmployeeAssoc.BusinessUnitTitle = $data.business_unit_title;
        }

        #Retrieve Department ID
        if($null -ne $data.PSObject.Properties['department_id'] -and $null -ne $data.department_id)
        {
            $rosettaEmployeeAssoc.DepartmentID = $data.department_id;
        }

        #Retrieve Department Title
        if($null -ne $data.PSObject.Properties['department_title'] -and $null -ne $data.department_title)
        {
            $rosettaEmployeeAssoc.DepartmentTitle = $data.department_title;
        }

        #Retrieve Department Short Title
        if($null -ne $data.PSObject.Properties['department_short_title'] -and $null -ne $data.department_short_title)
        {
            $rosettaEmployeeAssoc.DepartmentShortTitle = $data.department_short_title;
        }

        #Retrieve Is Health Position
        if($null -ne $data.PSObject.Properties['is_health_position'] -and $null -ne $data.is_health_position)
        {
            $rosettaEmployeeAssoc.IsHealthPosition = $data.is_health_position;
        }

        #Retrieve Is Campus Position
        if($null -ne $data.PSObject.Properties['is_campus_position'] -and $null -ne $data.is_campus_position)
        {
            $rosettaEmployeeAssoc.IsCampusPosition = $data.is_campus_position;
        }

        #Retrieve Modification Date
        if($null -ne $data.PSObject.Properties['modified_date'] -and $null -ne $data.modified_date)
        {
            $rosettaEmployeeAssoc.ModifiedDate = $data.modified_date;
        }

        #Retrieve Creation Date
        if($null -ne $data.PSObject.Properties['create_date'] -and $null -ne $data.create_date)
        {
            $rosettaEmployeeAssoc.CreateDate = $data.create_date;
        }


        return $rosettaEmployeeAssoc
    }

    [RosettaStudentAssociation] ParseRosettaStudentAssocData([object]$data)
    {
        #Initialize Returned Object
        $rosettaStdntAssoc = [RosettaStudentAssociation]::new()

        #Retrieve IAM ID
        if($null -ne $data.PSObject.Properties['iam_id'] -and $null -ne $data.iam_id)
        {
            $rosettaStdntAssoc.IAMID = $data.iam_id;
        }

        #Retrieve Student ID
        if($null -ne $data.PSObject.Properties['student_id'] -and $null -ne $data.student_id)
        {
            $rosettaStdntAssoc.StudentID = $data.student_id;
        }

        #Retrieve PIDM
        if($null -ne $data.PSObject.Properties['pidm'] -and $null -ne $data.pidm)
        {
            $rosettaStdntAssoc.PIDM = $data.pidm;
        }

        #Retrieve College Code
        if($null -ne $data.PSObject.Properties['college_code'] -and $null -ne $data.college_code)
        {
            $rosettaStdntAssoc.CollegeCode = $data.college_code;
        }

        #Retrieve College Title
        if($null -ne $data.PSObject.Properties['college_title'] -and $null -ne $data.college_title)
        {
            $rosettaStdntAssoc.CollegeTitle = $data.college_title;
        }

        #Retrieve Major Code
        if($null -ne $data.PSObject.Properties['major_code'] -and $null -ne $data.major_code)
        {
            $rosettaStdntAssoc.MajorCode = $data.major_code;
        }

        #Retrieve Major Title
        if($null -ne $data.PSObject.Properties['major_title'] -and $null -ne $data.major_title)
        {
            $rosettaStdntAssoc.MajorTitle = $data.major_title;
        }

        #Retrieve Academic Level
        if($null -ne $data.PSObject.Properties['academic_level'] -and $null -ne $data.academic_level)
        {
            $rosettaStdntAssoc.AcademicLevel = $data.academic_level;
        }

        #Retrieve Level Affiliation Code
        if($null -ne $data.PSObject.Properties['lvl_affiliation_code'] -and $null -ne $data.lvl_affiliation_code)
        {
            $rosettaStdntAssoc.AcademicLevel = $data.lvl_affiliation_code;
        }

        #Retrieve Class Level
        if($null -ne $data.PSObject.Properties['class_level'] -and $null -ne $data.class_level)
        {
            $rosettaStdntAssoc.ClassLevel = $data.class_level;
        }

        #Retrieve Class Affiliation Code
        if($null -ne $data.PSObject.Properties['cls_affiliation_code'] -and $null -ne $data.cls_affiliation_code)
        {
            $rosettaStdntAssoc.ClassLevel = $data.cls_affiliation_code;
        }

        return $rosettaStdntAssoc
    }




    ############################################
    # Rosetta API Call Functions
    ############################################

    [bool] ChechOAuthToken()
    {
        #Var for Return Status
        [bool]$bTokenStatus = $true;

        #Check ExpiresIn Value
        if($this.ExpiresIn -lt (Get-Date).AddMinutes(1))
        {
            #Configure OAuth Call Headers
            $headersOAuthCall = @{"client_id"=$this.ClientID;
                                  "client_secret"=$this.ClientSecret;
                                  "grant_type"="CLIENT_CREDENTIALS";
                                  "scope"="read:public"
                                 };

            #Var for Returned Status Code
            [int]$statusCode = 0

            #Make Rest Call to Token EndPoint to Get Access Token
            $rtnTokenInfo = Invoke-RestMethod -Uri $this.TokenURL -Method POST -Headers $headersOAuthCall -StatusCodeVariable statusCode;

            if($statusCode -eq 200 -and [string]::IsNullOrEmpty($rtnTokenInfo.access_token) -eq $false)
            {
                $this.OAuthToken = $rtnTokenInfo.access_token;
                $this.ExpiresIn = (Get-Date).AddSeconds($rtnTokenInfo.expires_in);
            }
            else
            {
                $bTokenStatus = $false
            }

        }#End of ExpiresIn Check

        return $bTokenStatus

    }

    # Get Departments Information
    [System.Collections.Generic.List[RosettaDepartment]] GetDepartments()
    {
        #Var for Return List Type
        $departments = [System.Collections.Generic.List[RosettaDepartment]]::new()

        if($this.ChechOAuthToken() -eq $true)
        {
            #Var for Header of Endpoint Call
            $headersEPCall = @{"Authorization"="Bearer " + $this.OAuthToken};

            #Var for URI
            $deptsURI = $this.BaseURL + "employee-association/departments?limit=3000";

            #Var for Returned Status Code
            [int]$statusCode = 0

            #Make Rest Call to EndPoint
            $responseData = Invoke-RestMethod -Uri $deptsURI -Method GET -Headers $headersEPCall -StatusCodeVariable statusCode;

            #Check Returned Status Code
            if($statusCode -eq 200)
            {

                #Go Through Returned Data
                foreach($ucdDept in $responseData)
                {
                    $departments.Add($this.ParseRosettaDepartmentData($ucdDept))
                }

            }
            
        }#End of OAuth Token Check

        return $departments
    }

    # Get Job Type IDs Information
    [System.Collections.Generic.List[RosettaJobTypeID]] GetJobTypeIDs()
    {
        #Var for Return List Type
        $jtids = [System.Collections.Generic.List[RosettaJobTypeID]]::new()

        if($this.ChechOAuthToken() -eq $true)
        {
            #Var for Header of Endpoint Call
            $headersEPCall = @{"Authorization"="Bearer " + $this.OAuthToken};

            #Var for URI
            $jtidsURI = $this.BaseURL + "employee-association/jobtypeids";

            #Var for Returned Status Code
            [int]$statusCode = 0

            #Make Rest Call to EndPoint
            $responseData = Invoke-RestMethod -Uri $jtidsURI -Method GET -Headers $headersEPCall -StatusCodeVariable statusCode;

            #Check Returned Status Code
            if($statusCode -eq 200)
            {

                #Go Through Returned Data
                foreach($ucdJTID in $responseData)
                {
                    #Initiate Rosetta Job Type ID
                    $jtid = [RosettaJobTypeID]::new();

                    #Retrieve Job Type ID 
                    if($null -ne $ucdJTID.PSObject.Properties['job_type_id'] -and $null -ne $ucdJTID.job_type_id)
                    {
                        $jtid.JobTypeID = $ucdJTID.job_type_id
                    } 

                    #Retrieve Job Type Description
                    if($null -ne $ucdJTID.PSObject.Properties['job_type_description'] -and $null -ne $ucdJTID.job_type_description)
                    {
                        $jtid.JobTypeDescription = $ucdJTID.job_type_description
                    }   

                    # Add Job Type ID to Return List
                    $jtids.Add($jtid);
                }

            }
            
        }#End of OAuth Token Check

        return $jtids
    }

    # Get Employee Associations by Search Term
    [System.Collections.Generic.List[RosettaEmployeeAssociation]] GetRosettaEmployeeAssociationBySearchTerm([string]$searchBy,[string]$searchTerm)
    {

        #Var for Return List Type
        $emplyeeAssocs = [System.Collections.Generic.List[RosettaEmployeeAssociation]]::new();

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
            if($this.ChechOAuthToken() -eq $true)
            {

                #Var for Header of Endpoint Call
                $headersEPCall = @{"Authorization"="Bearer " + $this.OAuthToken};

                #Var for URI
                $employeesURI = $this.BaseURL + "employee-association?" + $searchBy + "=" + $searchTerm + "&offset=" + $nSrchRlstOffset.ToString() + "&limit=" + $nSrchRsltLimit.ToString() + "&count=true"; 

                #Var for Returned Status Code
                [int]$statusCode = 0;

                #Var for X Total Count and X Response Count Header Information
                [int]$nTotalCnt = 0;
                [int]$nRspnCnt = 0;

                #Var for Returned Response Headers
                $responseHeaders = $null;

                #Make Rest Call to EndPoint
                $responseData = Invoke-RestMethod -Uri $employeesURI -Method GET -Headers $headersEPCall -StatusCodeVariable statusCode -ResponseHeadersVariable responseHeaders;

                #Check Returned Status Code
                if($statusCode -eq 200)
                {

                    if($null -ne $responseHeaders['x-total-count'] -and $null -ne $responseHeaders['x-response-count'] -and [int]::TryParse($responseHeaders['x-total-count'],[ref]$nTotalCnt) -and [int]::TryParse($responseHeaders['x-response-count'],[ref]$nRspnCnt))
                    {

                        #Check Counts
                        if($nTotalCnt -gt 0 -and $nRspnCnt -gt 0)
                        {

                            #Go Through Returned Data and Parse It Before Adding to Returned List
                            foreach($ucdEmplAssoc in $responseData)
                            {
                                $emplyeeAssocs.Add($this.ParseRosettaEmployeeAssocData($ucdEmplAssoc));
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

        return $emplyeeAssocs

    }


    # Get Student Associations by Search Term
    [System.Collections.Generic.List[RosettaStudentAssociation]] GetRosettaStudentAssociationBySearchTerm([string]$searchBy,[string]$searchTerm)
    {

        #Var for Return List Type
        $stdntAssocs = [System.Collections.Generic.List[RosettaStudentAssociation]]::new();

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
            if($this.ChechOAuthToken() -eq $true)
            {

                #Var for Header of Endpoint Call
                $headersEPCall = @{"Authorization"="Bearer " + $this.OAuthToken};

                #Var for URI
                $studentsURI = $this.BaseURL + "student-association?" + $searchBy + "=" + $searchTerm + "&offset=" + $nSrchRlstOffset.ToString() + "&limit=" + $nSrchRsltLimit.ToString() + "&count=true"; 

                #Var for Returned Status Code
                [int]$statusCode = 0;

                #Var for X Total Count and X Response Count Header Information
                [int]$nTotalCnt = 0;
                [int]$nRspnCnt = 0;

                #Var for Returned Response Headers
                $responseHeaders = $null;

                #Make Rest Call to EndPoint
                $responseData = Invoke-RestMethod -Uri $studentsURI -Method GET -Headers $headersEPCall -StatusCodeVariable statusCode -ResponseHeadersVariable responseHeaders;

                #Check Returned Status Code
                if($statusCode -eq 200)
                {

                    if($null -ne $responseHeaders['x-total-count'] -and $null -ne $responseHeaders['x-response-count'] -and [int]::TryParse($responseHeaders['x-total-count'],[ref]$nTotalCnt) -and [int]::TryParse($responseHeaders['x-response-count'],[ref]$nRspnCnt))
                    {

                        #Check Counts
                        if($nTotalCnt -gt 0 -and $nRspnCnt -gt 0)
                        {

                            #Go Through Returned Data and Parse It Before Adding to Returned List
                            foreach($ucdStdntAssoc in $responseData)
                            {
                                $stdntAssocs.Add($this.ParseRosettaStudentAssocData($ucdStdntAssoc));
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

        return $stdntAssocs

    }


    ##############
    # Extras
    ##############   

    #Notification Message
    #Write-Verbose "Hope this works!" -Verbose
    #Write-Verbose "Made it here!" -Verbose

    ##Var for Regular EndPoint Headers Calls
    #$headersEPCall = @{"Authorization"="Bearer " + $UCDAPIInfo.oauth_token;};

    ################

}


# # Display all returned headers
# $responseHeaders

# $contentType = $responseHeaders["Content-Type"]
# $requestId = $responseHeaders["X-Request-ID"]




