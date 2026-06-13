codeunit 50103 "Telemetry Helper"
{
    procedure LogInstallCompleted(AppVersion: Text)
    var
        CustomDimensions: Dictionary of [Text, Text];
    begin
        CustomDimensions.Add('AppVersion', AppVersion);
        Session.LogMessage('CERT0001', 'Certification Tracker installed', Verbosity::Normal,
            DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, CustomDimensions);
    end;

    procedure LogUpgradeCompleted(AppVersion: Text)
    var
        CustomDimensions: Dictionary of [Text, Text];
    begin
        CustomDimensions.Add('AppVersion', AppVersion);
        Session.LogMessage('CERT0002', 'Certification Tracker upgraded', Verbosity::Normal,
            DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, CustomDimensions);
    end;

    procedure LogExpiringCertificationsFound(CountFound: Integer)
    var
        CustomDimensions: Dictionary of [Text, Text];
    begin
        CustomDimensions.Add('Count', Format(CountFound));
        Session.LogMessage('CERT0003', 'Expiring certifications detected', Verbosity::Normal,
            DataClassification::CustomerContent, TelemetryScope::ExtensionPublisher, CustomDimensions);
    end;
}