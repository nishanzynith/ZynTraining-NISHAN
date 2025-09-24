page 50152 "Expense List"
{
    PageType = List;
    SourceTable = "Expense Entry";
    Caption = 'Expense List';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Expense Entry Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; rec."No.") { }
                field(Date; rec.Date) { }
                field(Amount; rec.Amount) { }
                field(Category; rec.Category) { }
                field(Description; rec.Description) { }
            }
        }

        area(FactBoxes)
        {
            part(budgetfactbox; "Budget Factbox")
            {
                // SubPageLink = "Expense Category" = FIELD(Category);
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Categories")
            {
                Caption = 'Categories';
                ApplicationArea = All;
                Image = List;
                RunObject = Page "Expense Category List";
                trigger OnAction()
                begin
                end;
            }

            action(GenerateExpenseReport)
            {
                Caption = 'Generate Expense Report';
                ApplicationArea = All;
                Image = Export;

                trigger OnAction()
                var
                    ExpenseReport: Report "Zyn_Expense Tracker Report";
                begin
                    ExpenseReport.Run();
                end;
            }
        }
    }
}
