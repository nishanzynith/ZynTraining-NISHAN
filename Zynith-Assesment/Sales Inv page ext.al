pageextension 50138 "Sales Invoice Ext" extends "Sales Invoice"
{
    layout
    {
        addlast(General) 
        {
            field("Subscription ID"; Rec."Subscription ID")
            {
                ApplicationArea = All;
                Editable = false;
            }

            field("Subscription Name";Rec."Subscription Name")
            {
                ApplicationArea = All;
                Editable = false;
            }

            field("Subscription Amount"; Rec."Subscription Amount")
            {
                ApplicationArea = All;
                Editable = false;
            }

            field("From Subscription";Rec."From Subscription")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}