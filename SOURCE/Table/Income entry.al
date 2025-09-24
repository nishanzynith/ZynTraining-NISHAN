table 50140 "Income Entry"
{
    Caption = 'Income Entry';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }

        field(2; "Date"; Date)
        {
            Caption = 'Date';

        }

        field(3; "Category"; Code[20])
        {
            Caption = 'Category';
            TableRelation = "Zyn_Income Category"."Code";
        }

        field(4; "Description"; Text[100])
        {
            Caption = 'Description';
        }

        field(5; "Amount"; Decimal)
        {
            Caption = 'Amount';
            DecimalPlaces = 0 : 2;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }

        key(DateIdx; "Date")
        {
        }

        key(CategoryIdx; "Category")
        {
        }
    }


}
