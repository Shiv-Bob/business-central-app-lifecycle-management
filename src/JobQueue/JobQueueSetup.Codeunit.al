codeunit 50104 "Job Queue Setup"
{
    procedure ScheduleCertificationStatusCheck()
    var
        JobQueueEntry: Record "Job Queue Entry";
    begin
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        JobQueueEntry.SetRange("Object ID to Run", Codeunit::"Check Certification Status");
        if not JobQueueEntry.IsEmpty() then
            exit;

        JobQueueEntry.Init();
        JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
        JobQueueEntry."Object ID to Run" := Codeunit::"Check Certification Status";
        JobQueueEntry.Description := 'Daily check for expiring employee certifications';
        JobQueueEntry."Job Queue Category Code" := 'CERT';
        JobQueueEntry."Recurring Job" := true;
        JobQueueEntry."No. of Minutes between Runs" := 1440;
        JobQueueEntry."Starting Time" := 060000T;
        JobQueueEntry.Status := JobQueueEntry.Status::Ready;
        JobQueueEntry.Insert(true);
    end;
}