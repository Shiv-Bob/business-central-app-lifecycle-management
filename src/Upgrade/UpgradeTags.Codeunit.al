codeunit 50101 "Upgrade Tags"
{
    procedure GetAddStatusFieldTag(): Code[250]
    begin
        exit('CONTOSO-CERT-STATUS-FIELD-20260613');
    end;

    procedure GetRecalculateAllStatusesTag(): Code[250]
    begin
        exit('CONTOSO-CERT-RECALC-STATUSES-20260613');
    end;

    procedure GetAllUpgradeTags(): List of [Code[250]]
    var
        Tags: List of [Code[250]];
    begin
        Tags.Add(GetAddStatusFieldTag());
        Tags.Add(GetRecalculateAllStatusesTag());
        exit(Tags);
    end;
}