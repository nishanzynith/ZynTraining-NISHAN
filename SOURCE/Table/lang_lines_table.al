table 50100 "Beginning Text Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = SystemMetadata;
            //AutoIncrement = true;
        }
        field(3; Text; Text[100])
        {
            DataClassification = CustomerContent;
        }

        field(4; "document_no."; code[20])
        {
            DataClassification = CustomerContent;
        }

        field(5; "Document_type"; enum "Sales Document Type")
        {
            DataClassification = SystemMetadata;
        }

        field(6; "begintextcode"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(7; "ending text"; code[20])
        {
            DataClassification = CustomerContent;
        }

        field(8; Selection; enum Selection)
        {
            DataClassification = CustomerContent;
        }
        field(9;num;integer)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Line No.", text, "Customer No.", "document_no.", Selection,Document_type,num)
        {
            Clustered = true;
        }
    }
}
