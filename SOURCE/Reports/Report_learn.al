report 50134 Datareport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    // DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            // RequestFilterFields = "No.";

            DataItemTableView = where("Document Type" = const(Order),
                                       Status = const(Open));

            trigger OnAfterGetRecord()
            begin
                "Sales Header".SetRange("Posting Date", oldpostingdate);
                if "Sales Header"."Posting Date" <> NewPostingDate then begin
                    "Sales Header"."Posting Date" := NewPostingDate;
                    "Sales Header".Modify();
                    Counting += 1;
                end;
            end;

        }
    }

    requestpage
    {
        // AboutTitle = 'Teaching tip title';
        // AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(NewPostingDate; NewPostingDate)
                    {

                    }
                    field(Oldpostingdate; OldPostingDate)
                    {

                    }
                }
            }
        }

        // actions
        // {
        //     area(processing)
        //     {
        //         action(LayoutName)
        //         {

        //         }

        //     }

        // }

        // trigger OnOpenPage()

        // begin
        //     Message('Hi this is the open page !!');
        // end;
    }

    trigger OnInitReport()
    begin
        NewPostingDate := WorkDate();
        oldpostingdate := WorkDate();
    end;

    // trigger OnPreReport()
    // begin
    //     Message('This is prereport !')
    // end;

    // trigger OnPostReport()
    // begin
    //     Message('This is post report !!')
    // end;

    
    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = Excel;
    //         LayoutFile = 'mySpreadsheet.xlsx';
    //     }
    // }

    trigger OnPostReport()
    begin
        Message('%1 open sales orders were updated with new posting date %2 from %3.',
            Counting, Format(NewPostingDate),Format(oldpostingdate));
    end;

    var
        NewPostingDate: Date;
        Counting: Integer;
        oldpostingdate: Date;
}