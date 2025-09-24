tableextension 50127 "Zyn_Langlines Credit Memo Ext" extends "Sales Cr.Memo Header"
{
    fields
    {
        field(50000; "Beginning Text Code"; Code[20])
        {
            Caption = 'Beginning Text Code';
            DataClassification = CustomerContent;
        }

        field (500001;"Ending text code";code[20])
        {
            caption = 'Ending text code';
            DataClassification = CustomerContent;
        }
    }
}
