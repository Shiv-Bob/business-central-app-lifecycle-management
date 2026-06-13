table 50102 "Certification Setup"
{
    Caption = 'Certification Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Expiry Warning Days"; Integer)
        {
            Caption = 'Expiry Warning Days';
            InitValue = 30;
        }
        field(3; "Notifications Enabled"; Boolean)
        {
            Caption = 'Notifications Enabled';
        }
        field(4; "App Version Installed"; Text[20])
        {
            Caption = 'App Version Installed';
            Editable = false;
        }
        field(5; "Initial Setup Done"; Boolean)
        {
            Caption = 'Initial Setup Done';
        }
        field(6; "Email Notifications Enabled"; Boolean)
        {
            Caption = 'Email Notifications Enabled';
            InitValue = false;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    procedure GetSetup(): Record "Certification Setup"
    var
        CertificationSetupRec: Record "Certification Setup";
    begin
        if not CertificationSetupRec.Get() then begin
            CertificationSetupRec.Init();
            CertificationSetupRec.Insert();
        end;
        exit(CertificationSetupRec);
    end;
}