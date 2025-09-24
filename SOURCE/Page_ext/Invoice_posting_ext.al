pageextension 50135 "Zyn_Sales Invoice List Ext" extends "Sales Invoice list"
{
    // layout
    // {
    //     // Add changes to page layout here
    // }

    actions
    {
        addlast(processing)
        {
            action("Bulk Posting")
            {
                Caption = 'Bulk Posting';
                Image = PostBatch;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Report.Run(report::"Zyn_Sales Invoice Report")
                end;

            }
        }
    }

    var
        myInt: Integer;
}