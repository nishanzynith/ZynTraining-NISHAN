page 50114 "Customer Sales Invoices"
{
    PageType = ListPart;
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type" = const(Invoice));
    ApplicationArea = All;
    Caption = 'Sales Invoices';
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
                        sales: page "Sales Invoice";
                    begin
                            Sales.SetRecord(Rec);
                            Sales.Run();
                    end;
                }
                field("Posting Date"; Rec."Posting Date") { ApplicationArea = All; }
                field(Amount; Rec.Amount) { ApplicationArea = All; }
            }
        }
    }

    var
        selected: Integer;
}
