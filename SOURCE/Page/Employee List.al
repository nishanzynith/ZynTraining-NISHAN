page 50139 "Employee entry List"
{
    PageType = List;
    SourceTable = "Employee Table";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Employees List';
    CardPageId = "Employee Card new";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Emp ID"; Rec."Emp ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }

                field("Department"; Rec."Department")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                }

                field("Role"; Rec."Role")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                }
            }
        }
    }
}
