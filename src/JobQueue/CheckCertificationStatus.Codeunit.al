codeunit 50105 "Check Certification Status"
{
    trigger OnRun()
    var
        EmployeeCertificationRec: Record "Employee Certification";
        TelemetryHelper: Codeunit "Telemetry Helper";
        ExpiringCount: Integer;
    begin
        if EmployeeCertificationRec.FindSet(true) then
            repeat
                EmployeeCertificationRec.UpdateStatus();
                if EmployeeCertificationRec.Status = EmployeeCertificationRec.Status::"Expiring Soon" then
                    ExpiringCount += 1;
            until EmployeeCertificationRec.Next() = 0;

        if ExpiringCount > 0 then
            TelemetryHelper.LogExpiringCertificationsFound(ExpiringCount);
    end;
}