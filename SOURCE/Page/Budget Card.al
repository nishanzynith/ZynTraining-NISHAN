page 50120 "Zyn_Budget card Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Zyn_Budget Entry";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(fromdate; Rec.fromdate) { }

                field(Enddate; Rec.Enddate) { }

                field("Expense Category"; Rec."Expense Category") { }

                field(Amount; Rec.Amount) { }

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

        budget: Record "Zyn_Budget Entry";

    //     trigger OnOpenPage()
    //       begin
    //     if budget.fromdate = 0D then 
    //          budget.fromdate := CalcDate('<-CM>',workdate());

    //     if budget.Enddate = 0D then
    //         budget.Enddate := CalcDate('<CM>',WorkDate()); 

    //     budget.
    // end;
}