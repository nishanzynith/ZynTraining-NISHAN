page 50152 "Zyn_Expense List"
{
    PageType = List;
    SourceTable = "Expense Entry";
    Caption = 'Expense List';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Zyn_Expense Entry Card Page";

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
            part(budgetfactbox; "Zyn_Budget Factbox")
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
                RunObject = Page "Zyn_Expense Category List Page";
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
