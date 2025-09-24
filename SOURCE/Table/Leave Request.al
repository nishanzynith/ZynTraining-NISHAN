table 50109 "Leave Request"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EntryID; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(2; "Employee ID"; code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employee Table"."Emp ID";

        }

        field(3; "Leave Category"; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Leave Category"."Category Name";

        }

        field(4; Reason; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(7; Status; enum "Zyn_Leave Approval Status")
        {
            DataClassification = ToBeClassified;
            InitValue = Pending;
        }

        field(8; "Remaining Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; EntryID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        if (Status.AsInteger() = 1) or (Status.AsInteger() = 2) then
            Error('Cannot delete the given data');

    end;

    trigger OnRename()
    begin

    end;

}