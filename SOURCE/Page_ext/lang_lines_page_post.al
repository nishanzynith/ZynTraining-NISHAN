pageextension 50124 "posted Invoice Page Ext" extends "Posted Sales Invoice"
{
    layout
    {
        addlast(content)
        {
            field("Beginning Text Code"; Rec."Invoice beginning Text code")
            {
                ApplicationArea = All;
                TableRelation = "Beginning Text Line".begintextcode;
                Editable = false;
            }
            part("Posted Beginning Text Subpage"; "Posted Beginning Text")
            {
                SubPageLink = "document_no." = FIELD("No."),
                Document_type = const("Posted"),
                Selection = const(Selection::Begining);
                ApplicationArea = all;
                editable = false;
            }

            field("Ending Text Code"; rec."invoice ending Text code")
            {
                ApplicationArea = All;
                TableRelation = "Beginning Text Line"."ending text";
                Editable = false;
            }
            part("Posted ending Text Subpage"; "Posted Ending Text")
            {
                SubPageLink = "document_no." = FIELD("No."),
                Document_type = const("Posted"),
                Selection = const(Selection::Ending);
                ApplicationArea = all;
                editable = false;
            }

            //    field("invoice Begining Text Code"; rec."Invoice beginning Text code")
            // {
            //     ApplicationArea = All;
            //     TableRelation = "Beginning Text Line"."ending text";
            //     Editable = false;
            // }

            //    field("Invoice Ending Text Code"; rec."invoice ending Text code")
            // {
            //     ApplicationArea = All;
            //     TableRelation = "Beginning Text Line"."ending text";
            //     Editable = false;
            // }
        }
    }
}
