tableextension 50103 "Zyn_Langlines Header Ext" extends "Sales Header"
{
    fields
    {
        field(50000; "Beginning Text Code"; Code[20])
        {
            Caption = 'Beginning Text Code';
            DataClassification = CustomerContent;

            trigger OnValidate()

            var
                TextLineHandler: Codeunit Zyn_postsalesinv;
            begin
                TextLineHandler.HandlingTextLines(Rec, Rec."Beginning Text Code", Enum::Zyn_Selection::Begining);
            end;
            // var
            //     ExtText: Record "Extended Text Line";
            //     Buffer: Record "Beginning Text Line";
            //     Customer: Record Customer;
            //     lineNo: Integer;
            // begin

            //     Buffer.SetRange("Customer No.", Rec."Sell-to Customer No.");
            //     buffer.DeleteAll();

            //     if Customer.Get(Rec."Sell-to Customer No.") then begin
            //         ExtText.SetRange("No.", Rec."Beginning Text Code");
            //         ExtText.SetRange("Language Code", Customer."Language Code");

            //         if ExtText.FindSet() then begin
            //             repeat
            //                 Buffer.Init();

            //                 Buffer."Customer No." := Rec."Sell-to Customer No.";
            //                 buffer."document_no." := Rec."No.";
            //                 buffer.Document_type := rec."Document Type";
            //                 Buffer.begintextcode := rec."Beginning Text Code";
            //                 Buffer.Text := ExtText.Text;
            //                 Buffer.Selection := buffer.Selection::"Begining";
            //                 Buffer.Insert();

            //             until ExtText.Next() = 0;
            //         end;
            //     end;

            //     // CurrPage.BeginningTextLines.Page.SaveRecord();
            // end;

        }

        field(500001; "Ending text code"; code[20])
        {
            caption = 'Ending text code';
            DataClassification = CustomerContent;
            trigger OnValidate()

            var
                TextLineHandler: Codeunit Zyn_postsalesinv;
            begin
                TextLineHandler.HandlingTextLines(Rec, Rec."Ending text code", Enum::Zyn_Selection::Ending);
            end;
            // var
            //     ExtText: Record "Extended Text Line";
            //     Buffer: Record "Beginning Text Line";
            //     Customer: Record Customer;
            // begin

            //     Buffer.SetRange("Customer No.", Rec."Sell-to Customer No.");
            //     buffer.setrange(Selection, buffer.Selection::Ending);
            //     buffer.DeleteAll();

            //     if Customer.Get(Rec."Sell-to Customer No.") then begin
            //         ExtText.SetRange("No.", Rec."Ending text code");
            //         ExtText.SetRange("Language Code", Customer."Language Code");

            //         if ExtText.FindSet() then begin
            //             repeat
            //                 Buffer.Init();

            //                 Buffer."Customer No." := Rec."Sell-to Customer No.";
            //                 buffer."document_no." := Rec."No.";
            //                 buffer.Document_type := rec."Document Type";
            //                 Buffer."ending text" := rec."Ending text code";
            //                 Buffer.Text := ExtText.Text;
            //                 Buffer.Selection := buffer.Selection::Ending;
            //                 Buffer.Insert();

            //             until ExtText.Next() = 0;
            //         end;
            //     end;

            //     // CurrPage.Endingtextlines.Page.SaveRecord();
            // end;


        }
        field(50003; "Invoice begining Text Code"; Code[20])
        {
            Caption = 'Invoice begining Text Code';
            DataClassification = CustomerContent;

        }

        field(50004; "Invoice Ending Text Code"; Code[20])
        {
            Caption = 'Invoice Ending Text Code';
            DataClassification = CustomerContent;

        }

        field(50109; lastsoldprice; Decimal)
        {
            caption = 'Last Sold Price';
            // FieldClass = FlowField;
            // CalcFormula = max("last price finder"."Item Price" where("Customer No." = field("Sell-to Customer No."), "Posting date" = field("Posting Date")));
            DataClassification = SystemMetadata;
        }


    }
    trigger OnDelete()
    var
        BeginningTextLine: Record "Zyn_Beginning Text Line";
        EndingTextLine: Record "Zyn_Beginning Text Line";
    begin

        BeginningTextLine.SetRange("document_no.", Rec."No.");
        BeginningTextLine.SetRange(Selection, Zyn_Selection::Begining);
        BeginningTextLine.DeleteAll();


        EndingTextLine.SetRange("document_no.", Rec."No.");
        EndingTextLine.SetRange(Selection, Zyn_Selection::Ending);
        EndingTextLine.DeleteAll();
    end;

}
