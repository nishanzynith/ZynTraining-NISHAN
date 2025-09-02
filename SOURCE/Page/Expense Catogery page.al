page 50153 "Expense Category List"
{
    PageType = List;
    SourceTable = "Expense Category";
    Caption = 'Expense Category List';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; rec.Code){}
                field(Description; rec.Description){}
            }
        }
    

        area(FactBoxes)
        {
            part(ExpenseFactbox; "Expense & Budget Factbox")
            {
                SubPageLink = "Code" = FIELD("Code");
                ApplicationArea = All;
            }
        }
        
    }
}

