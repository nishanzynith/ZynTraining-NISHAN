page 50154 "Zyn_Expense & Budget Factbox"
{
    PageType = CardPart;
    SourceTable = "Zyn_Expense Category";
    ApplicationArea = All;
    Caption = 'Expense and Budget Factbox';

    layout
    {
        area(content)
        {
            cuegroup("Expense Categories")
            {
                Caption = 'Category Totals';

                field(ThisMonthExpense; ThisMonthExpense)
                {
                    ApplicationArea = All;
                    Caption = 'This Month';
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        Expense: Record "Expense Entry";
                        StartDate: Date;
                        EndDate: Date;
                    begin
                        Calculator.GetThisMonthDates(StartDate, EndDate);
                        Expense.SetRange(Category, Rec.Code);
                        Expense.SetRange(Date, StartDate, EndDate);
                        Page.Run(Page::"Zyn_Expense List", Expense);
                    end;
                }

                field(ThisQuarterExpense; ThisQuarterExpense)
                {
                    ApplicationArea = All;
                    Caption = 'This Quarter';
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        Expense: Record "Expense Entry";
                        StartDate: Date;
                        EndDate: Date;
                    begin
                        Calculator.GetThisQuarterDates(StartDate, EndDate);
                        Expense.SetRange(Category, Rec.Code);
                        Expense.SetRange(Date, StartDate, EndDate);
                        Page.Run(Page::"Zyn_Expense List", Expense);
                    end;
                }

                field(ThisHalfYearExpense; ThisHalfYearExpense)
                {
                    ApplicationArea = All;
                    Caption = 'This Half-Year';
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        Expense: Record "Expense Entry";
                        StartDate: Date;
                        EndDate: Date;
                    begin
                        Calculator.GetThisHalfYearDates(StartDate, EndDate);
                        Expense.SetRange(Category, Rec.Code);
                        Expense.SetRange(Date, StartDate, EndDate);
                        Page.Run(Page::"Zyn_Expense List", Expense);
                    end;
                }

                field(ThisYearExpense; ThisYearExpense)
                {
                    ApplicationArea = All;
                    Caption = 'This Year';
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        Expense: Record "Expense Entry";
                        StartDate: Date;
                        EndDate: Date;
                    begin
                        Calculator.GetThisYearDates(StartDate, EndDate);
                        Expense.SetRange(Category, Rec.Code);
                        Expense.SetRange(Date, StartDate, EndDate);
                        Page.Run(Page::"Zyn_Expense List", Expense);
                    end;
                }
            }

            cuegroup("Budget Categories")
            {
                Caption = 'Budget';

                field(ThisMonthBudget; ThisMonthBudget)
                {
                    ApplicationArea = All;
                    Caption = 'This Month';
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        Budget: Record "Zyn_Budget Entry";
                        StartDate: Date;
                        EndDate: Date;
                    begin
                        Calculator.GetThisMonthDates(StartDate, EndDate);
                        Budget.SetRange("Expense Category", Rec.Code);
                        Budget.SetRange("FromDate", StartDate, EndDate);
                        Page.Run(Page::"Zyn_Budget List Page", Budget);
                    end;
                }

                field(ThisQuarterBudget; ThisQuarterBudget)
                {
                    ApplicationArea = All;
                    Caption = 'This Quarter';
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        Budget: Record "Zyn_Budget Entry";
                        StartDate: Date;
                        EndDate: Date;
                    begin
                        Calculator.GetThisQuarterDates(StartDate, EndDate);
                        Budget.SetRange("Expense Category", Rec.Code);
                        Budget.SetRange(fromdate, StartDate, EndDate);
                        Page.Run(Page::"Zyn_Budget List Page", Budget);
                    end;
                }

                field(ThisHalfYearBudget; ThisHalfYearBudget)
                {
                    ApplicationArea = All;
                    Caption = 'This Half-Year';
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        Budget: Record "Zyn_Budget Entry";
                        StartDate: Date;
                        EndDate: Date;
                    begin
                        Calculator.GetThisHalfYearDates(StartDate, EndDate);
                        Budget.SetRange("Expense Category", Rec.Code);
                        Budget.SetRange(fromdate, StartDate, EndDate);
                        Page.Run(Page::"Zyn_Budget List Page", Budget);
                    end;
                }

                field(ThisYearBudget; ThisYearBudget)
                {
                    ApplicationArea = All;
                    Caption = 'This Year';
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        Budget: Record "Zyn_Budget Entry";
                        StartDate: Date;
                        EndDate: Date;
                    begin
                        Calculator.GetThisYearDates(StartDate, EndDate);
                        Budget.SetRange("Expense Category", Rec.Code);
                        Budget.SetRange("FromDate", StartDate, EndDate);
                        Page.Run(Page::"Zyn_Budget List Page", Budget);
                    end;
                }
            }
        }
    }

    var
        Calculator: Codeunit "Zyn_Expense&BudgetCalculator";
        Remaining: Decimal;
        ThisMonthExpense: Decimal;
        ThisQuarterExpense: Decimal;
        ThisHalfYearExpense: Decimal;
        ThisYearExpense: Decimal;
        ThisMonthBudget: Decimal;
        ThisQuarterBudget: Decimal;
        ThisHalfYearBudget: Decimal;
        ThisYearBudget: Decimal;

    trigger OnAfterGetRecord()
    var
        RemainingCalc: Codeunit "Zyn_Remaining Budget Calc";
    begin
        if Rec.Code <> '' then
            Remaining := RemainingCalc.CalcRemaining(Rec.Code)
        else
            Remaining := 0;

        ThisMonthExpense := Calculator.GetThisMonthExpense(Rec.Code);
        ThisQuarterExpense := Calculator.GetThisQuarterExpense(Rec.Code);
        ThisHalfYearExpense := Calculator.GetThisHalfYearExpense(Rec.Code);
        ThisYearExpense := Calculator.GetThisYearExpense(Rec.Code);

        ThisMonthBudget := Calculator.GetThisMonthBudget(Rec.Code);
        ThisQuarterBudget := Calculator.GetThisQuarterBudget(Rec.Code);
        ThisHalfYearBudget := Calculator.GetThisHalfYearBudget(Rec.Code);
        ThisYearBudget := Calculator.GetThisYearBudget(Rec.Code);
    end;
}




