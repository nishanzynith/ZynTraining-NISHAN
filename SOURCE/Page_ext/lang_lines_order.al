pageextension 50129 "Zyn_Sales Order Ext" extends "Sales Order"
{
    layout
    {
        addlast(content)
        {
            group("Beginning Text")
            {
                field("Beginning Text Code"; Rec."Beginning Text Code")
                {
                    ApplicationArea = All;
                    TableRelation = "Standard Text";
                }


                part(BeginningTextLines; "Zyn_Beginning Text Subpage")
                {

                    SubPageLink = "document_no." = FIELD("No."),
                    Selection = const(Zyn_Selection::Begining);
                    ApplicationArea = All;
                }


                field("Ending Text Code"; Rec."Ending text code")
                {
                    ApplicationArea = All;
                    TableRelation = "Standard Text";

                }



                part(Endingtextlines; "Zyn_Ending Text Subpage")
                {

                    SubPageLink = "document_no." = FIELD("No."),
                    "Selection" = const(Zyn_Selection::Ending);
                    ApplicationArea = All;
                }

                field("Invoice begining Code"; Rec."Invoice begining Text Code")
                {
                    ApplicationArea = All;
                    Caption = 'Invoice beginning';
                    TableRelation = "Standard Text";

                }


                field("Invoice Ending Code"; Rec."Invoice Ending Text Code")
                {
                    ApplicationArea = All;
                    Caption = 'Invoice Ending';
                    TableRelation = "Standard Text";

                }
            }
        }
        addlast(General)
        {

            field("Last Sold Price"; MyProcedure(rec."Sell-to Customer No."))
            {
                ApplicationArea = all;
                Caption = 'Last Sold Price';

            }
        }

    }
    local procedure MyProcedure("Customer No.": code[20]): Decimal
    var
        LastPriceFinder: Record "Zyn_Last Price Finder";
        salesinvline : record "Sales Invoice Line";
        LastDate: Date;
        lastPrice: Decimal;
    begin

        LastPriceFinder.SetRange("Customer No.", rec."Sell-to Customer No.");
        LastPriceFinder.SetCurrentKey("Customer No.", "Posting Date");
        if LastPriceFinder.FindLast() then
            LastDate := LastPriceFinder."Posting Date";

        LastPriceFinder.SetRange("Customer No.", rec."Sell-to Customer No.");
        LastPriceFinder.SetRange("Posting Date", LastDate);
        if LastPriceFinder.FindSet() then
            repeat
                if LastPriceFinder."Item Price" > lastPrice then
                    lastPrice := LastPriceFinder."Item Price";
            until LastPriceFinder.Next() = 0;
        exit(Lastprice);
           if LastPriceFinder.Get(salesinvline."Sell-to Customer No.", salesinvline."No.") then begin
        
        LastPriceFinder.Validate("Posting Date", LastDate);
        LastPriceFinder.Validate("Item Price", LastPrice);
        LastPriceFinder.Modify(true);
    end else begin
       
        LastPriceFinder.Init();
        LastPriceFinder.Validate("Customer No.", salesinvline."Sell-to Customer No.");
        LastPriceFinder.Validate("Item No.", salesinvline."No.");
        LastPriceFinder.Validate("Posting Date", LastDate);
        LastPriceFinder.Validate("Item Price", LastPrice);
        LastPriceFinder.Insert(true);
    end;
    end;
        

           
 
       var
        "Beginning Text Code": Code[20]; 

    }
    
    
   