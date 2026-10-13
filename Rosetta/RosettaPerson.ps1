

. "./RosettaStudentAssociation.ps1"
. "./RosettaEmployeeAssociation.ps1"


class RosettaPerson
{

    [string]$IAMID = ""
    [string]$LoginID = ""
    [string]$MothraID = ""
    [string]$EmployeeID = ""
    [string]$StudentID = ""
    [string]$PIDM = ""
    [string]$UCNetID = ""
    [string]$CPEID = ""
    [string]$AffiliateID = ""
    [string]$DisplayName = ""
    [string]$MailIDCampus = ""
    [string]$MailIDHealth = ""
    [string]$EmailAddressCampus = ""        
    [string]$EmailAddressHealth = ""
    [string]$LivedFirstName = ""
    [string]$LivedLastName = ""
    [string]$LivedPronouns = ""
    [string]$ProvisioningStatusPrimary = ""
    [string]$ProvisioningStatusEmployee = ""
    [string]$ProvisioningStatusFaculty = ""
    [string]$ProvisioningStatusStudent = ""
    [string]$ProvisioningStatusStudentApplicant = ""
    [string]$ProvisioningStatusCPEAffiliate = ""
    [string]$ProvisioningStatusTemporaryAffiliate = ""
    [bool]$AffiliationEmployee = $false
    [bool]$AffiliationFaculty = $false
    [bool]$AffiliationStudent = $false
    [bool]$AffiliationStudentApplicant = $false
    [bool]$AffiliationHealthAffiliate = $false
    [bool]$AffiliationTemporaryAffiliate = $false
    [bool]$EmploymentIsAcademic = $false
    [bool]$EmploymentIsAcademicSenate = $false
    [bool]$EmploymentIsAcademicFederation = $false
    [bool]$EmploymentIsFaculty = $false
    [bool]$EmploymentIsTeachingFaculty = $false
    [bool]$EmploymentIsLadderRank = $false
    [bool]$EmploymentIsWithoutSalary = $false
    [bool]$EmploymentIsMSP = $false
    [bool]$EmploymentIsSSP = $false
    [bool]$EmploymentIsManager = $false
    [bool]$EmploymentIsCampusEmployee = $false
    [bool]$EmploymentIsHealthEmployee = $false
    [System.Collections.Generic.List[RosettaEmployeeAssociation]]$EmployeeAssociations
    [System.Collections.Generic.List[RosettaStudentAssociation]]$StudentAssociations

    RosettaPerson()
    {
        $this.EmployeeAssociations = [System.Collections.Generic.List[RosettaEmployeeAssociation]]::new()
        $this.StudentAssociations = [System.Collections.Generic.List[RosettaStudentAssociation]]::new()
    }

}

