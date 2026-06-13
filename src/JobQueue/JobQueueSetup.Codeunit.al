codeunit 50104 "Job Queue Setup"
{
    procedure ScheduleCertificationStatusCheck()
    var
        JobQueueEntryRec: Record "Job Queue Entry";
    begin
        JobQueueEntryRec.SetRange("Object Type to Run", JobQueueEntryRec."Object Type to Run"::Codeunit);
        JobQueueEntryRec.SetRange("Object ID to Run", Codeunit::"Check Certification Status");
        if not JobQueueEntryRec.IsEmpty() then
            exit;

        JobQueueEntryRec.Init();
        JobQueueEntryRec."Object Type to Run" := JobQueueEntryRec."Object Type to Run"::Codeunit;
        JobQueueEntryRec."Object ID to Run" := Codeunit::"Check Certification Status";
        JobQueueEntryRec.Description := 'Daily check for expiring employee certifications';
        JobQueueEntryRec."Job Queue Category Code" := 'CERT';
        JobQueueEntryRec."Recurring Job" := true;
        JobQueueEntryRec."No. of Minutes between Runs" := 1440;
        JobQueueEntryRec."Starting Time" := 060000T;
        JobQueueEntryRec.Status := JobQueueEntryRec.Status::Ready;
        JobQueueEntryRec.Insert(true);
    end;
}