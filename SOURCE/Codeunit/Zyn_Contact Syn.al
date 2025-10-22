codeunit 50117 "ContactSyncMgt."
{
    var
        IsSyncing: Boolean;


    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeInsertEvent', '', true, true)]
    local procedure ValidateContactInsert(var Rec: Record Contact; RunTrigger: Boolean)
    var
        ZynCompany: Record Zynith_Company;
    begin
        if ZynCompany.Get(COMPANYNAME) then begin
            if (not ZynCompany."Is Master") and (ZynCompany."Master Company" <> '') then
                Error(CreateContactInSlaveErr);
        end;
    end;
    // ---------------------------------------------------------------------------------------------------
    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterInsertEvent', '', true, true)]
    local procedure InsertContactRecord(var Rec: Record Contact)
    var
        CurrentCompany: Record Zynith_Company;
        DependentCompany: Record Zynith_Company;
        TargetContact: Record Contact;
    begin
        if not CurrentCompany.Get(CompanyName()) then
            exit;
        if not CurrentCompany."Is Master" then
            exit;
        DependentCompany.Reset();
        DependentCompany.SetRange("Master Company", CurrentCompany.Name);
        if DependentCompany.FindSet() then
            repeat
                if DependentCompany."Master Company" <> '' then begin
                    TargetContact.ChangeCompany(DependentCompany.Name);
                    if not TargetContact.Get(Rec."No.") then begin
                        TargetContact.Init();
                        TargetContact.TransferFields(Rec);
                        TargetContact.Insert(true);
                    end;
                end;
            until DependentCompany.Next() = 0;
    end;

    // -----------------------------------------------------------------------------------------------------

    // [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterModifyEvent', '', true, true)]
    // local procedure ContactOnAfterModify(var Rec: Record Contact; RunTrigger: Boolean)
    // var
    //     CurrentCompany: Record Zynith_Company;
    //     SlaveCompany: Record Zynith_Company;
    // begin
    //     // Only master company runs the sync
    //     if not CurrentCompany.Get(CompanyName()) then
    //         exit;
    //     if not CurrentCompany."Is Master" then
    //         exit;

    //     // Update all slave companies
    //     SlaveCompany.Reset();
    //     SlaveCompany.SetRange("Master Company", CompanyName());
    //     if SlaveCompany.FindSet() then
    //         repeat
    //             UpdateContactInSlaveCompany(Rec, SlaveCompany.Name);
    //         until SlaveCompany.Next() = 0;
    // end;

    // ---------------------------------------------------------------------------------------------------
    // local procedure UpdateContactInSlaveCompany(SourceContact: Record Contact; TargetCompany: Text)
    // var
    //     ContactSlave: Record Contact;
    // begin
    //     ContactSlave.ChangeCompany(TargetCompany);

    //     if ContactSlave.Get(SourceContact."No.") then begin
    //         // Only modify if the Modified Date is different
    //         if ContactSlave.SystemModifiedAt <> SourceContact.SystemModifiedAt then begin
    //             ContactSlave.TransferFields(SourceContact);
    //             ContactSlave.Modify(false); // false prevents recursion
    //         end;
    //     end else begin
    //         // Insert if it does not exist
    //         ContactSlave.Init();
    //         ContactSlave.TransferFields(SourceContact);
    //         ContactSlave.Insert(true);
    //     end;
    // end;

    //  ---------------------------------------------------------------------------------------------------
    var
    // Prevent deletion in slave company

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeDeleteEvent', '', true, true)]
    local procedure ContactOnBeforeDelete(var Rec: Record Contact; RunTrigger: Boolean)
    var
        ZynCompany: Record Zynith_Company;
    begin
        if ZynCompany.Get(COMPANYNAME) then begin
            if (not ZynCompany."Is Master") and (ZynCompany."Master Company" <> '') then
                Error(DeleteContactInSlaveErr);
        end;
    end;

    // ----------------------------------------------------------------------------------------------------------

    // [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterModifyEvent', '', true, true)]
    // local procedure ContactOnAfterModify(var Rec: Record Contact; var xRec: Record Contact; RunTrigger: Boolean)
    // var
    //     MasterCompany: Record Zynith_Company;
    //     SlaveCompany: Record Zynith_Company;
    //     SlaveContact: Record Contact;
    //     MasterRef: RecordRef;
    //     SlaveRef: RecordRef;
    //     Field: FieldRef;
    //     SlaveField: FieldRef;
    //     i: Integer;
    //     IsDifferent: Boolean;
    // begin
    //     if IsSyncing then
    //         exit;
    //     if MasterCompany.Get(COMPANYNAME) then begin
    //         if MasterCompany."Is Master" then begin
    //             SlaveCompany.Reset();
    //             SlaveCompany.SetRange("Master Company", MasterCompany.Name);
    //             if SlaveCompany.FindSet() then
    //                 repeat
    //                     SlaveContact.ChangeCompany(SlaveCompany.Name);
    //                     if SlaveContact.Get(Rec."No.") then begin
    //                         // Open RecordRefs
    //                         MasterRef.GetTable(Rec);
    //                         SlaveRef.GetTable(SlaveContact);
    //                         IsDifferent := false;
    //                         // Loop through all fields
    //                         for i := 1 to MasterRef.FieldCount do begin
    //                             Field := MasterRef.FieldIndex(i);
    //                             // Skip FlowFields or non-normal fields
    //                             if Field.Class <> FieldClass::Normal then
    //                                 continue;
    //                             // Skip primary key fields (like "No.")
    //                             if Field.Number in [1] then
    //                                 continue;
    //                             SlaveField := SlaveRef.Field(Field.Number);
    //                             if SlaveField.Value <> Field.Value then begin
    //                                 IsDifferent := true;
    //                                 break; // no need to check further
    //                             end;
    //                         end;
    //                         // Only transfer fields if there is a difference
    //                         if IsDifferent then begin
    //                             IsSyncing := true;
    //                             SlaveContact.TransferFields(Rec, false);
    //                             SlaveContact."No." := Rec."No."; // restore PK
    //                             SlaveContact.Modify(true);
    //                             IsSyncing := false;
    //                         end;
    //                     end;
    //                 until SlaveCompany.Next() = 0;
    //         end;
    //     end;
    // end;

    // ---------------------------------------------------------------------------------------------------------------

    // [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeModifyEvent', '', true, true)]
    // local procedure ContactOnBeforeModify(var Rec: Record Contact; var xRec: Record Contact; RunTrigger: Boolean)
    // var
    //     ZynCompany: Record Zynith_Company;
    // begin

    //     if ZynCompany.Get(COMPANYNAME) then begin
    //         if (not ZynCompany."Is Master") and (ZynCompany."Master Company" <> '') then
    //             Error(ModifyContactInSlaveErr);
    //     end;
    // end;

    // ---------------------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterModifyEvent', '', true, true)]
    // local procedure ContactOnAfterModify(var Rec: Record Contact; var xRec: Record Contact; RunTrigger: Boolean)
    // var
    //     MasterCompany: Record Zynith_Company;
    //     SlaveCompany: Record Zynith_Company;
    //     CurrentCompany: Record Zynith_Company;
    //     SlaveContact: Record Contact;
    //     MasterRef: RecordRef;
    //     SlaveRef: RecordRef;
    //     Field: FieldRef;
    //     SlaveField: FieldRef;
    //     i: Integer;
    //     IsDifferent: Boolean;
    //     OldSlaveBusinessRelationCode: enum "Contact Business Relation";

    // begin
    //     if IsSyncing then
    //         exit;


    //     if MasterCompany.Get(COMPANYNAME) then begin
    //         if MasterCompany."Is Master" then begin
    //             // Master company -> replicate to slaves
    //             SlaveCompany.Reset();
    //             SlaveCompany.SetRange("Master Company", MasterCompany.Name);
    //             if SlaveCompany.FindSet() then
    //                 repeat
    //                     SlaveContact.ChangeCompany(SlaveCompany.Name);
    //                     if SlaveContact.Get(Rec."No.") then begin
    //                         OldSlaveBusinessRelationCode := SlaveContact."Contact Business Relation";
    //                         MasterRef.GetTable(Rec);
    //                         SlaveRef.GetTable(SlaveContact);
    //                         IsDifferent := false;
    //                         for i := 1 to MasterRef.FieldCount do begin
    //                             Field := MasterRef.FieldIndex(i);
    //                             if Field.Class <> FieldClass::Normal then
    //                                 continue;
    //                             if Field.Number in [1] then
    //                                 continue;
    //                             SlaveField := SlaveRef.Field(Field.Number);
    //                             if SlaveField.Value <> Field.Value then begin
    //                                 IsDifferent := true;
    //                                 break;
    //                             end;
    //                         end;

    //                         if IsDifferent then begin
    //                             IsSyncing := true;
    //                             SlaveContact.TransferFields(Rec, false);
    //                             SlaveContact."Contact Business Relation" := OldSlaveBusinessRelationCode;
    //                             SlaveContact."No." := Rec."No.";
    //                             SlaveContact.Modify(true);
    //                             IsSyncing := false;
    //                         end;
    //                     end;
    //                 until SlaveCompany.Next() = 0;

    //         end else begin
    //             // // Otherwise block
    //             Error(ModifyContactInSlaveErr, COMPANYNAME);
    //         end;
    //     end;
    // end;
    local procedure ContactOnAfterModify(var Rec: Record Contact; var xRec: Record Contact; RunTrigger: Boolean)
    var
        MasterCompany: Record Zynith_Company;
        SlaveCompany: Record Zynith_Company;
        SlaveContact: Record Contact;
        SlaveBusRel: Record "Contact Business Relation";
        SlaveCustomer: Record Customer;
        SlaveVendor: Record Vendor;
        MasterRef: RecordRef;
        SlaveRef: RecordRef;
        Field: FieldRef;
        SlaveField: FieldRef;
        i: Integer;
        IsDifferent: Boolean;
        Relations: array[10] of Enum "Contact Business Relation";
        RelCount: Integer;
        NewRelation: Enum "Contact Business Relation";
    begin
        if IsSyncing then
            exit;

        if not MasterCompany.Get(CompanyName) then
            exit;

        if not MasterCompany."Is Master" then
            Error('You cannot modify Contacts directly in slave company %1. Modify them only in the Master company.', CompanyName);

        // 🔹 Loop all slave companies
        SlaveCompany.Reset();
        SlaveCompany.SetRange("Master Company", MasterCompany.Name);
        if not SlaveCompany.FindSet() then
            exit;

        repeat
            SlaveContact.ChangeCompany(SlaveCompany.Name);

            if not SlaveContact.Get(Rec."No.") then
                continue;

            // 🔹 Compare fields except primary key and Contact Business Relation
            MasterRef.GetTable(Rec);
            SlaveRef.GetTable(SlaveContact);
            IsDifferent := false;

            for i := 1 to MasterRef.FieldCount do begin
                Field := MasterRef.FieldIndex(i);
                if Field.Class <> FieldClass::Normal then
                    continue;
                if (Field.Number = 1) or (Field.Number = Rec.FieldNo("Contact Business Relation")) then
                    continue;

                SlaveField := SlaveRef.Field(Field.Number);
                if SlaveField.Value <> Field.Value then begin
                    IsDifferent := true;
                    break;
                end;
            end;

            if IsDifferent then begin
                IsSyncing := true;

                // 🔹 Transfer fields except Contact Business Relation
                SlaveContact.TransferFields(Rec, false);
                SlaveContact."No." := Rec."No.";

                // 🔹 Recompute Contact Business Relation dynamically from Business Relation table
                RelCount := 0;
                SlaveBusRel.ChangeCompany(SlaveCompany.Name);
                SlaveBusRel.SetRange("Contact No.", SlaveContact."No.");

                if SlaveBusRel.FindSet() then
                    repeat
                        // Auto-fill Link to Table based on Business Relation Code
                        case SlaveBusRel."Business Relation Code" of
                            'CUS':
                                SlaveBusRel."Link to Table" := Enum::"Contact Business Relation"::Customer;
                            'VEN':
                                SlaveBusRel."Link to Table" := Enum::"Contact Business Relation"::Vendor;
                        end;
                        SlaveBusRel.Modify(true);

                        // Add relation to array if not already added
                        for i := 1 to RelCount do
                            if Relations[i] = SlaveBusRel."Link to Table" then
                                break;
                        if i > RelCount then begin
                            RelCount += 1;
                            Relations[RelCount] := SlaveBusRel."Link to Table";
                        end;
                    until SlaveBusRel.Next() = 0;

                // 🔹 Determine Contact Business Relation
                if RelCount = 0 then
                    NewRelation := Enum::"Contact Business Relation"::None
                else if RelCount = 1 then
                    NewRelation := Relations[1]
                else
                    NewRelation := Enum::"Contact Business Relation"::Multiple;

                SlaveContact."Contact Business Relation" := NewRelation;
                SlaveContact.Modify(true);

                IsSyncing := false;
            end;

        until SlaveCompany.Next() = 0;
    end;


    // ===========================================================================================================

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeDeleteEvent', '', true, true)]

    local procedure PreventDeleteIfOpenOrders(var Rec: Record Contact; RunTrigger: Boolean)
    var
        MyCompany: Record Zynith_Company;
        SlaveCompany: Record Zynith_Company;
        ContactBusRel: Record "Contact Business Relation";
        SalesHeader: Record "Sales Header";
        PurchHeader: Record "Purchase Header";
    begin

        if not MyCompany.Get(CompanyName()) then
            exit;
        if not IsMasterCompany() then
            exit;
        if IsSyncing then
            exit; // Prevent recursion

        IsSyncing := true;
        // Loop through all slave companies
        SlaveCompany.SetRange("Is Master", false);
        SlaveCompany.SetFilter("Master Company", '%1', MyCompany.Name);

        if SlaveCompany.FindSet() then
            repeat
                //  Switch context to slave company
                ContactBusRel.ChangeCompany(SlaveCompany.Name);
                SalesHeader.ChangeCompany(SlaveCompany.Name);
                PurchHeader.ChangeCompany(SlaveCompany.Name);

                // Check relation for the contact
                ContactBusRel.Reset();
                ContactBusRel.SetRange("Contact No.", Rec."No.");
                if ContactBusRel.FindSet() then
                    repeat
                        case ContactBusRel."Link to Table" of
                            ContactBusRel."Link to Table"::Customer:
                                begin
                                    SalesHeader.Reset();
                                    SalesHeader.SetRange("Sell-to Customer No.", ContactBusRel."No.");
                                    SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
                                    SalesHeader.SetRange(Status, SalesHeader.Status::Open);
                                    if SalesHeader.FindFirst() then begin
                                        Error(
                                          'Contact %1 cannot be deleted because it has open Sales Orders in company %2.',
                                          Rec."No.", SlaveCompany.Name);
                                    end;
                                    SalesHeader.SetRange(Status, SalesHeader.Status::Released);
                                    if SalesHeader.FindFirst() then begin
                                        Error(
                                          'Contact %1 cannot be deleted because it has Released Sales Orders in company %2.',
                                          Rec."No.", SlaveCompany.Name);
                                    end;
                                end;

                            ContactBusRel."Link to Table"::Vendor:
                                begin
                                    PurchHeader.Reset();
                                    PurchHeader.SetRange("Buy-from Vendor No.", ContactBusRel."No.");
                                    PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Invoice);
                                    PurchHeader.SetRange(Status, PurchHeader.Status::Open);
                                    if PurchHeader.FindFirst() then begin
                                        Error(
                                          'Contact %1 cannot be deleted because it has open Purchase Orders in company %2.',
                                          Rec."No.", SlaveCompany.Name);
                                    end;
                                    PurchHeader.SetRange(Status, PurchHeader.Status::Released);
                                    if PurchHeader.FindFirst() then begin
                                        Error(
                                          'Contact %1 cannot be deleted because it has Released Purchase Orders in company %2.',
                                          Rec."No.", SlaveCompany.Name);
                                    end;
                                end;
                        end;

                    until ContactBusRel.Next() = 0;
            until SlaveCompany.Next() = 0;

        IsSyncing := false;
        // ✅ If no open orders found anywhere → deletion continues
    end;

    local procedure IsMasterCompany(): Boolean
    var
        MyCompany: Record Zynith_Company;
    begin
        if MyCompany.Get(CompanyName()) then
            exit(MyCompany."Is Master"); // Assuming "IsMaster" is your Boolean field
        exit(false); // default: not master
    end;


    // ---------------------------------------------------------------
    // Delete in all slave companies procedure
    // ---------------------------------------------------------------

    local procedure DeleteInSlaveCompanies(ContactNo: Code[20]; MasterCompanyName: Text)
    var
        SlaveCompany: Record Zynith_Company;
        SlaveContact: Record Contact;
        SlaveBusRel: Record "Contact Business Relation";
        SlaveCust: Record Customer;
        SlaveVend: Record Vendor;
    begin
        // Loop through all slave companies of the master
        SlaveCompany.SetRange("Master Company", MasterCompanyName);
        if SlaveCompany.FindSet() then
            repeat
                // Change to the slave company
                SlaveContact.ChangeCompany(SlaveCompany.Name);
                SlaveBusRel.ChangeCompany(SlaveCompany.Name);
                SlaveCust.ChangeCompany(SlaveCompany.Name);
                SlaveVend.ChangeCompany(SlaveCompany.Name);

                if SlaveContact.Get(ContactNo) then begin
                    // Delete business relations and related Customer/Vendor records
                    SlaveBusRel.SetRange("Contact No.", ContactNo);
                    if SlaveBusRel.FindSet() then
                        repeat
                            case SlaveBusRel."Link to Table" of
                                SlaveBusRel."Link to Table"::Customer:
                                    if SlaveCust.Get(SlaveBusRel."No.") then
                                        SlaveCust.Delete(true);
                                SlaveBusRel."Link to Table"::Vendor:
                                    if SlaveVend.Get(SlaveBusRel."No.") then
                                        SlaveVend.Delete(true);
                            end;
                            SlaveBusRel.Delete(true);
                        until SlaveBusRel.Next() = 0;

                    // Finally delete the contact itself
                    IsSyncing := true;
                    SlaveContact.Delete(true);
                    IsSyncing := false;
                end;
            until SlaveCompany.Next() = 0;
    end;

    // local procedure DeleteInSlaveCompanies(ContactNo: Code[20]; MasterName: Text)
    // var
    //     SlaveCompany: Record Zynith_Company;
    //     SlaveContact: Record Contact;
    // begin
    //     SlaveCompany.SetRange("Master Company", MasterName);
    //     if SlaveCompany.FindSet() then
    //         repeat
    //             SlaveContact.ChangeCompany(SlaveCompany.Name);
    //             if SlaveContact.Get(ContactNo) then begin
    //                 IsSyncing := true;
    //                 SlaveContact.Delete(true);
    //                 IsSyncing := false;
    //             end;
    //         until SlaveCompany.Next() = 0;
    // end;

    // ---------------------------------------------------------------
    // OnAfterDelete cascade (master only)
    // ---------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterDeleteEvent', '', true, true)]
    local procedure ContactOnAfterDelete(var Rec: Record Contact; RunTrigger: Boolean)
    var
        CurrentCompany: Record Zynith_Company;
    begin
        if not CurrentCompany.Get(COMPANYNAME) then
            exit;

        if not CurrentCompany."Is Master" then
            exit;

        DeleteInSlaveCompanies(Rec."No.", CurrentCompany.Name);
    end;

    var
        CreateContactInSlaveErr: Label 'You cannot create contacts in a slave company %1. Create the contact in the master company only.';
        ModifyContactInSlaveErr: Label 'You cannot modify contacts in a slave company %1. Modify contacts only in the master company.';
        DeleteContactInSlaveErr: Label 'You cannot delete contacts in a slave company %1. Delete contacts only in the master company.';
}
