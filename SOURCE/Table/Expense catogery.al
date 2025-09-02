table 50150 "Expense Category"
{
    DataClassification = ToBeClassified;
    Caption = 'Expense Category';

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code';
        }

        field(2; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }

    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
