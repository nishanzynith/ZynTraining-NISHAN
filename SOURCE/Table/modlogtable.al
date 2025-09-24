table 50115 "Zyn_Modify Log Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry no."; integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = True;
        }
        field(2; "Customer No."; code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = Customer."No.";
        }
        field(3; "Field Name"; Text[100])
        {
            DataClassification = SystemMetadata;
        }
        field(4; "Modified By"; Code[50])
        {
            DataClassification = SystemMetadata;
        }

        field(5; "Old Value"; Code[100])
        {
            DataClassification = SystemMetadata;
        }

        field(6; "New Value"; Code[100])
        {
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Entry no.", "Customer No.", "Field Name", "Modified By", "New Value", "Old Value")
        {
            Clustered = true;
        }
    }
}
