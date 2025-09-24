page 50174 "Zyn_Expense Claim List"
{
    Caption = 'Expense Claim List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Zyn_Expense Claim Table";
    CardPageId = "Zyn_Expense Claim Card";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                Editable = false;
                field(ClaimID; Rec.ClaimID) { }
                field(employeeID; Rec.employeeID) { }
                field(Category; Rec.Category) { }
                field(Subtype; Rec.Subtype) { }
                field(claimdate; Rec.claimdate) { }
                field(Amount; Rec.Amount) { }
                field(Filename; Rec.Filename) { }
                field(Status; Rec.Status) { }

            }
        }
    }
}