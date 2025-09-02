pageextension 50110 cusloyaltypoints extends "Customer List"
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
