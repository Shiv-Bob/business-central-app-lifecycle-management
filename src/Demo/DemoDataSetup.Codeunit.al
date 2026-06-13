codeunit 50108 "Demo Data Setup"
{
    procedure CreateSampleCertifications()
    var
        EmployeeRec: Record Employee;
        EmployeeCertificationRec: Record "Employee Certification";
        SampleCount: Integer;
    begin
        if EmployeeRec.FindSet() then
            repeat
                if SampleCount < 5 then begin
                    EmployeeCertificationRec.Init();
                    EmployeeCertificationRec."Employee No." := EmployeeRec."No.";
                    EmployeeCertificationRec."Certification Name" := 'Workplace Safety Training';
                    EmployeeCertificationRec."Issue Date" := CalcDate('<-1Y>', Today());
                    EmployeeCertificationRec."Expiry Date" := CalcDate('<+15D>', Today());
                    EmployeeCertificationRec.Insert(true);
                    EmployeeCertificationRec.UpdateStatus();
                    SampleCount += 1;
                end;
            until (EmployeeRec.Next() = 0) or (SampleCount >= 5);
    end;
}