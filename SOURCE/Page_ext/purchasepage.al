pageextension 50102 "Zyn_Purchase Order Ext" extends "Purchase Order"
{
    layout
    {
        addlast(General)
        {
            field("Approval Status"; rec."Approval Status")
            {
                Caption = 'Approval Status';
                ApplicationArea = All;
            }
        }
    }
}

