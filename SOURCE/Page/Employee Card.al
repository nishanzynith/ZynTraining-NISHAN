page 50141 "Zyn_Employee Card Page"
{
    PageType = Card;
    ApplicationArea = All;
    caption = 'Employee card page';
    UsageCategory = Administration;
    SourceTable = "Zyn_Employee Table";

    layout
    {
        area(Content)
        {
            group("Employee Details")
            {
                field("Emp ID"; Rec."Emp ID")
                {
                    Caption = 'Employee ID';
                }
                field("Employee Name"; Rec."Employee Name") { }
                field(Department; Rec.Department) { }
                field(Role; Rec.Role) { }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}