// page 50154 "Expense & Budget Factbox"
// {
//     PageType = CardPart;
//     SourceTable = "Expense Category";
//     Caption = 'Expense and Budget Factbox';
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             cuegroup("Expense Categories")
//             {
//                 Caption = 'Category Totals';

//                 field(ThisMonthExpense; GetThisMonthExpense())
//                 {
//                     ApplicationArea = All;
//                     Caption = 'This Month';
//                     DrillDown = true;
//                     trigger OnDrillDown()
//                     var
//                         Expense: Record "Expense Entry";
//                         StartDate: Date;
//                         EndDate: Date;
//                     begin
//                         GetThisMonthDates(StartDate, EndDate);
//                         Expense.SetRange(Category, Rec.Code);
//                         Expense.SetRange(Date, StartDate, EndDate);
//                         Page.Run(Page::"Expense List", Expense);
//                     end;
//                 }

//                 field(ThisQuarterExpense; GetThisQuarterExpense())
//                 {
//                     ApplicationArea = All;
//                     Caption = 'This Quarter';
//                     DrillDown = true;
//                     trigger OnDrillDown()
//                     var
//                         Expense: Record "Expense Entry";
//                         StartDate: Date;
//                         EndDate: Date;
//                     begin
//                         GetThisQuarterDates(StartDate, EndDate);
//                         Expense.SetRange(Category, Rec.Code);
//                         Expense.SetRange(Date, StartDate, EndDate);
//                         Page.Run(Page::"Expense List", Expense);
//                     end;
//                 }

//                 field(ThisHalfYearExpense; GetThisHalfYearExpense())
//                 {
//                     ApplicationArea = All;
//                     Caption = 'This Half-Year';
//                     DrillDown = true;
//                     trigger OnDrillDown()
//                     var
//                         Expense: Record "Expense Entry";
//                         StartDate: Date;
//                         EndDate: Date;
//                     begin
//                         GetThisHalfYearDates(StartDate, EndDate);
//                         Expense.SetRange(Category, Rec.Code);
//                         Expense.SetRange(Date, StartDate, EndDate);
//                         Page.Run(Page::"Expense List", Expense);
//                     end;
//                 }

