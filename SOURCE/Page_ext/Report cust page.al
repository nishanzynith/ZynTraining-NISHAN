pageextension 50137 "Bank Report ext" extends "Customer List"
{
    actions
    {
        addlast(processing)
        {
            action(BankReport)
            {
                ApplicationArea = All;
                Caption = 'Bank Report';
                Image = BankAccountStatement;
                trigger OnAction()
                begin
                    Report.run(Report::"Zyn_Bank Account Report")
                end;
            }
        }
        addfirst(processing)
        {
            action(Postedinvreport)
            {
                ApplicationArea = All;
                Caption = 'PSInvoice Report';
                Image = PostedCreditMemo;
                trigger OnAction()
                begin
                    Report.run(Report::"Zyn_Posted SalesInvoice Report")
                end;
            }
        }
    }
    // trigger OnOpenPage()

    // var
    //     StartCM: Date;
    //     EndCM: Date;
    //     StartCQ: Date;
    //     EndCQ: Date;
    // begin
    //     StartCM := CalcDate('-CM');
    //     EndCM := CalcDate('<CM>', WorkDate());
    //     StartCQ := CalcDate('-CQ', WorkDate());
    //     EndCQ := CalcDate('<CQ>');

    //     Message(
    //         'WorkDate: %1\Start of Month (-CM): %2\End of Month (<CM>): %3\Start of Quarter (-CQ): %4\End of Quarter (<CQ>): %5',
    //         WorkDate(), StartCM, EndCM, StartCQ, EndCQ);
    // end;

}