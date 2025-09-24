report 50104 "Zyn_Income Tracker Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Income_Tracker; "Income Entry")
        {
            DataItemTableView = sorting(Category);

            trigger OnAfterGetRecord()
            begin
                if (Income_Tracker.Date >= StartDate) and (Income_Tracker.Date <= EndDate) then begin
                    if (CategoryFilter = '') or (Income_Tracker.Category = CategoryFilter) then begin
                        ExcelBuffer.AddColumn(Income_Tracker.Category, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(Income_Tracker.Date, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn(Income_Tracker.Amount, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.NewRow();

                        TotalAmount += Income_Tracker.Amount;
                        RecordsFound := true;
                    end;
                end;
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
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                    field(CategoryFilter; CategoryFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Category';
                        TableRelation = "Income Category"."Code";
                    }
                }
            }
        }
    }

    var
        StartDate: Date;
        EndDate: Date;
        ExcelBuffer: Record "Excel Buffer" temporary;
        CategoryFilter: Text[50];
        TotalAmount: Decimal;
        RecordsFound: Boolean;

    trigger OnPreReport()
    begin
        ExcelBuffer.DeleteAll();
        TotalAmount := 0;
        RecordsFound := false;

        ExcelBuffer.AddColumn('Category', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn('Amount', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.NewRow();
    end;

    trigger OnPostReport()
    var
        FileName: Text;
    begin
        if not RecordsFound then begin
            ExcelBuffer.AddColumn('No data found for the selected filters.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.NewRow();
        end else begin
            ExcelBuffer.NewRow();
            ExcelBuffer.AddColumn('TOTAL', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(TotalAmount, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.NewRow();
        end;

        FileName := 'Income_Report_' +
                    (CategoryFilter <> '' ? CategoryFilter : 'All') + '_' +
                    Format(Today, 0, '<Year4><Month,2><Day,2>') + '.xlsx';

        ExcelBuffer.CreateNewBook('Income Tracker Report');
        ExcelBuffer.WriteSheet('Income', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(FileName);
        ExcelBuffer.OpenExcel();
    end;
}
