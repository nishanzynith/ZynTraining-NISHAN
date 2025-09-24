tableextension 50101 "Purchase Header Ext" extends "Purchase Header"
{
    fields
    {
        field(50100; "Approval Status"; Enum "Zyn_Purchase Approval Status")
        {
            Caption = 'Approval Status';
            DataClassification = ToBeClassified;
            InitValue = Open;
        }
    }
}
