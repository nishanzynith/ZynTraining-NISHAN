page 50143 "Zyn_Income List"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Income Entry";
    Caption = 'Income List';
    CardPageId = "Zyn_Income Card";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Date"; rec."Date")
                {
                    ApplicationArea = All;
                }
                field("Category"; rec."Category")
                {
                    ApplicationArea = All;
                }
                field("Description"; rec."Description")
                {
                    ApplicationArea = All;
                }
                field("Amount"; rec."Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ManageCategories)
            {
                ApplicationArea = All;
                Caption = 'Income Categories';
                Image = Category;
                RunObject = Page "Zyn_Income Category List";
            }
            action(GenerateIncomeReport)
            {
                Caption = 'Generate Income Report';
                ApplicationArea = All;
                Image = Export;

                trigger OnAction()
                var
                    IncomeReport: Report "Zyn_Income Tracker Report";
                begin
                    IncomeReport.Run();
                end;
            }
        }
    }


    trigger OnOpenPage()
    begin

    end;
}
