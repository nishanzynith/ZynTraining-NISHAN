page 50142 "Zyn_Income Factbox"
{
    PageType = CardPart;
    SourceTable = "Zyn_Income Category";
    Caption = 'Income Factbox';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup(CategoryTotals)
            {
                Caption = 'Category Totals';

                field(ThisMonthIncome; GetThisMonthIncome())
                {
                    ApplicationArea = All;
                    Caption = 'This Month';
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        Income: Record "Income Entry";
                        StartDate: Date;
                        EndDate: Date;
                    begin
                        GetThisMonthDates(StartDate, EndDate);
                        Income.SetRange("Category", Rec.Code);
                        Income.SetRange(Date, StartDate, EndDate);
                        Page.Run(Page::"Zyn_Income List", Income);
                    end;
                }

                field(ThisQuarterIncome; GetThisQuarterIncome())
                {
                    ApplicationArea = All;
                    Caption = 'This Quarter';
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        Income: Record "Income Entry";
                        StartDate: Date;
                        EndDate: Date;
                    begin
                        GetThisQuarterDates(StartDate, EndDate);
                        Income.SetRange("Category", Rec.Code);
                        Income.SetRange(Date, StartDate, EndDate);
                        Page.Run(Page::"Zyn_Income List", Income);
                    end;
                }

                field(ThisHalfYearIncome; GetThisHalfYearIncome())
                {
                    ApplicationArea = All;
                    Caption = 'This Half-Year';
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        Income: Record "Income Entry";
                        StartDate: Date;
                        EndDate: Date;
                    begin
                        GetThisHalfYearDates(StartDate, EndDate);
                        Income.SetRange("Category", Rec.Code);
                        Income.SetRange(Date, StartDate, EndDate);
                        Page.Run(Page::"Zyn_Income List", Income);
                    end;
                }

                field(ThisYearIncome; GetThisYearIncome())
                {
                    ApplicationArea = All;
                    Caption = 'This Year';
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        Income: Record "Income Entry";
                        StartDate: Date;
                        EndDate: Date;
                    begin
                        GetThisYearDates(StartDate, EndDate);
                        Income.SetRange("Category", Rec.Code);
                        Income.SetRange(Date, StartDate, EndDate);
                        Page.Run(Page::"Zyn_Income List", Income);
                    end;
                }
            }
        }
    }

    local procedure GetThisMonthIncome(): Decimal
    var
        Income: Record "Income Entry";
        StartDate: Date;
        EndDate: Date;
        Sum: Decimal;
    begin
        GetThisMonthDates(StartDate, EndDate);
        Income.SetRange("Category", Rec.Code);
        Income.SetRange(Date, StartDate, EndDate);
        if Income.FindSet() then
            repeat
                Sum += Income.Amount;
            until Income.Next() = 0;
        exit(Sum);
    end;

    local procedure GetThisQuarterIncome(): Decimal
    var
        Income: Record "Income Entry";
        StartDate: Date;
        EndDate: Date;
        Sum: Decimal;
    begin
        GetThisQuarterDates(StartDate, EndDate);
        Income.SetRange("Category", Rec.Code);
        Income.SetRange(Date, StartDate, EndDate);
        if Income.FindSet() then
            repeat
                Sum += Income.Amount;
            until Income.Next() = 0;
        exit(Sum);
    end;

    local procedure GetThisHalfYearIncome(): Decimal
    var
        Income: Record "Income Entry";
        StartDate: Date;
        EndDate: Date;
        Sum: Decimal;
    begin
        GetThisHalfYearDates(StartDate, EndDate);
        Income.SetRange("Category", Rec.Code);
        Income.SetRange(Date, StartDate, EndDate);
        if Income.FindSet() then
            repeat
                Sum += Income.Amount;
            until Income.Next() = 0;
        exit(Sum);
    end;

    local procedure GetThisYearIncome(): Decimal
    var
        Income: Record "Income Entry";
        StartDate: Date;
        EndDate: Date;
        Sum: Decimal;
    begin
        GetThisYearDates(StartDate, EndDate);
        Income.SetRange("Category", Rec.Code);
        Income.SetRange(Date, StartDate, EndDate);
        if Income.FindSet() then
            repeat
                Sum += Income.Amount;
            until Income.Next() = 0;
        exit(Sum);
    end;

    local procedure GetThisMonthDates(var StartDate: Date; var EndDate: Date)
    var
        tMonth: Integer;
        tYear: Integer;
    begin
        tMonth := Date2DMY(WorkDate(), 2);
        tYear := Date2DMY(WorkDate(), 3);
        StartDate := DMY2DATE(1, tMonth, tYear);
        EndDate := CalcDate('<+1M-1D>', StartDate);
    end;

    local procedure GetThisQuarterDates(var StartDate: Date; var EndDate: Date)
    var
        tMonth: Integer;
        tYear: Integer;
        qStartMonth: Integer;
    begin
        tMonth := Date2DMY(WorkDate(), 2);
        tYear := Date2DMY(WorkDate(), 3);
        qStartMonth := ((tMonth - 1) DIV 3) * 3 + 1;
        StartDate := DMY2DATE(1, qStartMonth, tYear);
        EndDate := CalcDate('<+3M-1D>', StartDate);
    end;

    local procedure GetThisHalfYearDates(var StartDate: Date; var EndDate: Date)
    var
        tMonth: Integer;
        tYear: Integer;
        startMonth: Integer;
    begin
        tMonth := Date2DMY(WorkDate(), 2);
        tYear := Date2DMY(WorkDate(), 3);
        if tMonth <= 6 then
            startMonth := 1
        else
            startMonth := 7;
        StartDate := DMY2DATE(1, startMonth, tYear);
        EndDate := CalcDate('<+6M-1D>', StartDate);
    end;

    local procedure GetThisYearDates(var StartDate: Date; var EndDate: Date)
    var
        tYear: Integer;
    begin
        tYear := Date2DMY(WorkDate(), 3);
        StartDate := DMY2DATE(1, 1, tYear);
        EndDate := DMY2DATE(31, 12, tYear);
    end;

}
