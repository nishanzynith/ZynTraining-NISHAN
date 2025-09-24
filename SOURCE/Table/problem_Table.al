table 50107 "Customer Problem"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }

        field(2; "Customer No."; Code[20])
        {
            // TableRelation = Customer."No.";
            DataClassification = SystemMetadata;
        }

        field(3; Problem; Enum "Zyn_Problem Type")
        {
            DataClassification = CustomerContent;
        }
        field(4; Department; Enum "Zyn_Depatment_enum")
        {
            DataClassification = CustomerContent;
        }

        field(5; Technician; Text[80])
        {
            DataClassification = ToBeClassified;
            TableRelation = Technician_table."Tech ID" where(department = field(Department));
        }

        field(6; "Problem Description"; Text[250])
        {
            DataClassification = CustomerContent;
        }

        field(7; "Report Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(8; "customer Name"; Text[250])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
    }
}