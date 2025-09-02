pageextension 50135 Salesinvoiceposting extends "Sales Invoice list"
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
                    Report.Run(report::"Invoice report")
                end;

            }
        }
    }

    var
        myInt: Integer;
}