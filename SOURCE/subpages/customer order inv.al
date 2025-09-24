page 50107 "Zyn_CustomerSaleStatus Factbox"
{
    PageType = CardPart;
    Caption = 'Customer Sales Status';
    ApplicationArea = All;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            cuegroup(SalesDocuments)
            {
                Caption = 'Sales Documents';

                field(OpenSalesOrders; OpenSalesOrders)
                {
                    ApplicationArea = All;
                    Caption = 'Open Sales Orders';
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        SalesOrderList: Page "Sales Order List";
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                        SalesHeader.SetRange(Status, SalesHeader.Status::Open);
                        SalesHeader.SetRange("Sell-to Customer No.", Rec."No.");
                        SalesOrderList.SetTableView(SalesHeader);
                        SalesOrderList.Run();
                    end;
                }

                field(OpenSalesInvoices; OpenSalesInvoices)
                {
                    ApplicationArea = All;
                    Caption = 'Open Sales Invoices';
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        SalesInvoiceList: Page "Sales Invoice List";
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
                        SalesHeader.SetRange(Status, SalesHeader.Status::Open);
                        SalesHeader.SetRange("Sell-to Customer No.", Rec."No.");
                        SalesInvoiceList.SetTableView(SalesHeader);
                        SalesInvoiceList.Run();
                    end;
                }
            }
            // group("Customer Contact")
            // {
            //     Visible = HasContent;
            //     field("Contact No."; contactno)
            //     {
            //         ApplicationArea = All;
            //         // Caption = 'Contact ID';
            //         DrillDown = true;
            //         Lookup = true;
            //         trigger OnDrillDown()
            //         var
            //             ContactCard: Page "Contact Card";
            //         begin
            //             ContactCard.SetRecord(Rec);
            //             ContactCard.Run();
            //         end;
            //     }

            //     field("Contact Name";contactname)
            //     {
            //         ApplicationArea = All;
            //         // Caption = 'Contact Name';
            //         // DrillDown = true;
            //         // Lookup = true;
            //         // trigger OnDrillDown()
            //         // var
            //         //     ContactCard: Page "Contact Card";
            //         // begin
            //         //     ContactCard.SetRecord(Rec);
            //         //     ContactCard.Run();
            //         // end;
            //     }
            // }
        }
    }

    var
        OpenSalesOrders: Integer;
        OpenSalesInvoices: Integer;
        hascontent: Boolean;
        contactno: Code[20];
        contactname: Code[20];
        contact: record Contact;

    trigger OnAfterGetRecord()
    var
        SalesHeader: Record "Sales Header";
    begin
        //     clear(contactno);
        //     clear(contactname);
        //     hascontent := false;
        // if rec."Primary Contact No." <> '' then 
        // begin
        //     if contact.Get(rec."Primary Contact No.") then begin 
        //     contactno := contact."No.";
        //     contactname := contact.Name;
        //     hascontent := True;
        //     end;
        // end;

        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("Sell-to Customer No.", rec."No.");
        SalesHeader.SetRange(Status, SalesHeader.Status::Open);
        OpenSalesOrders := SalesHeader.Count();


        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.SetRange("Sell-to Customer No.", rec."No.");
        SalesHeader.SetRange(Status, SalesHeader.Status::Open);
        OpenSalesInvoices := SalesHeader.Count();
    end;
}
