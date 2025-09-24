pageextension 50131 "Zyn_Sales Quote Ext" extends "Sales Quote"
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
            }
            }
    }
            
        
           var
        "Beginning Text Code": Code[20]; 
    }
    