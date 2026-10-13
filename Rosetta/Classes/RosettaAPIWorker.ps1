

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
        $rosettaDept = [RosettaDepartment]::new()

        #Retrieve Department ID
        if($null -ne $data.PSObject.Properties['department_id'] -and $null -ne $data.department_id)
        {
            $rosettaDept.DepartmentID = $data.department_id
        }

        #Retrieve Department Title
        if($null -ne $data.PSObject.Properties['department_title'] -and $null -ne $data.department_title)
        {
            $rosettaDept.DepartmentTitle = $data.department_title
        }

        #Retrieve Department Short Title
        if($null -ne $data.PSObject.Properties['department_short_title'] -and $null -ne $data.department_short_title)
        {
            $rosettaDept.DepartmentShortTitle = $data.department_short_title
        }
        
        #Retrieve Subdivision ID
        if($null -ne $data.PSObject.Properties['subdivision_id'] -and $null -ne $data.subdivision_id)
        {
            $rosettaDept.SubdivisionID = $data.subdivision_id
        }

        #Retrieve Subdivision Title
        if($null -ne $data.PSObject.Properties['subdivision_title'] -and $null -ne $data.subdivision_title)
        {
            $rosettaDept.SubdivisionTitle = $data.subdivision_title
        }
        
        #Retrieve SubDivision L4 ID
        if($null -ne $data.PSObject.Properties['subdivision_l4_id'] -and $null -ne $data.subdivision_l4_id)
        {
            $rosettaDept.SubDivisionL4ID = $data.subdivision_l4_id
        }

        #Retrieve SubDivision L4 Title
        if($null -ne $data.PSObject.Properties['subdivision_l4_title'] -and $null -ne $data.subdivision_l4_title)
        {
            $rosettaDept.SubdivisionL4Title = $data.subdivision_l4_title
        }

        #Retrieve Division ID
        if($null -ne $data.PSObject.Properties['division_id'] -and $null -ne $data.division_id)
        {
            $rosettaDept.DivisionID = $data.division_id
        }

        #Retrieve Division Title
        if($null -ne $data.PSObject.Properties['division_title'] -and $null -ne $data.division_title)
        {
            $rosettaDept.DivisionTitle = $data.division_title
        }

        #Retrieve Organization ID
        if($null -ne $data.PSObject.Properties['organization_id'] -and $null -ne $data.organization_id)
        {
            $rosettaDept.OrganizationID = $data.organization_id
        }

        #Retrieve Organization Title
        if($null -ne $data.PSObject.Properties['organization_title'] -and $null -ne $data.organization_title)
        {
            $rosettaDept.OrganizationTitle = $data.organization_title
        }
       
        return $rosettaDept

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
            $deptsURI = $this.BaseURL + "employee-association/departments";

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




