codeunit 50100 "Install Management"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        Setup: Record "Certification Setup";
        AppInfo: ModuleInfo;
        DemoDataSetup: Codeunit "Demo Data Setup";
        TelemetryHelper: Codeunit "Telemetry Helper";
    begin
        Setup := Setup.GetSetup();

        NavApp.GetCurrentModuleInfo(AppInfo);
        Setup."App Version Installed" := Format(AppInfo.AppVersion);
        Setup."Notifications Enabled" := true;
        Setup."Initial Setup Done" := true;
        Setup.Modify();

        if GuiAllowed() then
            DemoDataSetup.CreateSampleCertifications();

        TelemetryHelper.LogInstallCompleted(Format(AppInfo.AppVersion));
    end;
}