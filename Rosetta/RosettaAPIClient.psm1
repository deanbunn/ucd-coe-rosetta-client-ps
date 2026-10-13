

class RosettaPeopleSearchBy
{
    
    static [string]$IAMID = "iamid"
    static [string]$IAMIDS = "iamids"
    static [string]$IAMIDSALLSTATE = "affiliationState=all&iamids"
    static [string]$LOGINID = "loginid"
    static [string]$LOGINIDALLSTATE = "affiliationState=all&loginid"
    static [string]$EMAIL = "email"
    static [string]$EMPLOYEEID = "employeeid"
    static [string]$STUDENTID = "studentid"
    static [string]$MAILID = "mailid"
    static [string]$MAILIDALLSTATE = "affiliationState=all&mailid"
    static [string]$DEPARTMENT = "department"

}


class RosettaEmployeeAssociation
{

    [string]$IAMID = ""
    [string]$EmployeeRecord = ""
    [string]$EmployeeID = ""
    [string]$PositionNumber = ""
    [string]$PositionTitle = ""
    [string]$JobIndicator = ""
    [string]$RelationshipToOrganization = ""
    [string]$EmployeeClassification = ""
    [string]$EmployeeClassificationDescription = ""
    [string]$Status = ""
    [string]$HireDate = ""
    [string]$StartDate = ""
    [string]$FTEPercentage = ""
    [string]$JobTypeID = ""
    [string]$JobTypeDescription = ""
    [string]$OrganizationID = ""
    [string]$OrganizationTitle = ""
    [string]$DivisionID = ""
    [string]$DivisionTitle = ""
    [string]$SubdivisionID = ""
    [string]$SubdivisionTitle = ""
    [string]$SubdivisionL4ID = ""
    [string]$SubdivisionL4Title = ""
    [string]$BusinessUnitID = ""
    [string]$BusinessUnitTitle = ""
    [string]$DepartmentID = ""
    [string]$DepartmentTitle = ""
    [string]$DepartmentShortTitle = ""
    [string]$ReportsToPosition = ""
    [string]$ReportsToIAMID = ""
    [string]$ReportsToEmployeeID = ""
    [string]$IsHealthPosition = ""
    [string]$IsCampusPosition = ""

    RosettaEmployeeAssociation()
    {
        
    }

}