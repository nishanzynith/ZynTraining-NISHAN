pageextension 50130 "posted credit Page Ext" extends "Posted Sales Credit Memo"
{
    layout
    {
        addlast(content)
        {
            field("Beginning Text Code"; Rec."Beginning Text Code")
            {
                ApplicationArea = All;
                TableRelation = "Beginning Text Line".begintextcode;
                Editable = false;
            }
            part("Posted Beginning Text Subpage"; "Posted Beginning Text")
            {
                SubPageLink = "document_no." = FIELD("No."),
                Selection = const(Zyn_Selection::Begining);
                ApplicationArea = all;
                editable = false;
            }

            field("Ending Text Code"; rec."Ending Text code")
            {
                ApplicationArea = All;
                TableRelation = "Beginning Text Line"."ending text";
                Editable = false;
            }
            part("Posted ending Text Subpage"; "Posted Ending Text")
            {
                SubPageLink = "document_no." = FIELD("No."),
                Selection = const(Zyn_Selection::Ending);
                ApplicationArea = all;
                editable = false;
            }
        }
    }
}
