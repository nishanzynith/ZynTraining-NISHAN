pageextension 50109 "salespageext" extends "Sales Quote"
{
    layout
    {
        addlast(General)
        {
            field("Approval Status"; rec."summa")
            {
                Caption = 'summa kodu';
                ApplicationArea = All;
            }
        }
    }
}