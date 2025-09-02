page 50120 "Budget card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Budgetentry;
    
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(fromdate;Rec.fromdate){}

                field(Enddate;Rec.Enddate){}

                field("Expense Category";Rec."Expense Category"){}

                field(Amount;Rec.Amount){}

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

        budget : Record Budgetentry;

    //     trigger OnOpenPage()
    //       begin
    //     if budget.fromdate = 0D then 
    //          budget.fromdate := CalcDate('<-CM>',workdate());
        
    //     if budget.Enddate = 0D then
    //         budget.Enddate := CalcDate('<CM>',WorkDate()); 

    //     budget.
    // end;
}