//                 field(ThisYearExpense; GetThisYearExpense())
//                 {
//                     ApplicationArea = All;
//                     Caption = 'This Year';
//                     DrillDown = true;
//                     trigger OnDrillDown()
//                     var
//                         Expense: Record "Expense Entry";
//                         StartDate: Date;
//                         EndDate: Date;
//                     begin
//                         GetThisYearDates(StartDate, EndDate);
//                         Expense.SetRange(Category, Rec.Code);
//                         Expense.SetRange(Date, StartDate, EndDate);
//                         Page.Run(Page::"Expense List", Expense);
//                     end;
//                 }
//             }

//             group("")
//             {
//                 field(RemainingAmount; Remaining)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Remaining Budget';
//                     Editable = false;
//                 }
//             }

//             cuegroup("Budget Categories")
//             {
//                 field(ThisYearBudget; GetThisYearBudget())
//                 {
//                     ApplicationArea = All;
//                     Caption = 'This Year';
//                     DrillDown = true;
//                     trigger OnDrillDown()
//                     var
//                         Budget: Record Budgetentry;
//                         StartDate: Date;
//                         EndDate: Date;
//                     begin
//                         GetThisYearDates(StartDate, EndDate);
//                         Budget.SetRange("Expense Category", Rec.Code);
//                         Budget.SetRange(fromdate, StartDate, EndDate);
//                         Page.Run(Page::"Expense List", Budget);
//                     end;
//                 }

//                 field(ThisHalfYearBudget; GetThisHalfyearBudget())
//                 {
//                     ApplicationArea = All;
//                     Caption = 'This Half Year';
//                     DrillDown = true;
//                     trigger OnDrillDown()
//                     var
//                         Budget: Record Budgetentry;
//                         StartDate: Date;
//                         EndDate: Date;
//                     begin
//                         GetThisHalfYearDates(StartDate, EndDate);
//                         Budget.SetRange("Expense Category", Rec.Code);
//                         Budget.SetRange(fromdate, StartDate, EndDate);
//                         Page.Run(Page::"Expense List", Budget);
//                     end;
//                 }

//                 field(ThisQuaterBudget; GetThisQuaterBudget())
//                 {
//                     ApplicationArea = All;
//                     Caption = 'This Quater';
//                     DrillDown = true;
//                     trigger OnDrillDown()
//                     var
//                         Budget: Record Budgetentry;
//                         StartDate: Date;
//                         EndDate: Date;
//                     begin
//                         GetThisQuarterDates(StartDate, EndDate);
//                         Budget.SetRange("Expense Category", Rec.Code);
//                         Budget.SetRange(fromdate, StartDate, EndDate);
//                         Page.Run(Page::"Expense List", Budget);
//                     end;
//                 }

//                 field(ThisMonthBudget; GetThisMonthBudget())
//                 {
//                     ApplicationArea = All;
//                     Caption = 'This Month';
//                     DrillDown = true;
//                     trigger OnDrillDown()
//                     var
//                         Budget: Record Budgetentry;
//                         StartDate: Date;
//                         EndDate: Date;
//                     begin
//                         GetThisMonthDates(StartDate, EndDate);
//                         Budget.SetRange("Expense Category", Rec.Code);
//                         Budget.SetRange(fromdate, StartDate, EndDate);
//                         Page.Run(Page::"Expense List", Budget);
//                     end;
//                 }
//             }
//         }
//     }
// }


//     local procedure GetThisMonthExpense(): Decimal
//     var
//         Expense: Record "Expense Entry";
//         StartDate: Date;
//         EndDate: Date;
//         Sum: Decimal;
//     begin
//         GetThisMonthDates(StartDate, EndDate);
//         Expense.SetRange(Category, Rec.Code);
//         Expense.SetRange(Date, StartDate, EndDate);
//         if Expense.FindSet() then
//             repeat
//                 Sum += Expense.Amount;
//             until Expense.Next() = 0;
//         exit(Sum);
//     end;

