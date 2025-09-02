page 50111 "Customer Sales Orders"
{
    PageType = ListPart;
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type" = const(Order));
    ApplicationArea = All;
    Caption = 'Sales Orders';
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
                        sales: page "Sales Order";
                    begin
                        Sales.SetRecord(Rec);
                        Sales.Run();
                    end;

                }
                field("Order Date"; Rec."Order Date") { ApplicationArea = All; }
                field(Status; Rec.Status) { ApplicationArea = All; }
            }
        }
    }
}
