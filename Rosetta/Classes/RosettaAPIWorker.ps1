

class RosettaAPIWorker
{

    [string]$BaseURL
    [string]$TokenURL
    [string]$ClientID
    [string]$ClientSecret
    [string]$OAuthToken
    [int]$ErrorCount
    [datetime]$ExpiresIn

    #Constructor
    RosettaAPIWorker([string]$baseURL, [string]$tokenURL, [string]$clientID, [string]$clientSecret)
    {
        $this.BaseURL = $baseURL
        $this.TokenURL = $tokenURL
        $this.ClientID = $clientID
        $this.ClientSecret = $clientSecret
        $this.ErrorCount = 0
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
        if($null -ne $data.PSObject.Properties['position_entry_date'] -and $null -ne $data.position_entry_date)
        {
            $rosettaEmployeeAssoc.PositionEntryDate = $data.position_entry_date;
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
            $rosettaEmployeeAssoc.SubdivisionL4ID = $data.subdivision_l4_id;
        }

        #Retrieve Subdivision L4 Title
        if($null -ne $data.PSObject.Properties['subdivision_l4_title'] -and $null -ne $data.subdivision_l4_title)
        {
            $rosettaEmployeeAssoc.SubdivisionL4Title = $data.subdivision_l4_title;
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

    [RosettaPerson] ParseRosettaPersonData([object]$data)
    {
        #Initialize Returned Object
        $rosettaPerson = [RosettaPerson]::new();

        #Retrieve IAM ID
        if($null -ne $data.PSObject.Properties['iam_id'] -and $null -ne $data.iam_id)
        {
            $rosettaPerson.IAMID = $data.iam_id;
        }

        #Retrieve Display Name
        if($null -ne $data.PSObject.Properties['displayname'] -and $null -ne $data.displayname)
        {
            $rosettaPerson.DisplayName = $data.displayname;
        }

        #Retrieve Modification Date
        if($null -ne $data.PSObject.Properties['modified_date'] -and $null -ne $data.modified_date)
        {
            $rosettaPerson.ModifiedDate = $data.modified_date;
        }

        #Retrieve Creation Date
        if($null -ne $data.PSObject.Properties['create_date'] -and $null -ne $data.create_date)
        {
            $rosettaPerson.CreateDate = $data.create_date;
        }

        #Retrieve ID Subsection 
        if($null -ne $data.PSObject.Properties['id'] -and $null -ne $data.id)
        {
            #Retrieve IAM ID
            if($null -ne $data.id.PSObject.Properties['iam_id'] -and $null -ne $data.id.iam_id)
            {
                $rosettaPerson.IAMID = $data.id.iam_id;
            }

            #Retrieve Login ID
            if($null -ne $data.id.PSObject.Properties['login_id'] -and $null -ne $data.id.login_id)
            {
                $rosettaPerson.LoginID = $data.id.login_id;
            }

            #Retrieve Mothra ID
            if($null -ne $data.id.PSObject.Properties['mothra_id'] -and $null -ne $data.id.mothra_id)
            {
                $rosettaPerson.MothraID = $data.id.mothra_id;
            }

            #Retrieve Employee ID
            if($null -ne $data.id.PSObject.Properties['employee_id'] -and $null -ne $data.id.employee_id)
            {
                $rosettaPerson.EmployeeID = $data.id.employee_id;
            }

            #Retrieve Student ID
            if($null -ne $data.id.PSObject.Properties['student_id'] -and $null -ne $data.id.student_id)
            {
                $rosettaPerson.StudentID = $data.id.student_id;
            }

            #Retrieve PIDM
            if($null -ne $data.id.PSObject.Properties['pidm'] -and $null -ne $data.id.pidm)
            {
                $rosettaPerson.PIDM = $data.id.pidm;
            }

            #Retrieve UCNet ID
            if($null -ne $data.id.PSObject.Properties['ucnet_id'] -and $null -ne $data.id.ucnet_id)
            {
                $rosettaPerson.UCNetID = $data.id.ucnet_id;
            }

            #Retrieve CPE ID
            if($null -ne $data.id.PSObject.Properties['cpe_id'] -and $null -ne $data.id.cpe_id)
            {
                $rosettaPerson.CPEID = $data.id.cpe_id;
            }

            #Retrieve Affiliate ID
            if($null -ne $data.id.PSObject.Properties['affiliate_id'] -and $null -ne $data.id.affiliate_id)
            {
                $rosettaPerson.AffiliateID = $data.id.affiliate_id;
            }

            #Retrieve Mail IDs Subsection
            if($null -ne $data.id.PSObject.Properties['mail_id'] -and $null -ne $data.id.mail_id)
            {
                #Retrieve Campus Mail ID
                if($null -ne $data.id.mail_id.PSObject.Properties['campus'] -and $null -ne $data.id.mail_id.campus)
                {
                    $rosettaPerson.MailIDCampus = $data.id.mail_id.campus;
                }

                #Retrieve Health Mail ID
                if($null -ne $data.id.mail_id.PSObject.Properties['health'] -and $null -ne $data.id.mail_id.health)
                {
                    $rosettaPerson.MailIDHealth = $data.id.mail_id.health;
                }

            }#End of Mail IDs Subsection

        }#End of IDs Subsection

        #Retrieve Name Subsection 
        if($null -ne $data.PSObject.Properties['name'] -and $null -ne $data.name)
        {

            #Retrieve Lived First Name
            if($null -ne $data.name.PSObject.Properties['lived_first_name'] -and $null -ne $data.name.lived_first_name)
            {
                $rosettaPerson.LivedFirstName = $data.name.lived_first_name;
            }

            #Retrieve Lived Last Name
            if($null -ne $data.name.PSObject.Properties['lived_last_name'] -and $null -ne $data.name.lived_last_name)
            {
                $rosettaPerson.LivedLastName = $data.name.lived_last_name;
            }

            #Retrieve Lived Pronouns
            if($null -ne $data.name.PSObject.Properties['lived_pronouns'] -and $null -ne $data.name.lived_pronouns)
            {
                $rosettaPerson.LivedPronouns = $data.name.lived_pronouns;
            }

        }#End of Name Subsection

        #Retrieve Email Addresses Node
        if($null -ne $data.PSObject.Properties['email'] -and $null -ne $data.email)
        {
            #Retrieve Campus Email Address
            if($null -ne $data.email.PSObject.Properties['campus'] -and $null -ne $data.email.campus)
            {
                $rosettaPerson.EmailAddressCampus = $data.email.campus;
            }

            #Retrieve Health Email Address
            if($null -ne $data.email.PSObject.Properties['health'] -and $null -ne $data.email.health)
            {
                $rosettaPerson.EmailAddressHealth = $data.email.health;
            }

        }#End of Email Addresses Node

        #Retrieve Provisioning Status Node
        if($null -ne $data.PSObject.Properties['provisioning_status'] -and $null -ne $data.provisioning_status)
        {
            #Retrieve Primary Provisioning Status
            if($null -ne $data.provisioning_status.PSObject.Properties['primary'] -and $null -ne $data.provisioning_status.primary)
            {
                $rosettaPerson.ProvisioningStatusPrimary = $data.provisioning_status.primary;
            }

            #Retrieve Employee Provisioning Status
            if($null -ne $data.provisioning_status.PSObject.Properties['employee'] -and $null -ne $data.provisioning_status.employee)
            {
                $rosettaPerson.ProvisioningStatusEmployee = $data.provisioning_status.employee;
            }

            #Retrieve Faculty Provisioning Status
            if($null -ne $data.provisioning_status.PSObject.Properties['faculty'] -and $null -ne $data.provisioning_status.faculty)
            {
                $rosettaPerson.ProvisioningStatusFaculty = $data.provisioning_status.faculty;
            }

            #Retrieve Student Provisioning Status
            if($null -ne $data.provisioning_status.PSObject.Properties['student'] -and $null -ne $data.provisioning_status.student)
            {
                $rosettaPerson.ProvisioningStatusStudent = $data.provisioning_status.student;
            }

            #Retrieve Student Applicant Provisioning Status
            if($null -ne $data.provisioning_status.PSObject.Properties['student_applicant'] -and $null -ne $data.provisioning_status.student_applicant)
            {
                $rosettaPerson.ProvisioningStatusStudentApplicant = $data.provisioning_status.student_applicant;
            }

            #Retrieve CPE Affiliate Provisioning Status
            if($null -ne $data.provisioning_status.PSObject.Properties['cpe_affiliate'] -and $null -ne $data.provisioning_status.cpe_affiliate)
            {
                $rosettaPerson.ProvisioningStatusCPEAffiliate = $data.provisioning_status.cpe_affiliate;
            }

            #Retrieve Temporary Affiliate Provisioning Status
            if($null -ne $data.provisioning_status.PSObject.Properties['temporary_affiliate'] -and $null -ne $data.provisioning_status.temporary_affiliate)
            {
                $rosettaPerson.ProvisioningStatusTemporaryAffiliate = $data.provisioning_status.temporary_affiliate;
            }


        }#End of Provisioning Status Node

        #Retrieve Affiliations Node
        if($null -ne $data.PSObject.Properties['affiliation'] -and $null -ne $data.affiliation)
        {

            #Retrieve Employee Affiliation
            if($null -ne $data.affiliation.PSObject.Properties['employee'] -and $null -ne $data.affiliation.employee)
            {

                if($data.affiliation.employee.ToString().ToUpper() -eq "Y")
                {
                    $rosettaPerson.AffiliationEmployee = $true;
                }
                else
                {
                    $rosettaPerson.AffiliationEmployee = $false;
                }
               
            }#End of Employee Affiliation

            #Retrieve Faculty Affiliation
            if($null -ne $data.affiliation.PSObject.Properties['faculty'] -and $null -ne $data.affiliation.faculty)
            {

                if($data.affiliation.faculty.ToString().ToUpper() -eq "Y")
                {
                    $rosettaPerson.AffiliationFaculty = $true;
                }
                else
                {
                    $rosettaPerson.AffiliationFaculty = $false;
                }
               
            }#End of Faculty Affiliation

            #Retrieve Temporary Affiliation
            if($null -ne $data.affiliation.PSObject.Properties['temporary_affiliate'] -and $null -ne $data.affiliation.temporary_affiliate)
            {

                if($data.affiliation.temporary_affiliate.ToString().ToUpper() -eq "Y")
                {
                    $rosettaPerson.AffiliationTemporaryAffiliate = $true;
                }
                else
                {
                    $rosettaPerson.AffiliationTemporaryAffiliate = $false;
                }
               
            }#End of Temporary Affiliation

            #Retrieve Student Affiliation
            if($null -ne $data.affiliation.PSObject.Properties['student'] -and $null -ne $data.affiliation.student)
            {

                if($data.affiliation.student.ToString().ToUpper() -eq "Y")
                {
                    $rosettaPerson.AffiliationStudent = $true;
                }
                else
                {
                    $rosettaPerson.AffiliationStudent = $false;
                }
               
            }#End of Student Affiliation

            #Retrieve Student Applicant Affiliation
            if($null -ne $data.affiliation.PSObject.Properties['student_applicant'] -and $null -ne $data.affiliation.student_applicant)
            {

                if($data.affiliation.student_applicant.ToString().ToUpper() -eq "Y")
                {
                    $rosettaPerson.AffiliationStudentApplicant = $true;
                }
                else
                {
                    $rosettaPerson.AffiliationStudentApplicant = $false;
                }
               
            }#End of Student Applicant Affiliation

            #Retrieve Health Affiliation
            if($null -ne $data.affiliation.PSObject.Properties['health_affiliate'] -and $null -ne $data.affiliation.health_affiliate)
            {

                if($data.affiliation.health_affiliate.ToString().ToUpper() -eq "Y")
                {
                    $rosettaPerson.AffiliationHealthAffiliate = $true;
                }
                else
                {
                    $rosettaPerson.AffiliationHealthAffiliate = $false;
                }
               
            }#End of Health Affiliation

        }#End of Affiliations Node

        #Retrieve Employment Status Node
        if($null -ne $data.PSObject.Properties['employment_status'] -and $null -ne $data.employment_status)
        {

            #Retrieve Academic Status
            if($null -ne $data.employment_status.PSObject.Properties['is_academic'] -and $null -ne $data.employment_status.is_academic)
            {

                if($data.employment_status.is_academic.ToString().ToUpper() -eq "Y")
                {
                    $rosettaPerson.EmploymentIsAcademic = $true;
                }
                else
                {
                    $rosettaPerson.EmploymentIsAcademic = $false;
                }
               
            }#End of Academic Status

            #Retrieve Academic Senate Status
            if($null -ne $data.employment_status.PSObject.Properties['is_academic_senate'] -and $null -ne $data.employment_status.is_academic_senate)
            {

                if($data.employment_status.is_academic_senate.ToString().ToUpper() -eq "Y")
                {
                    $rosettaPerson.EmploymentIsAcademicSenate = $true;
                }
                else
                {
                    $rosettaPerson.EmploymentIsAcademicSenate = $false;
                }
               
            }#End of Academic Senate Status

            #Retrieve Academic Federation Status
            if($null -ne $data.employment_status.PSObject.Properties['is_academic_federation'] -and $null -ne $data.employment_status.is_academic_federation)
            {

                if($data.employment_status.is_academic_federation.ToString().ToUpper() -eq "Y")
                {
                    $rosettaPerson.EmploymentIsAcademicFederation = $true;
                }
                else
                {
                    $rosettaPerson.EmploymentIsAcademicFederation = $false;
                }
               
            }#End of Academic Federation Status

            #Retrieve Faculty Status
            if($null -ne $data.employment_status.PSObject.Properties['is_faculty'] -and $null -ne $data.employment_status.is_faculty)
            {

                if($data.employment_status.is_faculty.ToString().ToUpper() -eq "Y")
                {
                    $rosettaPerson.EmploymentIsFaculty = $true;
                }
                else
                {
                    $rosettaPerson.EmploymentIsFaculty = $false;
                }
               
            }#End of Faculty Status

            #Retrieve Teaching Faculty Status
            if($null -ne $data.employment_status.PSObject.Properties['is_teaching_faculty'] -and $null -ne $data.employment_status.is_teaching_faculty)
            {

                if($data.employment_status.is_teaching_faculty.ToString().ToUpper() -eq "Y")
                {
                    $rosettaPerson.EmploymentIsTeachingFaculty = $true;
                }
                else
                {
                    $rosettaPerson.EmploymentIsTeachingFaculty = $false;
                }
               
            }#End of Teaching Faculty Status

            #Retrieve Ladder Rank Status
            if($null -ne $data.employment_status.PSObject.Properties['is_ladder_rank'] -and $null -ne $data.employment_status.is_ladder_rank)
            {

                if($data.employment_status.is_ladder_rank.ToString().ToUpper() -eq "Y")
                {
                    $rosettaPerson.EmploymentIsLadderRank = $true;
                }
                else
                {
                    $rosettaPerson.EmploymentIsLadderRank = $false;
                }
               
            }#End of Ladder Rank Status

            #Retrieve Without Salary Status
            if($null -ne $data.employment_status.PSObject.Properties['is_without_salary'] -and $null -ne $data.employment_status.is_without_salary)
            {

                if($data.employment_status.is_without_salary.ToString().ToUpper() -eq "Y")
                {
                    $rosettaPerson.EmploymentIsWithoutSalary = $true;
                }
                else
                {
                    $rosettaPerson.EmploymentIsWithoutSalary = $false;
                }
               
            }#End of Without Salary Status

            #Retrieve MSP Status
            if($null -ne $data.employment_status.PSObject.Properties['is_msp'] -and $null -ne $data.employment_status.is_msp)
            {

                if($data.employment_status.is_msp.ToString().ToUpper() -eq "Y")
                {
                    $rosettaPerson.EmploymentIsMSP = $true;
                }
                else
                {
                    $rosettaPerson.EmploymentIsMSP = $false;
                }
               
            }#End of MSP Status

            #Retrieve SSP Status
            if($null -ne $data.employment_status.PSObject.Properties['is_ssp'] -and $null -ne $data.employment_status.is_ssp)
            {

                if($data.employment_status.is_ssp.ToString().ToUpper() -eq "Y")
                {
                    $rosettaPerson.EmploymentIsSSP = $true;
                }
                else
                {
                    $rosettaPerson.EmploymentIsSSP = $false;
                }
               
            }#End of SSP Status

            #Retrieve Manager Status
            if($null -ne $data.employment_status.PSObject.Properties['is_manager'] -and $null -ne $data.employment_status.is_manager)
            {

                if($data.employment_status.is_manager.ToString().ToUpper() -eq "Y")
                {
                    $rosettaPerson.EmploymentIsManager = $true;
                }
                else
                {
                    $rosettaPerson.EmploymentIsManager = $false;
                }
               
            }#End of Manager Status

            #Retrieve Campus Employee Status
            if($null -ne $data.employment_status.PSObject.Properties['is_campus_employee'] -and $null -ne $data.employment_status.is_campus_employee)
            {

                if($data.employment_status.is_campus_employee.ToString().ToUpper() -eq "Y")
                {
                    $rosettaPerson.EmploymentIsCampusEmployee = $true;
                }
                else
                {
                    $rosettaPerson.EmploymentIsCampusEmployee = $false;
                }
               
            }#End of Campus Employee Status

            #Retrieve Health Employee Status
            if($null -ne $data.employment_status.PSObject.Properties['is_health_employee'] -and $null -ne $data.employment_status.is_health_employee)
            {

                if($data.employment_status.is_health_employee.ToString().ToUpper() -eq "Y")
                {
                    $rosettaPerson.EmploymentIsHealthEmployee = $true;
                }
                else
                {
                    $rosettaPerson.EmploymentIsHealthEmployee = $false;
                }
               
            }#End of Health Employee Status


        }#End of Employment Status Node

        #Check for Employee Associations to Parse
        if($null -ne $data.PSObject.Properties['employee_association'] -and $null -ne $data.employee_association)
        {
            foreach($empAssoc in $data.employee_association)
            {
                #Parse Json Data for Employee Association
                $parsedEmpAssoc = $this.ParseRosettaEmployeeAssocData($empAssoc);

                #Fill in IAM ID for People Payroll Associations
                if([string]::IsNullOrEmpty($rosettaPerson.IAMID) -eq $false)
                {
                    $parsedEmpAssoc.IAMID = $rosettaPerson.IAMID;
                }

                # Add Employee Association to Member
                $rosettaPerson.EmployeeAssociations.Add($parsedEmpAssoc);
            }
        }

        #Check for Student Associations to Parse
        if($null -ne $data.PSObject.Properties['student_association'] -and $null -ne $data.student_association)
        {   
            foreach($stdntAssoc in $data.student_association)
            {
                #Parse Json Data for Student Association
                $parsedStdntAssoc = $this.ParseRosettaStudentAssocData($stdntAssoc);

                #Fill in IAM ID, Student ID, and PIDM for People Student Associations
                if([string]::IsNullOrEmpty($rosettaPerson.IAMID) -eq $false)
                {
                    $parsedStdntAssoc.IAMID = $rosettaPerson.IAMID;
                    $parsedStdntAssoc.StudentID = $rosettaPerson.StudentID;
                    $parsedStdntAssoc.PIDM = $rosettaPerson.PIDM;
                }

                # Add Student Association to Member
                $rosettaPerson.StudentAssociations.Add($parsedStdntAssoc);
            }

        }

        return $rosettaPerson
    }


    ############################################
    # Rosetta API Call Functions
    ############################################

    # Check OAuth Token
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
                $this.ErrorCount++
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
            else
            {
                $this.ErrorCount++
            }
            
        }
        else
        {
            $this.ErrorCount++    
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
            else
            {
                $this.ErrorCount++
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
                    $this.ErrorCount++
                }

            }
            else
            {
                $bRetrMoreSrchRslts = $false;
                $this.ErrorCount++
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
                    $this.ErrorCount++
                }

            }
            else
            {
                $bRetrMoreSrchRslts = $false;
                $this.ErrorCount++
            }

        }
        while($bRetrMoreSrchRslts -eq $true)

        return $stdntAssocs

    }

    # Get Rosetta People by Search Term
    [System.Collections.Generic.List[RosettaPerson]] GetRosettaPeopleBySearchTerm([string]$searchBy,[string]$searchTerm)
    {

        #Var for Return List Type
        $people = [System.Collections.Generic.List[RosettaPerson]]::new();

        #Var for Search Result Limit
        [int]$nSrchRsltLimit = 400;

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
                $peopleURI = $this.BaseURL + "people?" + $searchBy + "=" + $searchTerm + "&offset=" + $nSrchRlstOffset.ToString() + "&limit=" + $nSrchRsltLimit.ToString() + "&count=true"; 

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

                            #Go Through Returned Data and Parse It Before Adding to Returned List
                            foreach($ucdPerson in $responseData)
                            {
                                $people.Add($this.ParseRosettaPersonData($ucdPerson));
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
                    $this.ErrorCount++
                }

            }
            else
            {
                $bRetrMoreSrchRslts = $false;
                $this.ErrorCount++
            }

        }
        while($bRetrMoreSrchRslts -eq $true)

        return $people

    }

    #Post Mass Lookup for Rosetta Members by UCD IDs
    [System.Collections.Generic.List[RosettaPerson]] PostMassRosettaPeopleLookup([string]$lookupBy,[System.Collections.Generic.HashSet[string]]$setMPL)
    {

        #Var for Return List Type
        $people = [System.Collections.Generic.List[RosettaPerson]]::new();

        #Var for Custom Multi People Lookup Post Body
        $mplBody = @{};

        #Dynamically Add Properties
        $mplBody["limit"] = 0;
        $mplBody[$lookupBy] = @();

        #Load MPL Lookup ID Array
        foreach($mplID in $setMPL)
        {
            $mplBody[$lookupBy] += $mplID
        }

        #Set Limit (Adding Extra Just in Case)
        $mplBody["limit"] = [int]::Parse($setMPL.Count) + 10;

        #Convert Post Body to Json Object
        $jsonPostBody = $mplBody | ConvertTo-Json 

        #Check OAuth Token
        if($this.ChechOAuthToken() -eq $true)
        {
            #Var for Header of Endpoint Call
            $headersEPCall = @{"Authorization"="Bearer " + $this.OAuthToken};

            #Var for Returned Status Code
            [int]$statusCode = 0;

            #Var for URI
            $peopleURI = $this.BaseURL + "people"

            #Make Rest Call to EndPoint
            $responseData = Invoke-RestMethod -Uri $peopleURI -Method POST -Headers $headersEPCall -StatusCodeVariable statusCode -Body $jsonPostBody -ContentType "application/json" -TimeoutSec 240;

            #Check Returned Status Code
            if($statusCode -eq 200)
            {

                #Go Through Returned Data and Parse It Before Adding to Returned List
                foreach($ucdPerson in $responseData)
                {
                    $people.Add($this.ParseRosettaPersonData($ucdPerson));
                }

            }
            else
            {
                $this.ErrorCount++
            }#End of Status Code Check

        }
        else
        {
            $this.ErrorCount++
        }#End of OAuth Token Check

        return $people
    }

    ##############
    # Extras
    ##############   

    #Notification Message
    #Write-Verbose "Hope this works!" -Verbose
    #Write-Verbose "Made it here!" -Verbose

    ################

}






