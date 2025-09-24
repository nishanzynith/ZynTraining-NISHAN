codeunit 50170 "Zyn_Remaining Budget Calc"
{
    procedure CalcRemaining(CategoryCode: Code[20]): Decimal
    var
        BudgetEntry: Record "BudgetEntry";
        ExpenseRec: Record "Expense Entry";
        StartDate: Date;
        EndDate: Date;
        TotalExpenses: Decimal;
        Remaining: Decimal;
    begin
        Remaining := 0;

        if CategoryCode = '' then
            exit(0);


        StartDate := CalcDate('<-CM>', WorkDate());
        EndDate := Calcdate('<CM>', StartDate);

        ExpenseRec.Reset();
        ExpenseRec.SetRange(Category, CategoryCode);
        ExpenseRec.SetRange("Date", StartDate, EndDate);
        if ExpenseRec.FindSet() then
            repeat
                TotalExpenses += ExpenseRec.Amount;
            until ExpenseRec.Next() = 0;

        BudgetEntry.Reset();
        BudgetEntry.SetRange("Expense Category", CategoryCode);
        BudgetEntry.SetRange("FromDate", StartDate, EndDate);
        if BudgetEntry.FindFirst() then
            Remaining := BudgetEntry.Amount - TotalExpenses;

        exit(Remaining);
    end;
}
