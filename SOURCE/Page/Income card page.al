page 50144 "Income Card"
{
    PageType = Card;
    SourceTable = "Income Entry";
    Caption = 'Income Card';
    ApplicationArea = All;
    UsageCategory = Tasks;
    Editable = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Entry No."; rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date"; rec."Date")
                {
                    ApplicationArea = All;
                }
                field("Category"; rec."Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Select an income category. You can manage categories from the Income List actions.';
                }
                field("Description"; rec."Description")
                {
                    ApplicationArea = All;
                }
                field("Amount"; rec."Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(OpenCategory)
            {
                ApplicationArea = All;
                Caption = 'Open Category';
                Image = Category;
                trigger OnAction()
                var
                    CatRec: Record "Income Category";
                begin
                    // if rec."Category" <> '' then
                    //     if CatRec.Get(rec."Category") then
                    //         CurrPage.RunModal Page::"Income Category List" // user can edit categories here
                    //     else
                    //         Message('Category %1 not found.', "Category")
                    // else
                        Page.Run(Page::"Income Category List");
                end;
            }
        }
    }
}
