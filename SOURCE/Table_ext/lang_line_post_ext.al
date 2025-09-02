tableextension 50123 "Sales Invoice Header Ext" extends "Sales Invoice Header"
{
    fields
    {
        field(50100; "Beginning Text Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50101; "Ending Text code"; code[20])
        {
            DataClassification = CustomerContent;
        }
            field(50102; "Invoice beginning Text code"; code[20])
        {
            DataClassification = CustomerContent;
        }
            field(50103; "invoice ending Text code"; code[20])
        {
            DataClassification = CustomerContent;
        }
    }
}
