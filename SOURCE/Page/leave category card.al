page 50148 "Zyn_Leave Category Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Zyn_Leave Category";

    layout
    {
        area(Content)
        {
            group("Leave Details")
            {
                field("Category Name"; Rec."Category Name") { }
                field(Description; Rec.Description) { }
                field("Number of Days Allowed"; Rec."Number of Days Allowed") { }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}