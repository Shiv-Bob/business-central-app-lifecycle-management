codeunit 50107 "Certification Notifier"
{
    procedure NotifyIfEnabled(EmployeeCertification: Record "Employee Certification")
    var
        CertificationSetupRec: Record "Certification Setup";
        EmployeeRec: Record Employee;
    begin
        CertificationSetupRec := CertificationSetupRec.GetSetup();

        // Custom feature flag pattern: a boolean on our own setup table,
        // toggled by the admin from our own setup page. This achieves the
        // same "off by default, opt-in later" goal without relying on
        // Microsoft's internal Feature Management page.
        if not CertificationSetupRec."Email Notifications Enabled" then
            exit;

        if EmployeeCertification.Status <> EmployeeCertification.Status::"Expiring Soon" then
            exit;

        if not EmployeeRec.Get(EmployeeCertification."Employee No.") then
            exit;

        Message('Notification: %1''s certification "%2" expires on %3',
            EmployeeRec.FullName(), EmployeeCertification."Certification Name", EmployeeCertification."Expiry Date");
    end;
}