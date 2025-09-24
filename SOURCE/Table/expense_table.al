table 50151 "Expense Entry"
{
    DataClassification = ToBeClassified;
    Caption = 'Expense Entry';

    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date';
        }

        field(3; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
        }

        field(4; Category; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Category';
            TableRelation = "Expense Category"."Code";
            // trigger OnValidate()
            // var
            //     BudgetEntry: Record "BudgetEntry";
            //     ExpenseRec: Record "Expense Entry";
            //     StartDate: Date;
            //     EndDate: Date;
            //     TotalExpenses: Decimal;
            // begin

            //     StartDate := DMY2DATE(1, DATE2DMY(WorkDate(), 2), DATE2DMY(WorkDate(), 3));
            //     EndDate := CALCDATE('<CM>', StartDate);

            //     ExpenseRec.Reset();
            //     ExpenseRec.SetRange(Category, Category);
            //     ExpenseRec.SetRange("Date", StartDate, EndDate);
            //     if ExpenseRec.FindSet() then
            //         repeat
            //             TotalExpenses += ExpenseRec.Amount;
            //         until ExpenseRec.Next() = 0;


            //     BudgetEntry.Reset();
            //     BudgetEntry.SetRange("Expense Category", Category);
            //     BudgetEntry.SetRange("FromDate", StartDate, EndDate);
            //     if BudgetEntry.FindFirst() then
            //         "Remaining" := BudgetEntry.Amount - TotalExpenses
            //     else
            //         "Remaining" := 0;
            // end;
            trigger OnValidate()
            var
                RemainingCalc: Codeunit "Zyn_Remaining Budget Calc";
            begin
                "Remaining" := RemainingCalc.CalcRemaining(Category);
            end;
        }

        field(5; Description; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(6; "Remaining"; Decimal)
        {
            Editable = false;
        }

    }

    keys
    {
        key(PK; "No.") { Clustered = true; }

        key(key1; date, Category) { }
    }


}
