pageextension 50128 "SalescreditExt" extends "Sales Credit Memo"
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

                    trigger OnValidate()
                    var
                        ExtText: Record "Extended Text Line";
                        Buffer: Record "Beginning Text Line";
                        Customer: Record Customer;
                        lineNo :Integer;
                    begin

                        Buffer.SetRange("Customer No.", Rec."Sell-to Customer No.");
                        buffer.DeleteAll();

    
                        if Customer.Get(Rec."Sell-to Customer No.") then begin
                            ExtText.SetRange("No.", Rec."Beginning Text Code");
                            ExtText.SetRange("Language Code", Customer."Language Code");

                            if ExtText.FindSet() then 
                            begin
                                repeat
                                    Buffer.Init();
                                    Buffer."Customer No." := Rec."Sell-to Customer No.";
                                    buffer."document_no." := Rec."No.";
                                    buffer.Document_type := rec."Document Type";
                                    Buffer.begintextcode := rec."Beginning Text Code";
                                    Buffer.Text := ExtText.Text;
                                    Buffer.Selection := buffer.Selection::"Begining";
                                    Buffer.Insert();
                                
                                until ExtText.Next() = 0;
                            end;
                        end;

                        CurrPage.BeginningTextLines.Page.SaveRecord();
                    end;
                }
            

                part(BeginningTextLines; "Beginning Text credit Subpage")
                {
                    SubPageLink = "document_no." = FIELD("No."),
                    Document_type = field("Document Type"),
                    Selection = const(Selection::Begining);
                    ApplicationArea = All;
             

                }
            

                field("Ending Text Code"; Rec."Ending text code")
                {
                    ApplicationArea = All;
                    TableRelation = "Standard Text";

                    trigger OnValidate()
                    var
                        ExtText: Record "Extended Text Line";
                        Buffer: Record "Beginning Text Line";
                        Customer: Record Customer;
                        lineNo :Integer;
                    begin
              
                        Buffer.SetRange("Customer No.", Rec."Sell-to Customer No.");
                        buffer.setrange(Selection,buffer.Selection::Ending);
                        buffer.DeleteAll();

                        if Customer.Get(Rec."Sell-to Customer No.") then begin
                            ExtText.SetRange("No.", Rec."Ending text code");
                            ExtText.SetRange("Language Code", Customer."Language Code");

                            if ExtText.FindSet() then 
                            begin
                                repeat
                                    Buffer.Init();
   
                                    Buffer."Customer No." := Rec."Sell-to Customer No.";
                                    buffer."document_no." := Rec."No.";
                                    buffer.Document_type := rec."Document Type";
                                    Buffer."ending text" := rec."Language Code";
                                    Buffer.Text := ExtText.Text;
                                    Buffer.Selection := buffer.Selection::Ending;
                                    Buffer.Insert();
  
                                until ExtText.Next() = 0;
                            end;
                        end;

                        CurrPage.Endingtextlines.Page.SaveRecord();
                    end;
                }
            
    

                part(Endingtextlines; "Ending Text Subpage")
                {
                    SubPageLink = "document_no." = FIELD("No."),
                     Document_type = field("Document Type"),
                    "Selection" = const(Selection::Ending);
                    ApplicationArea = All;

                }
            }
            }
    }
            
        
           var
        "Beginning Text Code": Code[20]; 
    }
    


 

