codeunit 50123 Zyn_postsalesinv
{
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post", OnAfterSalesInvHeaderInsert, '', false, false)]
    procedure postedinvoice(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header")
    var
        PostedExtendedTextTable: Record "Beginning Text Line";
        ExtendedTextTable: Record "Beginning Text Line";
    begin
        SalesInvHeader."Beginning Text Code" := SalesHeader."Beginning Text Code";
        SalesInvHeader."Ending Text code" := SalesHeader."Ending text code";
        ExtendedTextTable.SetRange("document_no.", SalesHeader."No.");
        ExtendedTextTable.SetRange("Document_type", ExtendedTextTable."Document_type"::Invoice);


        if ExtendedTextTable.FindSet() then begin
            repeat
                PostedExtendedTextTable.Init();
                PostedExtendedTextTable."document_no." := SalesInvHeader."No.";
                PostedExtendedTextTable.Selection := ExtendedTextTable.Selection;
                PostedExtendedTextTable.begintextcode := ExtendedTextTable.begintextcode;
                PostedExtendedTextTable."Line No." := ExtendedTextTable."Line No.";
                PostedExtendedTextTable.Document_type := ExtendedTextTable."Document_Type"::"Posted";
                PostedExtendedTextTable.Text := ExtendedTextTable.Text;
                PostedExtendedTextTable.insert();

            until ExtendedTextTable.Next() = 0;
        end;
        ExtendedTextTable.SetRange("document_no.", SalesHeader."No.");
        if ExtendedTextTable.FindSet() then begin
            ExtendedTextTable.DeleteAll();
        end;
    end;

    // [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post", OnAfterSalesInvHeaderInsert, '', false, false)]
    // procedure postedendinvoice(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header")
    // var
    //     PostedExtendedTextTable: Record "Beginning Text Line";
    //     ExtendedTextTable: Record "Beginning Text Line";
    // begin
    //     SalesInvHeader."Ending Text code" := SalesHeader."Ending text code";
    //     ExtendedTextTable.SetRange("document_no.", SalesHeader."No.");

    //     if ExtendedTextTable.FindSet() then begin
    //         repeat
    //             PostedExtendedTextTable.Init();
    //             PostedExtendedTextTable."document_no." := SalesInvHeader."No.";
    //             PostedExtendedTextTable.Selection := ExtendedTextTable.Selection;
    //             PostedExtendedTextTable."ending text" := ExtendedTextTable."ending text";
    //             PostedExtendedTextTable."Line No." := ExtendedTextTable."Line No.";
    //             PostedExtendedTextTable.Document_type := ExtendedTextTable."Document_Type"::Posted;
    //             PostedExtendedTextTable.Text := ExtendedTextTable.Text;
    //             PostedExtendedTextTable.insert();

    //         until ExtendedTextTable.Next() = 0;
    //     end;
    //     ExtendedTextTable.SetRange("document_no.", SalesHeader."No.");
    //     if ExtendedTextTable.FindSet() then begin
    //         ExtendedTextTable.DeleteAll();
    //     end;
    // end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post", OnAfterSalesCrMemoHeaderInsert, '', false, false)]
    procedure postedcredit(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; WhseShip: Boolean; WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header"; var TempWhseRcptHeader: Record "Warehouse Receipt Header")
    var
        PostedExtendedTextTable: Record "Beginning Text Line";
        ExtendedTextTable: Record "Beginning Text Line";
    begin
        SalesCrMemoHeader."Beginning Text Code" := SalesHeader."Beginning Text Code";
        SalesCrMemoHeader."Ending Text code" := SalesHeader."Ending text code";
        ExtendedTextTable.SetRange("document_no.", SalesHeader."No.");

        if ExtendedTextTable.FindSet() then begin
            repeat
                PostedExtendedTextTable.Init();
                PostedExtendedTextTable."document_no." := SalesCrMemoHeader."No.";
                PostedExtendedTextTable.Selection := ExtendedTextTable.Selection;
                PostedExtendedTextTable.begintextcode := ExtendedTextTable.begintextcode;
                PostedExtendedTextTable."Line No." := ExtendedTextTable."Line No.";
                PostedExtendedTextTable.Document_type := ExtendedTextTable."Document_Type"::Posted;
                PostedExtendedTextTable.Text := ExtendedTextTable.Text;
                PostedExtendedTextTable.insert();

            until ExtendedTextTable.Next() = 0;
        end;
        ExtendedTextTable.SetRange("document_no.", SalesHeader."No.");
        if ExtendedTextTable.FindSet() then begin
            ExtendedTextTable.DeleteAll();
        end;
    end;

    //     [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post", OnAfterSalesCrMemoHeaderInsert, '', false, false)]
    //     procedure postedendcredit(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; WhseShip: Boolean; WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header"; var TempWhseRcptHeader: Record "Warehouse Receipt Header")
    //     var
    //         PostedExtendedTextTable: Record "Beginning Text Line";
    //         ExtendedTextTable: Record "Beginning Text Line";
    //     begin
    //         SalesCrMemoHeader."Ending Text code" := SalesHeader."Ending text code";
    //         ExtendedTextTable.SetRange("document_no.", SalesHeader."No.");

    //         if ExtendedTextTable.FindSet() then begin
    //             repeat
    //                 PostedExtendedTextTable.Init();
    //                 PostedExtendedTextTable."document_no." := SalesCrMemoHeader."No.";
    //                 PostedExtendedTextTable.Selection := ExtendedTextTable.Selection;
    //                 PostedExtendedTextTable."ending text" := ExtendedTextTable."ending text";
    //                 PostedExtendedTextTable."Line No." := ExtendedTextTable."Line No.";
    //                 PostedExtendedTextTable.Document_type := ExtendedTextTable."Document_Type"::Posted;
    //                 PostedExtendedTextTable.Text := ExtendedTextTable.Text;
    //                 PostedExtendedTextTable.insert();

    //             until ExtendedTextTable.Next() = 0;
    //         end;
    //         ExtendedTextTable.SetRange("document_no.", SalesHeader."No.");
    //         if ExtendedTextTable.FindSet() then begin
    //             ExtendedTextTable.DeleteAll();
    //         end;
    //     end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Quote to Order", OnAfterInsertSalesOrderHeader, '', false, false)]
    procedure postedQuotevar(SalesOrderHeader: Record "Sales Header"; SalesQuoteHeader: Record "Sales Header")
    var
        PostedExtendedTextTable: Record "Beginning Text Line";
        ExtendedTextTable: Record "Beginning Text Line";
    begin
        SalesOrderHeader."Beginning Text Code" := SalesQuoteHeader."Beginning Text Code";
        SalesOrderHeader."Ending Text code" := SalesQuoteHeader."Ending text code";
        ExtendedTextTable.SetRange("document_no.", SalesQuoteHeader."No.");

        if ExtendedTextTable.FindSet() then begin
            repeat
                PostedExtendedTextTable.Init();
                PostedExtendedTextTable."document_no." := SalesOrderHeader."No.";
                PostedExtendedTextTable.Selection := ExtendedTextTable.Selection;
                PostedExtendedTextTable.begintextcode := ExtendedTextTable.begintextcode;
                PostedExtendedTextTable."Line No." := ExtendedTextTable."Line No.";
                PostedExtendedTextTable.Text := ExtendedTextTable.Text;
                PostedExtendedTextTable.insert();

            until ExtendedTextTable.Next() = 0;
        end;
        ExtendedTextTable.SetRange("document_no.", SalesQuoteHeader."No.");
        if ExtendedTextTable.FindSet() then begin
            ExtendedTextTable.DeleteAll();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Quote to Invoice", OnAfterInsertSalesInvoiceLine, '', false, false)]
    procedure postedquoteInvoice(SalesQuoteLine: Record "Sales Line"; SalesQuoteHeader: Record "Sales Header"; var SalesInvoiceLine: Record "Sales Line"; SalesInvoiceHeader: Record "Sales Header")
    var
        PostedExtendedTextTable: Record "Beginning Text Line";
        ExtendedTextTable: Record "Beginning Text Line";
    begin
        SalesInvoiceHeader."Beginning Text Code" := SalesQuoteHeader."Beginning Text Code";
        SalesInvoiceHeader."Ending Text code" := SalesQuoteHeader."Ending text code";
        ExtendedTextTable.SetRange("document_no.", SalesQuoteHeader."No.");

        if ExtendedTextTable.FindSet() then begin
            repeat
                PostedExtendedTextTable.Init();
                PostedExtendedTextTable."document_no." := SalesInvoiceHeader."No.";
                PostedExtendedTextTable.Selection := ExtendedTextTable.Selection;
                PostedExtendedTextTable.begintextcode := ExtendedTextTable.begintextcode;
                PostedExtendedTextTable."Line No." := ExtendedTextTable."Line No.";
                PostedExtendedTextTable.Text := ExtendedTextTable.Text;
                PostedExtendedTextTable.insert();

            until ExtendedTextTable.Next() = 0;
        end;
        ExtendedTextTable.SetRange("document_no.", SalesQuoteHeader."No.");
        if ExtendedTextTable.FindSet() then begin
            ExtendedTextTable.DeleteAll();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post", OnAfterSalesInvHeaderInsert, '', false, false)]
    procedure postedorderinvoice(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header")
    var
        PostedExtendedTextTable: Record "Beginning Text Line";
        ExtendedTextTable: Record "Extended Text Line";
    begin
        SalesInvHeader."Invoice beginning Text code" := SalesHeader."Invoice begining Text Code";
        SalesInvHeader."invoice ending Text code" := SalesHeader."Invoice Ending Text Code";
        ExtendedTextTable.SetRange("No.", SalesInvHeader."Invoice beginning Text code");
        ExtendedTextTable.SetRange("Language Code", SalesHeader."Language Code");

        if SalesInvHeader."Invoice beginning Text code" <> '' then begin
            ExtendedTextTable.SetRange("No.", SalesInvHeader."Invoice beginning Text code");
            ExtendedTextTable.SetRange("Language Code", SalesHeader."Language Code");
            if ExtendedTextTable.FindSet() then begin
                repeat
                    PostedExtendedTextTable.Init();
                    PostedExtendedTextTable."document_no." := SalesInvHeader."No.";
                    PostedExtendedTextTable."Line No." := ExtendedTextTable."Line No.";
                    PostedExtendedTextTable.Document_type := PostedExtendedTextTable.Document_type::"Posted";
                    PostedExtendedTextTable.Text := ExtendedTextTable.Text;
                    PostedExtendedTextTable.Selection := PostedExtendedTextTable.Selection::Begining;
                    PostedExtendedTextTable.Insert();
                until ExtendedTextTable.Next() = 0;
            end;
        end;


        if SalesInvHeader."invoice ending Text code" <> '' then begin
            ExtendedTextTable.SetRange("No.", SalesInvHeader."invoice ending Text code");
            ExtendedTextTable.SetRange("Language Code", SalesHeader."Language Code");
            if ExtendedTextTable.FindSet() then begin
                repeat
                    PostedExtendedTextTable.Init();
                    PostedExtendedTextTable."document_no." := SalesInvHeader."No.";
                    PostedExtendedTextTable."Line No." := ExtendedTextTable."Line No.";
                    PostedExtendedTextTable.Document_type := PostedExtendedTextTable.Document_type::"Posted";
                    PostedExtendedTextTable.Text := ExtendedTextTable.Text;
                    PostedExtendedTextTable.Selection := PostedExtendedTextTable.Selection::Ending;
                    PostedExtendedTextTable.Insert();
                until ExtendedTextTable.Next() = 0;
            end;
        end;
    end;

    //     if PostedExtendedTextTable.FindSet() then begin
    //         repeat
    //             PostedExtendedTextTable.Init();
    //             PostedExtendedTextTable."document_no." := SalesInvHeader."No.";
    //             PostedExtendedTextTable.Document_type := PostedExtendedTextTable."Document_Type"::"Posted";
    //             PostedExtendedTextTable.Text := ExtendedTextTable.Text;
    //             PostedExtendedTextTable.Selection := PostedExtendedTextTable.Selection::Begining;
    //             PostedExtendedTextTable.insert();

    //         until ExtendedTextTable.Next() = 0;
    //     end;
    //     PostedExtendedTextTable.SetRange("document_no.", SalesHeader."No.");
    //     if PostedExtendedTextTable.FindSet() then begin
    //         PostedExtendedTextTable.DeleteAll();
    //     end;
    // end;


    // [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post", OnAfterSalesInvHeaderInsert, '', false, false)]
    // procedure postedorderinvoiceend(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header")
    // var
    //     PostedExtendedTextTable: Record "Beginning Text Line";
    //     ExtendedTextTable: Record "Extended Text Line";
    // begin
    //     SalesInvHeader."Invoice beginning Text code" := SalesHeader."Invoice begining Text Code";
    //     SalesInvHeader."invoice ending Text code" := SalesHeader."Invoice Ending Text Code";
    //     ExtendedTextTable.SetRange("No.", SalesInvHeader."invoice ending Text code");
    //     ExtendedTextTable.SetRange("Language Code", SalesHeader."Language Code");

    //     if PostedExtendedTextTable.FindSet() then begin
    //         repeat
    //             PostedExtendedTextTable.Init();
    //             PostedExtendedTextTable."document_no." := SalesInvHeader."No.";
    //             PostedExtendedTextTable.Document_type := PostedExtendedTextTable."Document_Type"::"Posted";
    //             PostedExtendedTextTable.Text := ExtendedTextTable.Text;
    //             PostedExtendedTextTable.Selection := PostedExtendedTextTable.Selection::Ending;
    //             PostedExtendedTextTable.insert();

    //         until ExtendedTextTable.Next() = 0;
    //     end;
    //     PostedExtendedTextTable.SetRange("document_no.", SalesHeader."No.");
    //     if PostedExtendedTextTable.FindSet() then begin
    //         PostedExtendedTextTable.DeleteAll();
    //     end;
    // end;
    procedure HandlingTextLines(
        SalesRec: Record "Sales Header";
        TextCode: Code[20];
        Selection: Enum Zyn_Selection)
    var
        ExtText: Record "Extended Text Line";
        Buffer: Record "Beginning Text Line";
        Customer: Record Customer;
        langcode: code[20];
    begin

        Buffer.SetRange("Customer No.", SalesRec."Sell-to Customer No.");
        Buffer.SetRange(Selection, Selection);
        Buffer.DeleteAll();

        if Customer.Get(SalesRec."Sell-to Customer No.") then
            langcode := Customer."Language Code";


        ExtText.SetRange("No.", TextCode);
        ExtText.SetRange("Language Code", langcode);

        if ExtText.FindSet() then begin
            repeat
                Buffer.Init();
                Buffer."Customer No." := SalesRec."Sell-to Customer No.";
                Buffer."document_no." := SalesRec."No.";
                Buffer.Document_type := SalesRec."Document Type";
                Buffer.begintextcode := TextCode;
                Buffer."Line No." := ExtText."Line No.";
                Buffer.Text := ExtText.Text;
                Buffer.Selection := Selection;
                Buffer.Insert();
            until ExtText.Next() = 0;
        end;
    end;



}
