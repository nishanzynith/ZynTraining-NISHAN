page 50174 ExpenseClaimlist
{
    Caption = 'Expense Claim List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ExpenseClaimTable;
    CardPageId = Expenseclaimcard;
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                Editable = false;
                field(ClaimID;Rec.ClaimID){}
                field(employeeID;Rec.employeeID){}
                field(Category;Rec.Category){}
                field(Subtype;Rec.Subtype){}
                field(claimdate;Rec.claimdate){}
                field(Amount;Rec.Amount){}
                field(Filename;Rec.Filename){}
                field(Status;Rec.Status){}
                
            }
        }
    }
}