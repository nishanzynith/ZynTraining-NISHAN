page 50153 "Zyn_Expense Category List Page"
{
    PageType = List;
    SourceTable = "Zyn_Expense Category";
    Caption = 'Expense Category List';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; rec.Code) { }
                field(Description; rec.Description) { }
            }
        }


        area(FactBoxes)
        {
            part(ExpenseFactbox; "Zyn_Expense & Budget Factbox")
            {
                SubPageLink = "Code" = FIELD("Code");
                ApplicationArea = All;
            }
        }

    }
}

