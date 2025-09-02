page 50113 "Customer Sales Credit Memos"
{
    PageType = ListPart;
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type" = const("Credit Memo"));
    ApplicationArea = All;
    Caption = 'Sales Credit Memos';
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        sales: page "Sales Credit Memo";
                    begin
                        Sales.SetRecord(Rec);
                        Sales.Run();
                    end;

                }
                field("Posting Date"; rec."Posting Date") { ApplicationArea = All; }
                field(Amount; rec.Amount) { ApplicationArea = All; }
            }
        }
    }
}
