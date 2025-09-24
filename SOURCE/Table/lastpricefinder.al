table 50101 "Zyn_Last Price Finder"
{
    Caption = 'last price finder';
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "entry no"; integer)
        {
            caption = 'Entry no.';
            AutoIncrement = true;
            DataClassification = SystemMetadata;
        }
        field(5; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(3; "Item Price"; Decimal)
        {
            Caption = 'Item Price';
        }
        field(4; "Posting date"; Date)
        {
            Caption = 'Posting date';
        }


        field(7; "Line no."; Integer)
        {
            caption = 'Line no.';
        }

    }
    keys
    {
        key(PK; "Customer No.", "Item No.", "entry no")
        {
            Clustered = true;
        }
    }
}