//     local procedure GetThisQuarterExpense(): Decimal
//     var
//         Expense: Record "Expense Entry";
//         StartDate: Date;
//         EndDate: Date;
//         Sum: Decimal;
//     begin
//         GetThisQuarterDates(StartDate, EndDate);
//         Expense.SetRange(Category, Rec.Code);
//         Expense.SetRange(Date, StartDate, EndDate);
//         if Expense.FindSet() then
//             repeat
//                 Sum += Expense.Amount;
//             until Expense.Next() = 0;
//         exit(Sum);
//     end;

//     local procedure GetThisHalfYearExpense(): Decimal
//     var
//         Expense: Record "Expense Entry";
//         StartDate: Date;
//         EndDate: Date;
//         Sum: Decimal;
//     begin
//         GetThisHalfYearDates(StartDate, EndDate);
//         Expense.SetRange(Category, Rec.Code);
//         Expense.SetRange(Date, StartDate, EndDate);
//         if Expense.FindSet() then
//             repeat
//                 Sum += Expense.Amount;
//             until Expense.Next() = 0;
//         exit(Sum);
//     end;

//     local procedure GetThisYearExpense(): Decimal
//     var
//         Expense: Record "Expense Entry";
//         StartDate: Date;
//         EndDate: Date;
//         Sum: Decimal;
//     begin
//         GetThisYearDates(StartDate, EndDate);
//         Expense.SetRange(Category, Rec.Code);
//         Expense.SetRange(Date, StartDate, EndDate);
//         if Expense.FindSet() then
//             repeat
//                 Sum += Expense.Amount;
//             until Expense.Next() = 0;
//         exit(Sum);
//     end;

//     local procedure GetThisYearBudget(): Decimal
//     var
//         budget: Record Budgetentry;
//         StartDate: Date;
//         EndDate: Date;
//         Sum: Decimal;
//     begin
//         GetThisYearDates(StartDate, EndDate);
//         budget.SetRange("Expense Category", Rec.Code);
//         budget.SetRange(fromdate, StartDate, EndDate);
//         if budget.FindSet() then
//             repeat
//                 Sum += budget.Amount;
//             until budget.Next() = 0;
//         exit(Sum);
//     end;

//     local procedure GetThisHalfyearBudget(): Decimal
//     var
//         budget: Record Budgetentry;
//         StartDate: Date;
//         EndDate: Date;
//         Sum: Decimal;
//     begin
//         GetThisHalfYearDates(StartDate, EndDate);
//         budget.SetRange("Expense Category", Rec.Code);
//         budget.SetRange(fromdate, StartDate, EndDate);
//         if budget.FindSet() then
//             repeat
//                 Sum += budget.Amount;
//             until budget.Next() = 0;
//         exit(Sum);
//     end;

//     local procedure GetThisQuaterBudget(): Decimal
//     var
//         budget: Record Budgetentry;
//         StartDate: Date;
//         EndDate: Date;
//         Sum: Decimal;
//     begin
//         GetThisQuarterDates(StartDate, EndDate);
//         budget.SetRange("Expense Category", Rec.Code);
//         budget.SetRange(fromdate, StartDate, EndDate);
//         if budget.FindSet() then
//             repeat
//                 Sum += budget.Amount;
//             until budget.Next() = 0;
//         exit(Sum);
//     end;

//     local procedure GetThisMonthBudget(): Decimal
//     var
//         budget: Record Budgetentry;
//         StartDate: Date;
//         EndDate: Date;
//         Sum: Decimal;
//     begin
//         GetThisMonthDates(StartDate, EndDate);
//         budget.SetRange("Expense Category", Rec.Code);
//         budget.SetRange(fromdate, StartDate, EndDate);
//         if budget.FindSet() then
//             repeat
//                 Sum += budget.Amount;
//             until budget.Next() = 0;
//         exit(Sum);
//     end;

//     local procedure GetThisMonthDates(var StartDate: Date; var EndDate: Date)
//     begin
//         StartDate := CalcDate('-CM', WorkDate());
//         EndDate := CalcDate('<CM>', WorkDate());
//     end;

