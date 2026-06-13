page 50100 "Employee Certifications SubP"
{
    PageType = ListPart;
    SourceTable = "Employee Certification";
    Caption = 'Certifications';
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Certification Name"; Rec."Certification Name")
                {
                    ApplicationArea = All;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ApplicationArea = All;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.UpdateStatus();
                    end;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    StyleExpr = StatusStyle;
                }
            }
        }
    }

    var
        StatusStyle: Text;

    trigger OnAfterGetRecord()
    begin
        case Rec.Status of
            Rec.Status::Expired:
                StatusStyle := 'Unfavorable';
            Rec.Status::"Expiring Soon":
                StatusStyle := 'Ambiguous';
            else
                StatusStyle := 'Favorable';
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Employee No." := Rec.GetRangeMax("Employee No.");
    end;
}