table 50110 "Zyn_Leave Balance"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Employee ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(2; "Leave Category"; Code[50])
        {
            DataClassification = CustomerContent;
        }

        field(3; "Remaining Days"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(4; "Last Updated"; Date)
        {
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Employee ID", "Leave Category")
        {
            Clustered = true;
        }
    }
}