//     local procedure GetThisQuarterDates(var StartDate: Date; var EndDate: Date)
//     begin
//         StartDate := CalcDate('-CQ', WorkDate());
//         EndDate := CalcDate('<CQ>', WorkDate());
//     end;

//     local procedure GetThisHalfYearDates(var StartDate: Date; var EndDate: Date)
//     var
//         CurrentMonth: Integer;
//         CurrentYear: Integer;
//     begin
//         CurrentMonth := Date2DMY(WorkDate(), 2);
//         CurrentYear := Date2DMY(WorkDate(), 3);

//         if CurrentMonth <= 6 then begin
//             StartDate := DMY2DATE(1, 1, CurrentYear);
//             EndDate := DMY2DATE(30, 6, CurrentYear);
//         end else begin
//             StartDate := DMY2DATE(1, 7, CurrentYear);
//             EndDate := DMY2DATE(31, 12, CurrentYear);
//         end;
//     end;

//     local procedure GetThisYearDates(var StartDate: Date; var EndDate: Date)
//     begin
//         StartDate := CalcDate('-CY', WorkDate());
//         EndDate := CalcDate('<CY>', WorkDate());
//     end;
// }


// -------------------------------------------------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------------------------------------------------


// page 50154 "Expense Factbox"
// {
//     PageType = CardPart;
//     SourceTable = "Expense Category";
//     Caption = 'Expense Factbox';
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             cuegroup(CategoryTotals)
//             {
//                 Caption = 'Category Totals';

//                 field(ThisMonthExpense; GetThisMonthExpense())
//                 {
//                     ApplicationArea = All;
//                     Caption = 'This Month';
//                     DrillDown = true;
//                     trigger OnDrillDown()
//                     var
//                         Expense: Record "Expense Entry";
//                         StartDate: Date;
//                         EndDate: Date;
//                     begin
//                         GetThisMonthDates(StartDate, EndDate); 
//                         Expense.SetRange("Category", Rec.Code);
//                         Expense.SetRange(Date, StartDate, EndDate);
//                         Page.Run(Page::"Expense List", Expense);
//                     end;
//                 }

//                 field(ThisQuarterExpense; GetThisQuarterExpense())
//                 {
//                     ApplicationArea = All;
//                     Caption = 'This Quarter';
//                     DrillDown = true;
//                     trigger OnDrillDown()
//                     var
//                         Expense: Record "Expense Entry";
//                         StartDate: Date;
//                         EndDate: Date;
//                     begin
//                         GetThisQuarterDates(StartDate, EndDate); 
//                         Expense.SetRange("Category", Rec.Code);
//                         Expense.SetRange(Date, StartDate, EndDate);
//                         Page.Run(Page::"Expense List", Expense);
//                     end;
//                 }

//                 field(ThisHalfYearExpense; GetThisHalfYearExpense())
//                 {
//                     ApplicationArea = All;
//                     Caption = 'This Half-Year';
//                     DrillDown = true;
//                     trigger OnDrillDown()
//                     var
//                         Expense: Record "Expense Entry";
//                         StartDate: Date;
//                         EndDate: Date;
//                     begin
//                         GetThisHalfYearDates(StartDate, EndDate); 
//                         Expense.SetRange("Category", Rec.Code);
//                         Expense.SetRange(Date, StartDate, EndDate);
//                         Page.Run(Page::"Expense List", Expense);
//                     end;
//                 }

//                 field(ThisYearExpense; GetThisYearExpense())
//                 {
//                     ApplicationArea = All;
//                     Caption = 'This Year';
//                     DrillDown = true;
//                     trigger OnDrillDown()
//                     var
//                         Expense: Record "Expense Entry";
//                         StartDate: Date;
//                         EndDate: Date;
//                     begin
//                         GetThisYearDates(StartDate, EndDate); 
//                         Expense.SetRange("Category", Rec.Code);
//                         Expense.SetRange(Date, StartDate, EndDate);
//                         Page.Run(Page::"Expense List", Expense);
//                     end;
//                 }
//             }
//         }
//     }

