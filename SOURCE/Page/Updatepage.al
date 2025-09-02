PAGE 50112 UpdatePage
{

    layout
    {


        area(Content)
        {


            field(TableName; TableName)
            {
                Caption = 'TableName';
                ApplicationArea = All;
                TableRelation = "AllObjWithCaption"."Object ID" where("Object Type" = const(Table));

                // DrillDown = True;

                // trigger OnDrillDown()
                // begin

                // end;
            }

            field(FieldName; FieldName)
            {
                Caption = 'FieldName';
                ApplicationArea = All;
                DrillDown = True;
                // TableRelation = Field.TableName where (TableName = const(Database::Field));
                Trigger OnDrillDown()
                var
                    RecRef: RecordRef;
                    FieldRef: FieldRef;
                    TempBuffer: Record "Buffer Field" temporary;
                    i: Integer;
                    FN: Text[250];
                begin
                    if TableName = 0 then
                        Error('Please select a table first.');

                    RecRef.Open(TableName);

                    for i := 1 to RecRef.FieldCount do begin
                        FieldRef := RecRef.FieldIndex(i);
                        TempBuffer.Init();
                        TempBuffer."Field ID" := FieldRef.Number;
                        FN := FieldRef.Name;
                        TempBuffer."Field Name" := FN;
                        TempBuffer.Insert();
                    end;

                    RecRef.Close();

                    if Page.RunModal(Page::"Field Buffer List", TempBuffer, selectedcust) = Action::LookupOK then begin
                        FieldID := TempBuffer."Field ID";
                        FieldName := TempBuffer."Field Name";
                    end;
                end;

            }
            field(RecordSecltion; RecordSecltion)
            {
                Caption = 'RecordSecltion';
                ApplicationArea = All;
                trigger OnDrillDown()
                var
                    RecRef: RecordRef;
                    FieldRef: FieldRef;
                    TempValueBuffer: Record "Buffer Field" temporary;
                    LineNo: Integer;
                begin
                    if (TableName = 0) OR (fieldid = 0) then
                        Error('Please select a table and field first.');

                    RecRef.Open(TableName);
                    FieldRef := RecRef.Field(fieldid);

                    if RecRef.FindSet() then begin
                        repeat
                            LineNo += 1;
                            TempValueBuffer.Init();
                            TempValueBuffer."Field ID" := LineNo;
                            TempValueBuffer."Field Name" := Format(FieldRef.Value);
                            TempValueBuffer."Record ID" := RecRef.RecordId;
                            TempValueBuffer.Insert();
                        until RecRef.Next() = 0;

                        RecRef.Close();

                        if Page.RunModal(Page::"Field Buffer List", TempValueBuffer, selectedcust) = Action::LookupOK then 
                        begin

                            RecordSecltion := TempValueBuffer."Field Name";
                            valueID := TempValueBuffer."Record ID";

                        end;
                    end;
                end;
            }

            field(Value_To_Enter; Value_To_Enter)
            {
                Caption = 'Value';
                ApplicationArea = All;
                trigger OnValidate()
                var
                    RecRef: RecordRef;
                    FieldRef: FieldRef;

                begin

                    RecRef.Open(TableName);


                    if not RecRef.Get(valueID) then
                        Error('Could not find the selected record.');

                    FieldRef := RecRef.Field(FieldID);
                    FieldRef.Value := Value_To_Enter;
                    RecRef.Modify();

                    Message('Value updated successfully.');
                    CurrPage.Close();
                end;


            }

        }

    }
    var
        TableName: Integer;
        FieldName: Text[250];
        RecordSecltion: Text[250];
        Value_To_Enter: Text[250];
        TableID: Integer;
        FieldID: Integer;
        Object: Integer;
        selectedcust: Integer;
        valueID: RecordId;
        
}



// procedure ListFieldsFromTable(TableID: Integer)
// var
//     RecRef: RecordRef;
//     FieldRef: FieldRef;
//     i: Integer;
//     MsgText: Text;
// begin
//     RecRef.Open(TableID); // Open the table dynamically using Table ID

//     for i := 1 to RecRef.FieldCount do begin
//         FieldRef := RecRef.FieldIndex(i);
//     end;
//     FieldRef := RecRef.FieldIndex(i);


//     RecRef.Close;
// end;

