table 50121 "Zynith_Company"
{
    Caption = 'Zynith Company';

    fields
    {
        field(1; Name; Text[30])
        {
            Caption = 'Name';
            trigger OnValidate()
            begin
                if xRec.Name <> '' then
                    Error('Name cannot be changed once filled.');
            end;
        }
        field(2; "Evaluation Company"; Boolean)
        {
            Caption = 'Evaluation Company';
        }
        field(3; "Display Name"; Text[250])
        {
            Caption = 'Display Name';
        }
        field(8000; Id; Guid)
        {
            Caption = 'Id';
        }
        field(8005; "Business Profile Id"; Text[250])
        {
            Caption = 'Business Profile Id';
        }
    }

    keys
    {
        key(Key1; Name)
        {
            Clustered = true;
        }
    }

    // trigger OnInsert()
    // var
    //     Sys_Company: Record Company;
    // begin
    //     if Rec.Get(Rec.Name) then begin
    //         Rec.Init();
    //         if Rec.Id.ToText() = '' then
    //             Rec.Id := CreateGuid(); // Ensure non-empty GUID
    //         Rec.Insert(true);
    //     end;
    // end;

    // trigger OnModify()
    // var
    //     Sys_Company: Record Company;
    // begin
    //     if Sys_Company.Get(Rec.Name) then begin
    //         Sys_Company."Evaluation Company" := rec."Evaluation Company";
    //         Sys_Company."Display Name" := Rec."Display Name";
    //         Sys_Company.Id := rec.Id;
    //         Sys_Company."Business Profile Id" := Rec."Business Profile Id";;
    //         Sys_Company.Modify();
    //     end;
    // end;

    // trigger OnDelete()
    // var
    //     Sys_Company: Record Company;
    // begin
    //     if Sys_Company.Get(Rec.Name) then
    //         Sys_Company.Delete();
    // end;
}