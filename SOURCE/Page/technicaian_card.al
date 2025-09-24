page 50117 "Zyn_Technician Card"
{
    PageType = Card;
    SourceTable = "Zyn_Technician Table";
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
