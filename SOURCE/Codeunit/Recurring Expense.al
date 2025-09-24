codeunit 50102 "Zyn_Recurring Expense Process"
{
    Subtype = Normal;

    trigger OnRun()
    var
        RecurringExpense: Record "Zyn_Recurring Expense";
    begin
        ProcessRecurringExpenses();
    end;

    local procedure ProcessRecurringExpenses()
    var
        RecurringExpense: Record "Zyn_Recurring Expense";
    begin
        RecurringExpense.Reset();
        RecurringExpense.SetRange("Next Cycle Date", WorkDate());

        if RecurringExpense.FindSet() then
            repeat
                CreateExpense(RecurringExpense);
                UpdateNextDate(RecurringExpense);
            until RecurringExpense.Next() = 0;
    end;

    local procedure CreateExpense(RecurringExpense: Record "Zyn_Recurring Expense")
    var
        Expense: Record "Expense Entry";
    begin
        Expense.Init();
        Expense."Date" := WorkDate();
        Expense.Description := RecurringExpense.Description;
        Expense.Amount := RecurringExpense.Amount;
        Expense.Category := RecurringExpense.Category;
        Expense.Insert();
    end;

    local procedure UpdateNextDate(var RecurringExpense: Record "Zyn_Recurring Expense")
    begin
        case RecurringExpense."Cycling Period" of
            RecurringExpense."Cycling Period"::Weekly:
                RecurringExpense."Next Cycle Date" := CalcDate('<+1W>', RecurringExpense."Next Cycle Date");
            RecurringExpense."Cycling Period"::Monthly:
                RecurringExpense."Next Cycle Date" := CalcDate('<+1M>', RecurringExpense."Next Cycle Date");
            RecurringExpense."Cycling Period"::Quaterly:
                RecurringExpense."Next Cycle Date" := CalcDate('<+3M>', RecurringExpense."Next Cycle Date");
            RecurringExpense."Cycling Period"::"Half Yearly":
                RecurringExpense."Next Cycle Date" := CalcDate('<+6M>', RecurringExpense."Next Cycle Date");
            RecurringExpense."Cycling Period"::Yearly:
                RecurringExpense."Next Cycle Date" := CalcDate('<+1Y>', RecurringExpense."Next Cycle Date");
        end;
        RecurringExpense.Modify(true);
    end;
}


