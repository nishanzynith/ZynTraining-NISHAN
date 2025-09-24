page 50104 "Zyn_Customer Problem Card Page"
{
    PageType = Card;
    SourceTable = "Zyn_Customer Problem";
    ApplicationArea = All;
    Caption = 'Log Problem';

    layout
    {
        area(content)
        {
            group("Customer Problem Details")
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Customer Name"; rec."customer Name")
                {

                }

                field(Problem; Rec.Problem)
                {
                    ApplicationArea = All;
                }

                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.Technician := '';
                    end;
                }

                field(Technician; Rec.Technician)
                {
                    ApplicationArea = All;
                    // trigger OnLookup(var Text: Text): Boolean
                    // var
                    //     TechRec: Record Technician_table;
                    // begin
                    //     // if Rec.Department.AsInteger() <> 0 then
                    //     //     TechRec.SetRange(Department, Rec.Department);

                    //     // if PAGE.RunModal(PAGE::"Technician List", TechRec, select) = Action::LookupOK then begin
                    //     //     rec.Technician := TechRec."Tech ID";
                    //     // end;
                    // end;

                }

                field("Problem Description"; Rec."Problem Description")
                {
                    ApplicationArea = All;
                }

                field("Report Date"; Rec."Report Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        select: Integer;
}
