report 50106 "Zyn_Expense Yearly Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Expense_Tracker; "Expense Entry")
        {
            DataItemTableView = SORTING("No.") WHERE("No." = CONST(1));

            // trigger OnAfterGetRecord()
            // var
            //     MonthNo: Integer;
            //     MonthName: Text[20];
            //     BudgetRec: Record Budgetentry;
            //     BudgetValue: Decimal;
            // begin
            //     if Date2DMY(Expense_Tracker.Date, 3) = SelectedYear then begin
            //         MonthNo := Date2DMY(Expense_Tracker.Date, 2);
            //         MonthName := Format(DMY2Date(1, MonthNo, SelectedYear), 0, '<Month Text>');

            //         BudgetValue := 0;
            //         BudgetRec.Reset();

            //         
            //         StartDate := DMY2Date(1, MonthNo, SelectedYear);
            //         EndDate := CALCDATE('<CM>', StartDate); // End of current month

            //
            //         BudgetRec.SetRange("FromDate", StartDate, EndDate);
            //         BudgetRec.SetRange("Expense Category", Expense_Tracker.Category);

            //         if BudgetRec.FindFirst() then
            //             BudgetValue := BudgetRec.Amount;


            //         ExcelBuffer.AddColumn(MonthName, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            //         ExcelBuffer.AddColumn(Expense_Tracker.Category, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            //         ExcelBuffer.AddColumn(Expense_Tracker.Amount, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
            //         ExcelBuffer.AddColumn(BudgetValue, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
            //         // ExcelBuffer.AddColumn(BudgetValue - Expense_Tracker.Amount, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
            //         ExcelBuffer.NewRow();

            //         RecordsFound := true;
            //     end;
            // end;
            trigger OnAfterGetRecord()

            begin
                ExportMonthlyReport(SelectedYear);
            end;



        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filter_Group)
                {
                    field(SelectedYear; SelectedYear)
                    {
                        ApplicationArea = All;
                        Caption = 'Year';
                    }
                }
            }
        }
    }

    var
        ExcelBuffer: Record "Excel Buffer" temporary;
        SelectedYear: Integer;
        RecordsFound: Boolean;

        startdate: date;
        enddate: date;

    trigger OnPreReport()
    begin
        ExcelBuffer.DeleteAll();
        RecordsFound := false;

        ExcelBuffer.AddColumn('Month', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Category', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Expenses', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Budget', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        // ExcelBuffer.AddColumn('Variance', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.NewRow();
    end;

    trigger OnPostReport()
    var
        FileName: Text;
    begin
        if not RecordsFound then begin
            ExcelBuffer.AddColumn('No data found for the selected year.', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.NewRow();
        end;

        FileName := 'Expense_Summary_' + Format(SelectedYear) + '.xlsx';

        ExcelBuffer.CreateNewBook('Expense Summary');
        ExcelBuffer.WriteSheet('Summary', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(FileName);
        ExcelBuffer.OpenExcel();
    end;
    // procedure ExportMonthlyReport(SelectedYear: Integer)
    // var
    //     MonthNo: Integer;
    //     MonthName: Text[20];
    //     StartDate: Date;
    //     EndDate: Date;
    //     ExpenseRec: Record "Expense Entry";
    //     BudgetRec: Record "BudgetEntry";
    //     ExpenseValue: Decimal;
    //     BudgetValue: Decimal;
    //     CategoryRec: Record "Expense Category";
    // begin
    //     
    //     for MonthNo := 1 to 12 do begin
    //         MonthName := Format(DMY2Date(1, MonthNo, SelectedYear), 0, '<Month Text>');
    //         StartDate := DMY2Date(1, MonthNo, SelectedYear);
    //         EndDate := CalcDate('<CM>', StartDate);

    //         
    //         ExcelBuffer.NewRow();
    //         ExcelBuffer.AddColumn(MonthName, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);

    //         
    //         CategoryRec.Reset();
    //         if CategoryRec.FindSet() then
    //             repeat
    //                 ExpenseValue := 0; // reset every loop
    //                 BudgetValue := 0;

    //                 
    //                 ExpenseRec.Reset();
    //                 ExpenseRec.SetRange(Category, CategoryRec.Code);
    //                 ExpenseRec.SetRange(Date, StartDate, EndDate);
    //                 if ExpenseRec.FindSet() then begin
    //                     ExpenseRec.CalcSums(Amount);
    //                     ExpenseValue := ExpenseRec.Amount; // will be 0 if nothing
    //                 end;

    //                 
    //                 BudgetRec.Reset();
    //                 BudgetRec.SetRange("Expense Category", CategoryRec.Code);
    //                 BudgetRec.SetRange("FromDate", StartDate, EndDate);
    //                 if BudgetRec.FindFirst() then
    //                     BudgetValue := BudgetRec.Amount;

    //                 
    //                 ExcelBuffer.NewRow();
    //                 ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text); // leave month blank
    //                 ExcelBuffer.AddColumn(CategoryRec.Code, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    //                 ExcelBuffer.AddColumn(ExpenseValue, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
    //                 ExcelBuffer.AddColumn(BudgetValue, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);

    //             until CategoryRec.Next() = 0;
    //     end;
    // end;
    procedure ExportMonthlyReport(SelectedYear: Integer)
    var
        BudgetRec: Record "Zyn_Budget Entry";
        ExpenseRec: Record "Expense Entry";
        CategoryRec: Record "Zyn_Expense Category";
        incomerec: Record "Income Entry";
        MonthLoop: Integer;
        StartDate: Date;
        EndDate: Date;
        TotalBudget: Decimal;
        TotalIncome: decimal;
        SpentBudget: Decimal;
        MonthPrinted: Boolean;
    begin
        for MonthLoop := 1 to 12 do begin
            StartDate := DMY2Date(1, MonthLoop, SelectedYear);
            EndDate := CalcDate('<CM>-1D', StartDate);
            MonthPrinted := false;
            TotalIncome := 0;
            incomerec.Reset();
            incomerec.SetRange(Date, startDate, EndDate);
            if incomerec.Findset() then
                repeat
                    Totalincome += incomerec.Amount;
                until incomerec.Next() = 0;
            CategoryRec.Reset();
            if CategoryRec.FindSet() then
                repeat
                    TotalBudget := 0;
                    SpentBudget := 0;
                    // TotalIncome := 0;

                    BudgetRec.Reset();
                    BudgetRec.SetRange("Expense Category", CategoryRec.Code);
                    BudgetRec.SetFilter(FromDate, '<=%1', EndDate);
                    BudgetRec.SetFilter(endDate, '>=%1', StartDate);
                    if BudgetRec.FindFirst() then
                        repeat
                            TotalBudget := BudgetRec.Amount;
                        until budgetrec.Next() = 0;
                    // incomerec.Reset();
                    // incomerec.SetRange(Date, startDate, EndDate);
                    // if incomerec.Findset() then
                    //     repeat
                    //         Totalincome += incomerec.Amount;
                    //     until incomerec.Next() = 0;
                    ExpenseRec.Reset();
                    ExpenseRec.SetRange(Category, CategoryRec.Code);
                    ExpenseRec.SetRange(Date, StartDate, EndDate);
                    if ExpenseRec.FindSet() then
                        repeat
                            SpentBudget += ExpenseRec.Amount;
                        until ExpenseRec.Next() = 0;

                    ExcelBuffer.NewRow();
                    if not MonthPrinted then begin
                        ExcelBuffer.AddColumn(Format(StartDate, 0, '<Month Text>'), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                        MonthPrinted := true;
                    end else
                        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);

                    ExcelBuffer.AddColumn(CategoryRec.Code, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(SpentBudget, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(TotalBudget, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                until CategoryRec.Next() = 0;
            ExcelBuffer.NewRow();
            ExcelBuffer.AddColumn('Total Income', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.AddColumn(TotalIncome, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.NewRow();
            ExcelBuffer.AddColumn('Total Expense', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.AddColumn(SpentBudget, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.NewRow();
            ExcelBuffer.AddColumn('Total Savings', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.AddColumn(TotalIncome - SpentBudget, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.NewRow();
        end;
    end;



}
