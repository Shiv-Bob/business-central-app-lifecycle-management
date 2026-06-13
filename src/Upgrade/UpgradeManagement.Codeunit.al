codeunit 50102 "Upgrade Management"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    var
        UpgradeTags: Codeunit "Upgrade Tags";
        UpgradeTag: Codeunit "Upgrade Tag";
        TelemetryHelper: Codeunit "Telemetry Helper";
        AppInfo: ModuleInfo;
    begin
        if not UpgradeTag.HasUpgradeTag(UpgradeTags.GetRecalculateAllStatusesTag()) then
            RecalculateAllCertificationStatuses();

        NavApp.GetCurrentModuleInfo(AppInfo);
        TelemetryHelper.LogUpgradeCompleted(Format(AppInfo.AppVersion));
    end;

    trigger OnValidateUpgradePerCompany()
    var
        UpgradeTags: Codeunit "Upgrade Tags";
        UpgradeTag: Codeunit "Upgrade Tag";
        Tag: Code[250];
    begin
        foreach Tag in UpgradeTags.GetAllUpgradeTags() do
            if not UpgradeTag.HasUpgradeTag(Tag) then
                Error('Upgrade tag %1 was not applied.', Tag);
    end;

    local procedure RecalculateAllCertificationStatuses()
    var
        EmployeeCertification: Record "Employee Certification";
        UpgradeTags: Codeunit "Upgrade Tags";
        UpgradeTag: Codeunit "Upgrade Tag";
    begin
        // Example: a new "Status" field was introduced in a previous version
        // and existing records need their status calculated for the first time.
        if EmployeeCertification.FindSet(true) then
            repeat
                EmployeeCertification.UpdateStatus();
            until EmployeeCertification.Next() = 0;

        UpgradeTag.SetUpgradeTag(UpgradeTags.GetRecalculateAllStatusesTag());
    end;
}