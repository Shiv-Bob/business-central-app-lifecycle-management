table 50101 "Employee Certification"
{
    DataClassification = CustomerContent;
    Caption = 'Employee Certification';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee."No.";
        }
        field(3; "Certification Name"; Text[100])
        {
            Caption = 'Certification Name';
        }
        field(4; "Issue Date"; Date)
        {
            Caption = 'Issue Date';
        }
        field(5; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
        }
        field(6; "Status"; Enum "Certification Status")
        {
            Caption = 'Status';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(EmployeeKey; "Employee No.", "Certification Name")
        { }
    }

    procedure UpdateStatus()
    var
        DaysToExpiry: Integer;
    begin
        DaysToExpiry := "Expiry Date" - Today();

        case true of
            "Expiry Date" = 0D:
                exit;
            DaysToExpiry < 0:
                Status := Status::Expired;
            DaysToExpiry <= 30:
                Status := Status::"Expiring Soon";
            else
                Status := Status::Active;
        end;

        Modify();
    end;
}