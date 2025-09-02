report 50135 "Invoice report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    // DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("sale invoice"; "Sales Header")
        {
            // RequestFilterFields = "No.","Document Type";

            DataItemTableView = where("Document Type" = const(Invoice));

            trigger OnPreDataItem()
            var
                saleheader: Record "Sales Header";
                salesheaderRef: RecordRef;
                FieldRef: FieldRef;
                MatchingCustomers: Text;
                i: integer;
            begin

                if "sale invoice".HasFilter() then
                    exit;

                if (filteringname = 0) or (filteringvalue = '') then begin
                    error('There is no selection in the page !!')
                end;

                salesheaderRef.Get(valueID);
                FieldRef := salesheaderRef.field(filteringname);
                SelectedFieldValue := Format(FieldRef.Value);

                saleheader.Reset();
                saleheader.SetRange("Document Type", saleheader."Document Type"::Invoice);
                if saleheader.FindSet() then begin
                    repeat
                        saleheader.Get(saleheader.RecordId());
                        FieldRef := SalesHeaderRef.Field(filteringname);

                        if format(FieldRef.Value) = SelectedFieldValue then begin
                            Found := true;
                        end;
                    until SalesHeaderref.Next() = 0;
                end;
            end;


            trigger OnAfterGetRecord()
            begin
                // if Found then begin
                "sale invoice".SetRange("Document Type","sale invoice"."Document Type"::Invoice);
                "sale invoice".SetRange("No.", "sale invoice"."No.");

                SalesPost.Run("sale invoice");
                myint += 1;
                // end;
            end;

        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(filteringname; Filteringname)
                    {
                        trigger OnDrillDown()
                        var
                            RecRef: RecordRef;
                            FieldRef: FieldRef;
                            TempBuffer: Record "Buffer Field" temporary;
                            i: Integer;
                            FN: Text[250];
                        begin

                            RecRef.Open(Database::"Sales Header");


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

                                RecordSelection := TempBuffer."Field Name";
                                valueID := TempBuffer."Record ID";
                                filteringname := TempBuffer."Field ID";

                            end;
                        end;
                    }

                    field(filteringvalue; filteringvalue)
                    {
                        trigger OnDrillDown()
                        var
                            RecRef: RecordRef;
                            FieldRef: FieldRef;
                            TempValueBuffer: Record "Buffer Field" temporary;
                            LineNo: Integer;
                            salesheader: Record "Sales Header";
                        begin

                            SalesHeader.Reset();
                            SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);


                            RecRef.Open(Database::"Sales Header");
                            FieldRef := RecRef.Field(filteringname);

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

                                if Page.RunModal(Page::"Field Buffer List", TempValueBuffer, selectedcust) = Action::LookupOK then begin

                                    filteringvalue := TempValueBuffer."Field Name";
                                    // RecordSelection := TempValueBuffer."Field Name";
                                    valueID := TempValueBuffer."Record ID";

                                end;
                            end;
                        end;
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {

                }
            }
        }

    }
    trigger OnPostReport()
    begin
        Message('%1 sales invoices were posted.', myInt);
    end;

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = Excel;
    //         LayoutFile = 'mySpreadsheet.xlsx';
    //     }
    // }

    var
        myInt: Integer;
        filteringname: integer;
        filteringvalue: Code[20];
        SalesPost: Codeunit "Sales-Post";
        selectedcust: integer;
        FieldName: Text[250];
        RecordSelection: Text[250];
        TableID: Integer;
        FieldID: Integer;
        valueID: RecordId;
        SelectedFieldValue: text[250];
        Found: Boolean;
}