codeunit 50122 "Zyn_Customer Modify Logger"

{

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterModifyEvent', '', false, false)]

    local procedure LogCustomerChanges(var Rec: Record Customer; xRec: Record Customer)

    var

        RecRef: RecordRef;

        xRecRef: RecordRef;

        FieldRef: FieldRef;

        xFieldRef: FieldRef;

        ModifyLog: Record "Zyn_Modify Log Table";

        i: Integer;

    begin

        RecRef.GetTable(Rec);

        xRecRef.GetTable(xRec);

        for i := 1 to RecRef.FieldCount do begin

            FieldRef := RecRef.FieldIndex(i);

            xFieldRef := xRecRef.FieldIndex(i);

            if Format(FieldRef.Value) <> Format(xFieldRef.Value) then begin

                ModifyLog."Customer No." := Rec."No.";

                ModifyLog."Field Name" := FieldRef.Name;

                ModifyLog."Old Value" := Format(xFieldRef.Value);

                ModifyLog."New Value" := Format(FieldRef.Value);

                ModifyLog."Modified By" := UserId;

                ModifyLog.Insert();

            end;

        end;

    end;

}

