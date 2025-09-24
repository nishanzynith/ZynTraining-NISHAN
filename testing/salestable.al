tableextension 50113 "Salestableext" extends "Sales Header"
{
    fields
    {
        field(50106; "summa"; Enum "Zyn_Purchase Approval Status")
        {
            Caption = 'Approval Status';
            DataClassification = ToBeClassified;
            InitValue = Open; // Start as "Open"
        }
    }
}