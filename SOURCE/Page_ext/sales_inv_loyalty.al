pageextension 50110 "Zyn_Customer Loyalty points" extends "Customer List"
{
    layout
    {
        addlast(Control1)
        {
            field("Loyalty Points"; rec."Loyalty Points")
            {
                ApplicationArea = All;
            }
        }
    }
}
