table 50122 "Zyn_Posted Beginning Text Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20]) { DataClassification = SystemMetadata; }
        field(2; "Line No."; Integer)
        {
            DataClassification = SystemMetadata;
        }
        field(3; "Text"; Text[100]) { }

        field(4; "document type"; enum "Sales Document Type")
        {
            DataClassification = SystemMetadata;
        }

        field(5; text_code; code[20])
        {
            DataClassification = CustomerContent;
        }

        field(6; entery_no; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No.", entery_no, Text) { Clustered = true; }
    }
}
