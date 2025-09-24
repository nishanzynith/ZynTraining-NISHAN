page 50121 "Zyn_Budget Factbox"
{
    PageType = ListPart;
    SourceTable = "Zyn_Budget Entry";
    Caption = 'Budget Factbox';

    layout
    {
        area(Content)
        {
            repeater("Budget")
            {
                // Visible = HasContent;
                field(fromdate; Rec.fromdate)
                {
                    ApplicationArea = All;
                    Caption = 'From Date';

                }

                field(Enddate; Rec.Enddate)
                {
                    ApplicationArea = All;
                    Caption = 'End Date';

                }
                field("Expense Category"; Rec."Expense Category")
                {
                    ApplicationArea = All;
                    Caption = 'Category';

                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Amount';

                }
            }

        }
    }

    trigger OnOpenPage()
    var
        StartDate: Date;
        EndDate: Date;
    begin

        StartDate := CalcDate('<-CM>', WorkDate());
        EndDate := CALCDATE('<CM>', StartDate);

        Rec.SetRange(fromdate, StartDate, EndDate);

    end;
}
