codeunit 50108 "Demo Data Setup"
{
    procedure CreateSampleCertifications()
    var
        Employee: Record Employee;
        EmployeeCertification: Record "Employee Certification";
        SampleCount: Integer;
    begin
        if Employee.FindSet() then
            repeat
                if SampleCount < 5 then begin
                    EmployeeCertification.Init();
                    EmployeeCertification."Employee No." := Employee."No.";
                    EmployeeCertification."Certification Name" := 'Workplace Safety Training';
                    EmployeeCertification."Issue Date" := CalcDate('<-1Y>', Today());
                    EmployeeCertification."Expiry Date" := CalcDate('<+15D>', Today());
                    EmployeeCertification.Insert(true);
                    EmployeeCertification.UpdateStatus();
                    SampleCount += 1;
                end;
            until (Employee.Next() = 0) or (SampleCount >= 5);
    end;
}