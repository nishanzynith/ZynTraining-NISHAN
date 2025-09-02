table 50108 "Leave Category"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(2; "Category Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Number of Days Allowed"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Category Name")
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
    var
        LeaveBal: Record "Leave Balance";
        Emp: Record "Employee Table";
    begin
        if Emp.FindSet() then
            repeat
                LeaveBal.Init();
                LeaveBal."Employee ID" := Emp."Emp ID";
                LeaveBal."Leave Category" := Rec."Category Name";
                LeaveBal."Remaining Days" := Rec."Number of Days Allowed";
                LeaveBal."Last Updated" := Today;
                LeaveBal.Insert();
            until Emp.Next() = 0;
    end;

    trigger OnModify()
    var
        LeaveBal: Record "Leave Balance";
    begin
        LeaveBal.SetRange("Leave Category", Rec."Category Name"); 
        if LeaveBal.FindFirst() then begin
            repeat
                LeaveBal."Remaining Days" := Rec."Number of Days Allowed";
                LeaveBal."Last Updated" := Today;
                LeaveBal.Modify();
            until LeaveBal.Next() = 0;
        end else begin
            LeaveBal.Init();
            LeaveBal."Leave Category" := Rec."Category Name";
            LeaveBal."Remaining Days" := Rec."Number of Days Allowed";
            LeaveBal."Last Updated" := Today;
            LeaveBal.Insert();
        end;
    end;

    trigger OnDelete()
    var
        LeaveBal: Record "Leave Balance";
        Emp: Record "Employee Table";
    begin
        LeaveBal.SetRange("Leave Category", "Category Name");
        LeaveBal.DeleteAll();

    end;

    trigger OnRename()
    begin

    end;

}