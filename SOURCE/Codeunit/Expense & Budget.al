codeunit 50155 "Zyn_Expense&BudgetCalculator"
{
    Subtype = Normal;

    procedure GetThisMonthExpense(CategoryCode: Code[20]): Decimal
    var
        Expense: Record "Expense Entry";
        StartDate: Date;
        EndDate: Date;
        Sum: Decimal;
    begin
        GetThisMonthDates(StartDate, EndDate);
        Expense.SetRange(Category, CategoryCode);
        Expense.SetRange(Date, StartDate, EndDate);
        if Expense.FindSet() then
            repeat
                Sum += Expense.Amount;
            until Expense.Next() = 0;
        exit(Sum);
    end;

    procedure GetThisQuarterExpense(CategoryCode: Code[20]): Decimal
    var
        Expense: Record "Expense Entry";
        StartDate: Date;
        EndDate: Date;
        Sum: Decimal;
    begin
        GetThisQuarterDates(StartDate, EndDate);
        Expense.SetRange(Category, CategoryCode);
        Expense.SetRange(Date, StartDate, EndDate);
        if Expense.FindSet() then
            repeat
                Sum += Expense.Amount;
            until Expense.Next() = 0;
        exit(Sum);
    end;

    procedure GetThisHalfYearExpense(CategoryCode: Code[20]): Decimal
    var
        Expense: Record "Expense Entry";
        StartDate: Date;
        EndDate: Date;
        Sum: Decimal;
    begin
        GetThisHalfYearDates(StartDate, EndDate);
        Expense.SetRange(Category, CategoryCode);
        Expense.SetRange(Date, StartDate, EndDate);
        if Expense.FindSet() then
            repeat
                Sum += Expense.Amount;
            until Expense.Next() = 0;
        exit(Sum);
    end;

    procedure GetThisYearExpense(CategoryCode: Code[20]): Decimal
    var
        Expense: Record "Expense Entry";
        StartDate: Date;
        EndDate: Date;
        Sum: Decimal;
    begin
        GetThisYearDates(StartDate, EndDate);
        Expense.SetRange(Category, CategoryCode);
        Expense.SetRange(Date, StartDate, EndDate);
        if Expense.FindSet() then
            repeat
                Sum += Expense.Amount;
            until Expense.Next() = 0;
        exit(Sum);
    end;

    procedure GetThisYearBudget(CategoryCode: Code[20]): Decimal
    var
        Budget: Record Budgetentry;
        StartDate: Date;
        EndDate: Date;
        Sum: Decimal;
    begin
        GetThisYearDates(StartDate, EndDate);
        Budget.SetRange("Expense Category", CategoryCode);
        Budget.SetRange(fromdate, StartDate, EndDate);
        if Budget.FindSet() then
            repeat
                Sum += Budget.Amount;
            until Budget.Next() = 0;
        exit(Sum);
    end;

    procedure GetThisHalfYearBudget(CategoryCode: Code[20]): Decimal
    var
        Budget: Record Budgetentry;
        StartDate: Date;
        EndDate: Date;
        Sum: Decimal;
    begin
        GetThisHalfYearDates(StartDate, EndDate);
        Budget.SetRange("Expense Category", CategoryCode);
        Budget.SetRange(fromdate, StartDate, EndDate);
        if Budget.FindSet() then
            repeat
                Sum += Budget.Amount;
            until Budget.Next() = 0;
        exit(Sum);
    end;

    procedure GetThisQuarterBudget(CategoryCode: Code[20]): Decimal
    var
        Budget: Record Budgetentry;
        StartDate: Date;
        EndDate: Date;
        Sum: Decimal;
    begin
        GetThisQuarterDates(StartDate, EndDate);
        Budget.SetRange("Expense Category", CategoryCode);
        Budget.SetRange(fromdate, StartDate, EndDate);
        if Budget.FindSet() then
            repeat
                Sum += Budget.Amount;
            until Budget.Next() = 0;
        exit(Sum);
    end;

    procedure GetThisMonthBudget(CategoryCode: Code[20]): Decimal
    var
        Budget: Record Budgetentry;
        StartDate: Date;
        EndDate: Date;
        Sum: Decimal;
    begin
        GetThisMonthDates(StartDate, EndDate);
        Budget.SetRange("Expense Category", CategoryCode);
        Budget.SetRange(fromdate, StartDate, EndDate);
        if Budget.FindSet() then
            repeat
                Sum += Budget.Amount;
            until Budget.Next() = 0;
        exit(Sum);
    end;


    procedure GetThisMonthDates(var StartDate: Date; var EndDate: Date)
    begin
        StartDate := CalcDate('-CM', WorkDate());
        EndDate := CalcDate('<CM>', WorkDate());
    end;

    procedure GetThisQuarterDates(var StartDate: Date; var EndDate: Date)
    begin
        StartDate := CalcDate('-CQ', WorkDate());
        EndDate := CalcDate('<CQ>', WorkDate());
    end;

    procedure GetThisHalfYearDates(var StartDate: Date; var EndDate: Date)
    var
        CurrentMonth: Integer;
        CurrentYear: Integer;
    begin
        CurrentMonth := Date2DMY(WorkDate(), 2);
        CurrentYear := Date2DMY(WorkDate(), 3);

        if CurrentMonth <= 6 then begin
            StartDate := DMY2DATE(1, 1, CurrentYear);
            EndDate := DMY2DATE(30, 6, CurrentYear);
        end else begin
            StartDate := DMY2DATE(1, 7, CurrentYear);
            EndDate := DMY2DATE(31, 12, CurrentYear);
        end;
    end;

    procedure GetThisYearDates(var StartDate: Date; var EndDate: Date)
    begin
        StartDate := CalcDate('-CY', WorkDate());
        EndDate := CalcDate('<CY>', WorkDate());
    end;
}
