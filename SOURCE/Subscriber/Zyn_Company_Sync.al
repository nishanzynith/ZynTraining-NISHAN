codeunit 50111 "Zyn_Company Sync"
{
    var
        IsSyncing: Boolean;

    [EventSubscriber(ObjectType::Table, Database::Company, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertCompany(var Rec: Record Company)
    var
        Zyn_Company: Record "Zynith_Company";
    begin
        if not Zyn_Company.Get(Rec.Name) then begin
            Zyn_Company.Init();
            Zyn_Company.Name := Rec.Name;
            Zyn_Company."Evaluation Company" := rec."Evaluation Company";
            Zyn_Company."Display Name" := Rec."Display Name";
            Zyn_Company.Id := rec.Id;
            Zyn_Company."Business Profile Id" := Rec."Business Profile Id";
            Zyn_Company.Insert();
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Company, 'OnAfterModifyEvent', '', true, true)]
    local procedure CompanyOnAfterModify(var Rec: Record Company; var xRec: Record Company)
    var
        Zynith: Record "Zynith_Company";
    begin
        if IsSyncing then
            exit;

        IsSyncing := true;

        if Zynith.Get(Rec.Name) then begin
            if (Zynith."Display Name" <> Rec."Display Name") or
               (Zynith."Evaluation Company" <> Rec."Evaluation Company") or
               (Zynith."Business Profile Id" <> Rec."Business Profile Id") then begin
                Zynith."Display Name" := Rec."Display Name";
                Zynith."Evaluation Company" := Rec."Evaluation Company";
                Zynith."Business Profile Id" := Rec."Business Profile Id";
                Zynith.Modify(true);
            end;
        end;
        IsSyncing := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::Company, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeleteCompany(var Rec: Record Company)
    var
        Zyn_Company: Record "Zynith_Company";
    begin
        if Zyn_Company.Get(Rec.Name) then
            Zyn_Company.Delete();
    end;
    //------------------------------------------------------------------------------------ 
    //The below lines are for syncronizing the zynith company table to the system table.
    // -----------------------------------------------------------------------------------
    [EventSubscriber(ObjectType::Table, Database::"Zynith_Company", 'OnAfterInsertEvent', '', true, true)]
    local procedure ZynithCompanyOnAfterInsert(var Rec: Record "Zynith_Company")
    var
        Sys_Company: Record Company;
    begin
        if not Sys_Company.Get(Rec.Name) then begin
            Sys_Company.Init();
            Sys_Company.TransferFields(Rec); // false = don’t overwrite existing fields not in Rec
            if Rec.Id.ToText() = '' then
                Sys_Company.Id := CreateGuid();
            Sys_Company.Insert();
            Sys_Company.TransferFields(Rec); // false = don’t overwrite existing fields not in Rec
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Zynith_Company", 'OnAfterModifyEvent', '', true, true)]
    local procedure ZynithCompanyOnAfterModify(var Rec: Record "Zynith_Company")
    var
        Sys_Company: Record Company;
    begin
        if IsSyncing then
            exit;

        IsSyncing := true;

        if Sys_Company.Get(Rec.Name) then begin
            if (Sys_Company."Display Name" <> Rec."Display Name") or
               (Sys_Company."Evaluation Company" <> Rec."Evaluation Company") or
               (Sys_Company."Business Profile Id" <> Rec."Business Profile Id") then begin
                Sys_Company."Display Name" := Rec."Display Name";
                Sys_Company."Evaluation Company" := Rec."Evaluation Company";
                Sys_Company."Business Profile Id" := Rec."Business Profile Id";
                Sys_Company.Modify(true);
            end;
        end;

        IsSyncing := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Zynith_Company", 'OnAfterDeleteEvent', '', true, true)]
    local procedure ZynithCompanyOnAfterDelete(var Rec: Record "Zynith_Company")
    var
        Sys_Company: Record Company;
    begin
        if Sys_Company.Get(Rec.Name) then
            Sys_Company.Delete();
    end;
}