//     local procedure GetThisMonthExpense(): Decimal
//     var
//         Expense: Record "Expense Entry";
//         StartDate: Date;
//         EndDate: Date;
//         Sum: Decimal;
//     begin
//         GetThisMonthDates(StartDate, EndDate); 
//         Expense.SetRange("Category", Rec.Code);
//         Expense.SetRange(Date, StartDate, EndDate);
//         if Expense.FindSet() then
//             repeat
//                 Sum += Expense.Amount;
//             until Expense.Next() = 0;
//         exit(Sum);
//     end;

//     local procedure GetThisQuarterExpense(): Decimal
//     var
//         Expense: Record "Expense Entry";
//         StartDate: Date;
//         EndDate: Date;
//         Sum: Decimal;
//     begin
//         GetThisQuarterDates(StartDate, EndDate); 
//         Expense.SetRange("Category", Rec.Code);
//         Expense.SetRange(Date, StartDate, EndDate);
//         if Expense.FindSet() then
//             repeat
//                 Sum += Expense.Amount;
//             until Expense.Next() = 0;
//         exit(Sum);
//     end;

//     local procedure GetThisHalfYearExpense(): Decimal
//     var
//         Expense: Record "Expense Entry";
//         StartDate: Date;
//         EndDate: Date;
//         Sum: Decimal;
//     begin
//         GetThisHalfYearDates(StartDate, EndDate); 
//         Expense.SetRange("Category", Rec.Code);
//         Expense.SetRange(Date, StartDate, EndDate);
//         if Expense.FindSet() then
//             repeat
//                 Sum += Expense.Amount;
//             until Expense.Next() = 0;
//         exit(Sum);
//     end;

//     local procedure GetThisYearExpense(): Decimal
//     var
//         Expense: Record "Expense Entry";
//         StartDate: Date;
//         EndDate: Date;
//         Sum: Decimal;
//     begin
//         GetThisYearDates(StartDate, EndDate); 
//         Expense.SetRange("Category", Rec.Code);
//         Expense.SetRange(Date, StartDate, EndDate);
//         if Expense.FindSet() then
//             repeat
//                 Sum += Expense.Amount;
//             until Expense.Next() = 0;
//         exit(Sum);
//     end;

//     local procedure GetThisMonthDates(var StartDate: Date; var EndDate: Date)
//     var
//         tMonth: Integer;
//         tYear: Integer;
//     begin
//         tMonth := Date2DMY(WorkDate(), 2); 
//         tYear := Date2DMY(WorkDate(), 3);
//         StartDate := DMY2DATE(1, tMonth, tYear);
//         EndDate := CalcDate('<+1M-1D>', StartDate);
//     end;

//     local procedure GetThisQuarterDates(var StartDate: Date; var EndDate: Date)
//     var
//         tMonth: Integer;
//         tYear: Integer;
//         qStartMonth: Integer;
//     begin
//         tMonth := Date2DMY(WorkDate(), 2);
//         tYear := Date2DMY(WorkDate(), 3);
//         qStartMonth := ((tMonth - 1) DIV 3) * 3 + 1;
//         StartDate := DMY2DATE(1, qStartMonth, tYear);
//         EndDate := CalcDate('<+3M-1D>', StartDate);
//     end;

//     local procedure GetThisHalfYearDates(var StartDate: Date; var EndDate: Date)
//     var
//         tMonth: Integer;
//         tYear: Integer;
//         startMonth: Integer;
//     begin
//         tMonth := Date2DMY(WorkDate(), 2);
//         tYear := Date2DMY(WorkDate(), 3);
//         if tMonth <= 6 then
//             startMonth := 1
//         else
//             startMonth := 7;
//         StartDate := DMY2DATE(1, startMonth, tYear);
//         EndDate := CalcDate('<+6M-1D>', StartDate);
//     end;

//     local procedure GetThisYearDates(var StartDate: Date; var EndDate: Date)
//     var
//         tYear: Integer;
//     begin
//         tYear := Date2DMY(WorkDate(), 3); // CY
//         StartDate := DMY2DATE(1, 1, tYear);
//         EndDate := DMY2DATE(31, 12, tYear);
//     end;
// }
