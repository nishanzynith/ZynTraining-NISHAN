table 50106 "Employee Table"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "Emp ID"; code[10])
        {
            DataClassification = ToBeClassified;
            editable = false;
        }
        field(2; "Employee Name"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Department"; enum "Zyn_Employee Department")
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Role"; enum "Zyn_Employee Roles")
        {
            DataClassification = ToBeClassified;
            // trigger OnLookup()
            // var
            //     RoleBuf: Record "Buffer Field" temporary;
            // begin

            //     RoleBuf.DeleteAll();

            //     case Rec."Department" of
            //         Rec."Department"::HR:
            //             InsertRole(RoleBuf, format(Enum::"Employee Roles"::"HR employee"));

            //         Rec."Department"::Developing:
            //             begin
            //                 InsertRole(RoleBuf, format(Enum::"Employee Roles"::"Junior Developer"));
            //                 InsertRole(RoleBuf, format(Enum::"Employee Roles"::Developer));
            //                 InsertRole(RoleBuf, format(Enum::"Employee Roles"::"Senior Developer"));
            //             end;

            //         // Rec."Department"::Finance:
            //         //     begin
            //         //         InsertRole(RoleBuf, 1, Enum::"Employee Roles"::Tax);
            //         //         InsertRole(RoleBuf, 2, Enum::"Employee Roles"::Audit);
            //         //     end;
            //     end;

            //     if Page.RunModal(Page::"Field Buffer List", RoleBuf) = Action::LookupOK then begin
            //         RoleBuf.FindFirst();
            //         Rec."Role" := RoleBuf."Field Name"; // set selected role back
            //     end;
            // end;

        }



    }

    keys
    {
        key(PK; "Emp ID", "Employee Name")
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

    // local procedure InsertRole(var RoleBuf: Record "Buffer Field" temporary; RoleTxt: Text)
    // begin
    //     RoleBuf.Init();
    //     RoleBuf."Field Name" := RoleTxt;
    //     RoleBuf.Insert();
    // end;

    trigger OnInsert()
    var
        LastTech: Record "Employee Table";
        LastId: Integer;
        LeaveBal: Record "Leave Balance";
        LeaveCat: Record "Leave Category";

    begin
        if "Emp ID" = '' then begin
            if LastTech.FindLast() then
                Evaluate(LastId, CopyStr(LastTech."Emp ID", 2))
            else
                LastId := 99;

            "Emp ID" := 'E' + Format(LastId + 1);
        end;

        if LeaveCat.FindSet() then
            repeat
                LeaveBal.Init();
                LeaveBal."Employee ID" := Rec."Emp ID";
                LeaveBal."Leave Category" := LeaveCat."Category Name";
                LeaveBal."Remaining Days" := LeaveCat."Number of Days Allowed";
                LeaveBal."Last Updated" := Today;
                LeaveBal.Insert();
            until LeaveCat.Next() = 0;
    end;

    trigger OnModify()
    var
        LeaveBal: Record "Leave Balance";
        LeaveCat: Record "Leave Category";
    begin
        if LeaveCat.FindSet() then
            repeat
                if not LeaveBal.Get(Rec."Emp ID", LeaveCat."Category Name") then begin
                    LeaveBal.Init();
                    LeaveBal."Employee ID" := Rec."Emp ID";
                    LeaveBal."Leave Category" := LeaveCat."Category Name";
                    LeaveBal."Remaining Days" := LeaveCat."Number of Days Allowed";
                    LeaveBal."Last Updated" := Today;
                    LeaveBal.Insert();
                end;
            until LeaveCat.Next() = 0;
    end;



    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}