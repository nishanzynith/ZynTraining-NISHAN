page 50176 ExpenseClaimCat
{
    Caption = 'Expense Calim Category';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Expenseclaimcat;
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Catcode;Rec.Catcode){}
                field(Name;Rec.Name){}
                field(Description;Rec.Description){}
                field(Subtype;Rec.Subtype){}
                field(Limit;Rec.Limit){}
            }
        }
    }
}