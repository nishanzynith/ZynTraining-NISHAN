page 50133 "Recurring Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Recurring Expense";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(ID; Rec.ID) { Editable = false; }
                field(Category; Rec.Category) { TableRelation = "Expense Category".code;}
                field(Amount; Rec.Amount) { }
                field("Start Date"; Rec."Start Date") { }
                field("Cycling Period"; Rec."Cycling Period") { }
                field("Next Cycle Date"; Rec."Next Cycle Date") { }



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