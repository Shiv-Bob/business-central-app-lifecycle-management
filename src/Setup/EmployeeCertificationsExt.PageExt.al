pageextension 50100 "Employee Card Cert Ext" extends "Employee Card"
{
    layout
    {
        addafter(General)
        {
            part(Certifications; "Employee Certifications SubP")
            {
                ApplicationArea = All;
                Caption = 'Certifications';
                SubPageLink = "Employee No." = field("No.");
            }
        }
    }
}