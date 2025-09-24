page 50132 "Zyn_Recurring Expense"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Zyn_Recurring Expense";
    CardPageId = "Zyn_Recurring Card";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(ID; Rec.ID) { Caption = 'ID'; }
                field(Category; Rec.Category)
                {
                    Caption = 'Category';
                    TableRelation = "Zyn_Expense Category".Code;
                }

                field(Amount; rec.Amount)
                {
                    Caption = 'Amount';
                }

                field("Start Date"; Rec."Start Date") { }
                field("Cycling Period"; Rec."Cycling Period") { }
                field("Next Cycle Date"; Rec."Next Cycle Date") { }
            }
        }
        area(Factboxes)
        {

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
}