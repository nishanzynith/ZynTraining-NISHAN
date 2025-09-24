page 50106 "Zyn_Technician Problems"
{
    PageType = ListPart;
    SourceTable = "Zyn_Customer Problem";
    ApplicationArea = All;
    Caption = 'Assigned Problems';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No."; Rec."Customer No.") { ApplicationArea = All; }
                field("customer Name"; rec."customer Name") { }
                field(Problem; rec.Problem) { ApplicationArea = All; }
                field("Problem Description"; rec."Problem Description") { ApplicationArea = All; }
                field("Report Date"; rec."Report Date") { ApplicationArea = All; }
            }
        }
    }
}