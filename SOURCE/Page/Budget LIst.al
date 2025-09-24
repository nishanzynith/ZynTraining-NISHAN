page 50118 "Zyn_Budget List Page"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Zyn_Budget Entry";
    CardPageId = "Zyn_Budget card Page";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(fromdate; Rec.fromdate)
                {

                }

                field(Enddate; Rec.Enddate) { }

                field("Expense Category"; Rec."Expense Category") { }

                field(Amount; Rec.Amount) { }

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