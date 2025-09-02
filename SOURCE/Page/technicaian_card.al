page 50117 "Technician Card"
{
    PageType = Card;
    SourceTable = Technician_table;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Technician ID"; rec."Tech ID")
                { }
                field("Name"; rec."Tech Name")
                { }
                field("Ph. No."; rec."Phone Number")
                { }
                field("Department"; Rec.department)
                { 
                    
                }
            }
        }
    }

    //     trigger OnNewRecord(BelowxRec: Boolean)
    //     var
    //         IDGen: Codeunit "Technician ID Generator";
    //     begin
    //         Rec."Tech ID" := IDGen.GetNextTechnicianID();
    //     end;
}
