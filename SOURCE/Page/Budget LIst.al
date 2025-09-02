page 50118 "Budget List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Budgetentry;
    CardPageId = "Budget card";
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(fromdate;Rec.fromdate)
                {
                    
                }
                
                field(Enddate;Rec.Enddate){}

                field("Expense Category";Rec."Expense Category"){}

                field(Amount;Rec.Amount){}

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