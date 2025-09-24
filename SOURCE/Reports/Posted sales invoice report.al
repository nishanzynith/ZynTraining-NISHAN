report 50137 "Zyn_Posted SalesInvoice Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    // DefaultRenderingLayout = LayoutName;
    DefaultLayout = RDLC;
    RDLCLayout = 'SOURCE/Layout/Postedinvreport.rdl';

    dataset
    {

        dataitem("posted data"; "Sales Invoice Header")
        {

            column(No_; "No.")
            {

            }
            column(Customer_Name; "Sell-to Customer Name")
            {

            }
            column(Posting_Date; Format("Posting Date"))
            {

            }
            column(Document_Date; Format("Document Date"))
            {

            }
            column(Company_Name; CompanyName)
            {

            }
            column(Logo; info.Picture)
            {

            }
            column(adress; info.Address)
            {

            }

            dataitem("Line data"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");

                column(Description; Description)
                {

                }

                column(Quantity; Quantity)
                {

                }
                column(Amount; "Amount")
                {

                }
                column(line_no; "Line No.")
                {

                }


            }
            dataitem("text data"; "Zyn_Beginning Text Line")
            {
                DataItemLinkReference = "posted data";
                DataItemLink = "document_no." = field("No.");


                column(TextLine; Text) { }
                column(TextType; Selection) { }

            }
            dataitem("Ledger Data"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("Sell-to Customer No."), "Document No." = field("No.");

                column(ledgeramount; "Amount (LCY)")
                {

                }
                column(Ledger_description; Description)
                {

                }

                column(Rem_amount; "Remaining Amount")
                {

                }
            }

        }
        // dataitem("text data"; "Beginning Text Line")
        // {
        //     DataItemLinkReference = "posted data";
        //     DataItemLink = "document_no." = field("No.");
        //     DataItemTableView = where(Selection = const(Selection::Begining));

        //     column(Text; Format(Text))
        //     {

        //     }

        // }
        // dataitem("end text data"; "Beginning Text Line")
        // {
        //     DataItemLinkReference = "posted data";
        //     DataItemLink = "document_no." = field("No.");
        //     DataItemTableView = where(Selection = const(Selection::Ending));

        //     column(end_Text; format(Text))
        //     {

        //     }

        // }
        //      dataitem("text data"; "Beginning Text Line")
        //             {
        //                 DataItemLinkReference = "posted data";
        //                 DataItemLink = "document_no." = field("No.");
        //                 // DataItemTableView = sorting("document_no.", "Line No.");

        //                 column(TextLine; Text) { }
        //                 column(TextType; Selection) { } 
        //                 // column(LineNo; "Line No.") { }
        //             }
    }

    trigger OnPreReport()
    begin

        info.Get();
        info.CalcFields(Picture);

    end;

    var
        myInt: Integer;

        info: record "Company Information";
    // begintext: text[200];
    // endtext: text[200];





}