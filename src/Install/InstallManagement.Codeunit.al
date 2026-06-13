codeunit 50100 "Install Management"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        CertificationSetupRec: Record "Certification Setup";
        AppInfo: ModuleInfo;
        DemoDataSetup: Codeunit "Demo Data Setup";
        TelemetryHelper: Codeunit "Telemetry Helper";
    begin
        CertificationSetupRec := CertificationSetupRec.GetSetup();

        NavApp.GetCurrentModuleInfo(AppInfo);
        CertificationSetupRec."App Version Installed" := Format(AppInfo.AppVersion);
        CertificationSetupRec."Notifications Enabled" := true;
        CertificationSetupRec."Initial Setup Done" := true;
        CertificationSetupRec.Modify();

        if GuiAllowed() then
            DemoDataSetup.CreateSampleCertifications();

        TelemetryHelper.LogInstallCompleted(Format(AppInfo.AppVersion));
    end;
}