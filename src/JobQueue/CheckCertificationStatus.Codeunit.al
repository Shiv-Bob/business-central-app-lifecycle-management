codeunit 50105 "Check Certification Status"
{
    trigger OnRun()
    var
        EmployeeCertification: Record "Employee Certification";
        TelemetryHelper: Codeunit "Telemetry Helper";
        ExpiringCount: Integer;
    begin
        if EmployeeCertification.FindSet(true) then
            repeat
                EmployeeCertification.UpdateStatus();
                if EmployeeCertification.Status = EmployeeCertification.Status::"Expiring Soon" then
                    ExpiringCount += 1;
            until EmployeeCertification.Next() = 0;

        if ExpiringCount > 0 then
            TelemetryHelper.LogExpiringCertificationsFound(ExpiringCount);
    end;
}