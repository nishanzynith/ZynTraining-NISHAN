page 50155 "Expense Entry Card"
{
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = "Expense Entry";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Entry ID"; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Entry ID';
                }

                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                }

                field("Amount"; Rec.Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Amount';
                }

                field("Category"; Rec.Category)
                {
                    ApplicationArea = All;
                    Caption = 'Category';
                    TableRelation = "Expense Category".Code;
                    ToolTip = 'Select the category for this expense';
                }

                field(Remaining;Rec.Remaining)
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Date"; Rec.Date)
                {
                    ApplicationArea = All;
                    Caption = 'Date';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(OpenCategoryList)
            {
                Caption = 'Manage Categories';
                ApplicationArea = All;
                Image = Category;

                trigger OnAction()
                begin
                    Page.Run(Page::"Expense Category List");
                end;
            }
        }
    }
}
