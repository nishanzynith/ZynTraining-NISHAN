codeunit 50118 "Customer&VendorSyncMgt"
{
    var
        IsSyncing: Boolean;
        IsEntitySyncRunning: Boolean;


    // =========================================================================================
    // Public method called from page action → handles replication
    // =========================================================================================
    // procedure SendCustomerToSlave(var Cust: Record Customer; TargetCompanyName: Text)
    // var
    //     SlaveCustomer: Record Customer;
    //     SlaveContact: Record Contact;
    //     SlaveBusRel: Record "Contact Business Relation";
    //     SourceBusRel: Record "Contact Business Relation";
    //     SourceContact: Record Contact;
    //     MasterCompany: Text;
    //     FoundSlaveContactNo: Code[20];
    // // CustSync: Codeunit SyncControlMgt;
    // begin
    //     if Cust.IsEmpty() then
    //         exit;

    //     MasterCompany := COMPANYNAME;

    //     SlaveCustomer.ChangeCompany(TargetCompanyName);
    //     if not SlaveCustomer.Get(Cust."No.") then begin
    //         SlaveCustomer.Init();
    //         SlaveCustomer.Validate("No.", Cust."No.");
    //         SlaveCustomer.TransferFields(Cust, false);
    //         SlaveCustomer.Insert();
    //     end;

    //     SourceBusRel.ChangeCompany(MasterCompany);
    //     SourceContact.ChangeCompany(MasterCompany);
    //     SourceBusRel.SetRange("Business Relation Code", 'CUS');
    //     SourceBusRel.SetRange("No.", Cust."No.");

    //     if SourceBusRel.FindSet() then
    //         repeat
    //             if SourceContact.Get(SourceBusRel."Contact No.") then begin
    //                 FoundSlaveContactNo := '';

    //                 SlaveContact.ChangeCompany(TargetCompanyName);
    //                 SlaveContact.Reset();

    //                 if (FoundSlaveContactNo = '') and (SourceContact.Name <> '') then begin
    //                     SlaveContact.Reset();
    //                     SlaveContact.SetRange(Name, SourceContact.Name);
    //                     if SlaveContact.FindFirst() then
    //                         FoundSlaveContactNo := SlaveContact."No.";
    //                 end;

    //                 if FoundSlaveContactNo <> '' then begin
    //                     SlaveBusRel.ChangeCompany(TargetCompanyName);
    //                     if not SlaveBusRel.Get(FoundSlaveContactNo, SlaveCustomer."No.") then begin
    //                         SlaveBusRel.Init();
    //                         SlaveBusRel."Contact No." := FoundSlaveContactNo;
    //                         SlaveBusRel."No." := SlaveCustomer."No.";
    //                         If SlaveContact."Contact Business Relation" = SlaveContact."Contact Business Relation" then begin
    //                             SlaveContact."Contact Business Relation" := SourceContact."Contact Business Relation";
    //                             // CustSync.SetSyncingCustomer(true);
    //                             SlaveContact.Modify();
    //                             // CustSync.SetSyncingCustomer(false);
    //                         end;
    //                         SlaveBusRel."Business Relation Code" := 'CUS';
    //                         SlaveBusRel.Insert();
    //                     end;
    //                 end;
    //             end;
    //         until SourceBusRel.Next() = 0;

    //     Message('Customer %1 replicated to %2 as %3. Contact relations were linked to existing slave contacts.',
    //         Cust."No.", TargetCompanyName, SlaveCustomer."No.");
    // end;

    // =====================================================================================================================
    procedure SendCustomerToSlave(var Cust: Record Customer; TargetCompanyName: Text)
    var
        SlaveCustomer: Record Customer;
        SlaveContact: Record Contact;
        SlaveBusRel: Record "Contact Business Relation";
        SourceBusRel: Record "Contact Business Relation";
        SourceContact: Record Contact;
        MasterCompany: Text;
        FoundSlaveContactNo: Code[20];
    begin
        if Cust.IsEmpty() then
            exit;

        MasterCompany := CompanyName;

        // Switch to slave company context
        SlaveCustomer.ChangeCompany(TargetCompanyName);

        // Create customer in slave if missing
        if not SlaveCustomer.Get(Cust."No.") then begin
            SlaveCustomer.Init();
            SlaveCustomer.Validate("No.", Cust."No.");
            SlaveCustomer.TransferFields(Cust, false);
            SlaveCustomer.Insert();
        end;

        // Get business relations in master company
        SourceBusRel.ChangeCompany(MasterCompany);
        SourceContact.ChangeCompany(MasterCompany);
        SourceBusRel.SetRange("Business Relation Code", 'CUS');
        SourceBusRel.SetRange("No.", Cust."No.");

        if SourceBusRel.FindSet() then
            repeat
                if SourceContact.Get(SourceBusRel."Contact No.") then begin
                    FoundSlaveContactNo := '';

                    // Try to find existing contact by name in slave
                    SlaveContact.ChangeCompany(TargetCompanyName);
                    SlaveContact.SetRange(Name, SourceContact.Name);
                    if SlaveContact.FindFirst() then
                        FoundSlaveContactNo := SlaveContact."No.";

                    if FoundSlaveContactNo <> '' then begin
                        // Create the business relation in the slave if not exists
                        SlaveBusRel.ChangeCompany(TargetCompanyName);
                        if not SlaveBusRel.Get(FoundSlaveContactNo, SlaveCustomer."No.") then begin
                            SlaveBusRel.Init();
                            SlaveBusRel."Contact No." := FoundSlaveContactNo;
                            SlaveBusRel."No." := SlaveCustomer."No.";
                            If SlaveContact."Contact Business Relation" = SlaveContact."Contact Business Relation" then begin
                                SlaveContact."Contact Business Relation" := SourceContact."Contact Business Relation";
                                // CustSync.SetSyncingCustomer(true);
                                SlaveContact.Modify();
                                // CustSync.SetSyncingCustomer(false);
                            end;
                            SlaveBusRel."Business Relation Code" := SourceBusRel."Business Relation Code";
                            SlaveContact."Contact Business Relation" := SlaveBusRel."Link to Table";
                            SlaveBusRel."Link to Table" := SlaveBusRel."Link to Table"::Customer;
                            SlaveBusRel.Insert();
                        end;
                    end;
                end;
            until SourceBusRel.Next() = 0;

        Message(
          'Customer %1 replicated to %2 as %3. Contact relations linked to existing slave contacts.',
          Cust."No.", TargetCompanyName, SlaveCustomer."No."
        );
    end;

    // =============================================================================================================
    procedure SendVendorToSlave(var Vend: Record Vendor; TargetCompanyName: Text)
    var
        SlaveVendor: Record Vendor;
        SlaveContact: Record Contact;
        SlaveBusRel: Record "Contact Business Relation";
        SourceBusRel: Record "Contact Business Relation";
        SourceContact: Record Contact;
        MasterCompany: Text;
        FoundSlaveContactNo: Code[20];
        CustSync: Codeunit SyncControlMgt;

    begin
        if Vend.IsEmpty() then
            exit;

        MasterCompany := COMPANYNAME;

        // Replicate Vendor record
        SlaveVendor.ChangeCompany(TargetCompanyName);
        if not SlaveVendor.Get(Vend."No.") then begin
            SlaveVendor.Init();
            SlaveVendor.Validate("No.", Vend."No.");
            SlaveVendor.TransferFields(Vend, false);
            SlaveVendor.Insert();
        end;

        // Replicate Business Relation
        SourceBusRel.ChangeCompany(MasterCompany);
        SourceContact.ChangeCompany(MasterCompany);
        SourceBusRel.SetRange("Business Relation Code", 'VEND');
        SourceBusRel.SetRange("No.", Vend."No.");

        if SourceBusRel.FindSet() then
            repeat
                if SourceContact.Get(SourceBusRel."Contact No.") then begin
                    FoundSlaveContactNo := '';

                    SlaveContact.ChangeCompany(TargetCompanyName);
                    SlaveContact.Reset();

                    // Find existing contact in Slave by Name
                    if (FoundSlaveContactNo = '') and (SourceContact.Name <> '') then begin
                        SlaveContact.Reset();
                        SlaveContact.SetRange(Name, SourceContact.Name);
                        if SlaveContact.FindFirst() then
                            FoundSlaveContactNo := SlaveContact."No.";
                    end;

                    if FoundSlaveContactNo <> '' then begin
                        SlaveBusRel.ChangeCompany(TargetCompanyName);
                        if not SlaveBusRel.Get(FoundSlaveContactNo, SlaveVendor."No.") then begin
                            SlaveBusRel.Init();
                            SlaveBusRel."Contact No." := FoundSlaveContactNo;
                            SlaveBusRel."No." := SlaveVendor."No.";
                            If SlaveContact."Contact Business Relation" = SlaveContact."Contact Business Relation" then begin
                                SlaveContact."Contact Business Relation" := SourceContact."Contact Business Relation";
                                // CustSync.SetSyncingCustomer(true);
                                SlaveContact.Modify();
                                // CustSync.SetSyncingCustomer(false);
                            end;
                            SlaveBusRel."Business Relation Code" := SourceBusRel."Business Relation Code";
                            SlaveContact."Contact Business Relation" := SlaveBusRel."Link to Table";
                            SlaveBusRel."Link to Table" := SlaveBusRel."Link to Table"::Vendor;
                            SlaveBusRel.Insert();
                        end;
                    end;
                end;
            until SourceBusRel.Next() = 0;

        Message('Vendor %1 replicated to %2 as %3. Contact relations were linked to existing slave contacts.',
            Vend."No.", TargetCompanyName, SlaveVendor."No.");
    end;

    // ===================================================================================================================

    // procedure SendCustomerToSlave(var Cust: Record Customer; TargetCompanyName: Text)
    // var
    //     SlaveCustomer: Record Customer;
    //     SlaveContact: Record Contact;
    //     SlaveBusRel: Record "Contact Business Relation";
    //     SourceBusRel: Record "Contact Business Relation";
    //     SourceContact: Record Contact;
    //     MasterCompany: Text;
    //     FoundSlaveContactNo: Code[20];
    // begin
    //     if Cust.IsEmpty() then
    //         exit;

    //     MasterCompany := COMPANYNAME;

    //     // Replicate Customer record
    //     SlaveCustomer.ChangeCompany(TargetCompanyName);
    //     if not SlaveCustomer.Get(Cust."No.") then begin
    //         SlaveCustomer.Init();
    //         SlaveCustomer.Validate("No.", Cust."No.");
    //         SlaveCustomer.TransferFields(Cust, false);
    //         SlaveCustomer.Insert(true);
    //     end;

    //     // Replicate Business Relation
    //     SourceBusRel.ChangeCompany(MasterCompany);
    //     SourceContact.ChangeCompany(MasterCompany);
    //     SourceBusRel.SetRange("Business Relation Code",'CUS');
    //     SourceBusRel.SetRange("No.", Cust."No.");

    //     if SourceBusRel.FindSet() then
    //         repeat
    //             if SourceContact.Get(SourceBusRel."Contact No.") then begin
    //                 FoundSlaveContactNo := '';

    //                 SlaveContact.ChangeCompany(TargetCompanyName);
    //                 SlaveContact.Reset();

    //                 // Try to find existing contact in Slave by Name
    //                 if (FoundSlaveContactNo = '') and (SourceContact.Name <> '') then begin
    //                     SlaveContact.Reset();
    //                     SlaveContact.SetRange(Name, SourceContact.Name);
    //                     if SlaveContact.FindFirst() then
    //                         FoundSlaveContactNo := SlaveContact."No.";
    //                 end;

    //                 if FoundSlaveContactNo <> '' then begin
    //                     SlaveBusRel.ChangeCompany(TargetCompanyName);
    //                     if not SlaveBusRel.Get(FoundSlaveContactNo, SlaveCustomer."No.") then begin
    //                         SlaveBusRel.Init();
    //                         SlaveBusRel."Contact No." := FoundSlaveContactNo;
    //                         SlaveBusRel."Link to Table" := SlaveBusRel."Link to Table"::Customer;
    //                         SlaveBusRel."No." := SlaveCustomer."No.";
    //                         SlaveContact."Contact Business Relation" := SourceContact."Contact Business Relation";
    //                         SlaveBusRel."Business Relation Code" := 'CUS';
    //                         SlaveBusRel.Insert(true);
    //                     end;
    //                 end;
    //             end;
    //         until SourceBusRel.Next() = 0;

    //     Message(
    //       'Customer %1 replicated to %2 as %3. Contact relations were linked to existing slave contacts.',
    //       Cust."No.", TargetCompanyName, SlaveCustomer."No."
    //     );
    // end;


    // procedure SendVendorToSlave(var Vend: Record Vendor; TargetCompanyName: Text)
    // var
    //     SlaveVendor: Record Vendor;
    //     SlaveContact: Record Contact;
    //     SlaveBusRel: Record "Contact Business Relation";
    //     SourceBusRel: Record "Contact Business Relation";
    //     SourceContact: Record Contact;
    //     MasterCompany: Text;
    //     FoundSlaveContactNo: Code[20];
    // begin
    //     if Vend.IsEmpty() then
    //         exit;

    //     MasterCompany := COMPANYNAME;

    //     // Replicate Vendor record
    //     SlaveVendor.ChangeCompany(TargetCompanyName);
    //     if not SlaveVendor.Get(Vend."No.") then begin
    //         SlaveVendor.Init();
    //         SlaveVendor.Validate("No.", Vend."No.");
    //         SlaveVendor.TransferFields(Vend, false);
    //         SlaveVendor.Insert(true);
    //     end;

    //     // Replicate Business Relation
    //     SourceBusRel.ChangeCompany(MasterCompany);
    //     SourceContact.ChangeCompany(MasterCompany);
    //     SourceBusRel.SetRange("Business Relation Code", 'VEND');
    //     SourceBusRel.SetRange("No.", Vend."No.");

    //     if SourceBusRel.FindSet() then
    //         repeat
    //             if SourceContact.Get(SourceBusRel."Contact No.") then begin
    //                 FoundSlaveContactNo := '';

    //                 SlaveContact.ChangeCompany(TargetCompanyName);
    //                 SlaveContact.Reset();

    //                 // Try to find existing contact in Slave by Name
    //                 if (FoundSlaveContactNo = '') and (SourceContact.Name <> '') then begin
    //                     SlaveContact.Reset();
    //                     SlaveContact.SetRange(Name, SourceContact.Name);
    //                     if SlaveContact.FindFirst() then
    //                         FoundSlaveContactNo := SlaveContact."No.";
    //                 end;

    //                 if FoundSlaveContactNo <> '' then begin
    //                     SlaveBusRel.ChangeCompany(TargetCompanyName);
    //                     if not SlaveBusRel.Get(FoundSlaveContactNo, SlaveVendor."No.") then begin
    //                         SlaveBusRel.Init();
    //                         SlaveBusRel."Contact No." := FoundSlaveContactNo;
    //                         SlaveBusRel."No." := SlaveVendor."No.";
    //                         SlaveContact."Contact Business Relation" := SourceContact."Contact Business Relation";
    //                         SlaveBusRel."Business Relation Code" := 'VEND';
    //                         SlaveBusRel.Insert(true);
    //                     end;
    //                 end;
    //             end;
    //         until SourceBusRel.Next() = 0;

    //     Message(
    //       'Vendor %1 replicated to %2 as %3. Contact relations were linked to existing slave contacts.',
    //       Vend."No.", TargetCompanyName, SlaveVendor."No."
    //     );
    // end;


    // =========================================================================================
    // Prevent direct insert/modify/delete in slave companies
    // =========================================================================================

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeInsertEvent', '', true, true)]
    local procedure PreventInsertInSlave(var Rec: Record Customer; RunTrigger: Boolean)
    var
        ZynCompany: Record Zynith_Company;
    begin
        if ZynCompany.Get(CompanyName()) then
            if (not ZynCompany."Is Master") and (ZynCompany."Master Company" <> '') then
                Error('You cannot create Customers in slave company %1. Create them only in the Master company.', CompanyName);
    end;


    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeDeleteEvent', '', true, true)]
    local procedure PreventDeleteInSlave(var Rec: Record Customer; RunTrigger: Boolean)
    var
        ZynCompany: Record Zynith_Company;
    begin
        if ZynCompany.Get(CompanyName()) then
            if (not ZynCompany."Is Master") and (ZynCompany."Master Company" <> '') then
                Error('You cannot delete Customers in slave company %1. Delete them only in the Master company.', CompanyName);
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterModifyEvent', '', true, true)]
    local procedure CustomerModificationSync(var Rec: Record Customer; RunTrigger: Boolean)
    var
        MasterCompany: Record Zynith_Company;
        SlaveCompany: Record Zynith_Company;
        CurrentCompany: Record Zynith_Company;
        SlaveCustomer: Record Customer;
        MasterRef: RecordRef;
        SlaveRef: RecordRef;
        Field: FieldRef;
        SlaveField: FieldRef;
        i: Integer;
        IsDifferent: Boolean;
    begin
        if IsSyncing then
            exit;

        if MasterCompany.Get(COMPANYNAME) then begin
            if MasterCompany."Is Master" then begin
                SlaveCompany.Reset();
                SlaveCompany.SetRange("Master Company", MasterCompany.Name);
                if SlaveCompany.FindSet() then
                    repeat
                        SlaveCustomer.ChangeCompany(SlaveCompany.Name);
                        if SlaveCustomer.Get(Rec."No.") then begin

                            MasterRef.GetTable(Rec);
                            SlaveRef.GetTable(SlaveCustomer);
                            IsDifferent := false;
                            for i := 1 to MasterRef.FieldCount do begin
                                Field := MasterRef.FieldIndex(i);
                                if Field.Class <> FieldClass::Normal then
                                    continue;
                                if Field.Number in [1] then
                                    continue;
                                SlaveField := SlaveRef.Field(Field.Number);
                                if SlaveField.Value <> Field.Value then begin
                                    IsDifferent := true;
                                    break;
                                end;
                            end;

                            if IsDifferent then begin
                                IsSyncing := true;
                                SlaveCustomer.TransferFields(Rec, false);
                                SlaveCustomer."No." := Rec."No.";
                                SlaveCustomer.Modify(false);
                                IsSyncing := false;
                            end;
                        end;
                    until SlaveCompany.Next() = 0;

            end else begin
                Error(ModifyContactInSlaveErr, COMPANYNAME);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterDeleteEvent', '', true, true)]
    local procedure ContactOnAfterDelete(var Rec: Record Contact; RunTrigger: Boolean)
    var
        CurrentCompany: Record Zynith_Company;
    begin
        if not CurrentCompany.Get(COMPANYNAME) then
            exit;

        // Only perform deletion propagation if this is Master
        if not CurrentCompany."Is Master" then
            exit;

        // Call procedure to delete in Slave companies
        DeleteInSlaveCompanies(Rec."No.", CurrentCompany.Name);
    end;

    local procedure DeleteInSlaveCompanies(ContactNo: Code[20]; MasterCompanyName: Text)
    var
        SlaveCompany: Record Zynith_Company;
        SlaveContact: Record Contact;
        SlaveBusRel: Record "Contact Business Relation";
        SlaveCust: Record Customer;
        SlaveVend: Record Vendor;
    begin
        SlaveCompany.SetRange("Master Company", MasterCompanyName);
        if SlaveCompany.FindSet() then
            repeat
                SlaveContact.ChangeCompany(SlaveCompany.Name);
                SlaveBusRel.ChangeCompany(SlaveCompany.Name);
                SlaveCust.ChangeCompany(SlaveCompany.Name);
                SlaveVend.ChangeCompany(SlaveCompany.Name);

                if SlaveContact.Get(ContactNo) then begin

                    // Delete related business relations
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

                    // Delete the contact itself
                    IsSyncing := true;
                    SlaveContact.Delete(true);
                    IsSyncing := false;
                end;

            until SlaveCompany.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterModifyEvent', '', false, false)]
    local procedure ContactOnAfterModify(var Rec: Record Contact; xRec: Record Contact; RunTrigger: Boolean)
    var
        ZynCompany: Record "Zynith_Company";
        SlaveCompany: Record "Zynith_Company";
        SlaveContact: Record Contact;
        SlaveBusRel: Record "Contact Business Relation";
        RelationEnum: Enum "Contact Business Relation";
    begin
        // ✅ Get Current Company Info
        if not ZynCompany.Get(CompanyName()) then
            exit;

        // ✅ Skip if Master Company or not linked to any slaves
        if ZynCompany."Is Master" or (ZynCompany."Master Company" <> '') then
            exit;

        // ✅ Process in each slave company
        if ZynCompany.FindSet() then
            repeat
                if (ZynCompany.Name <> CompanyName()) and (not ZynCompany."Is Master") then begin
                    SlaveContact.ChangeCompany(ZynCompany.Name);
                    if not SlaveContact.Get(Rec."No.") then
                        exit;

                    // 🔹 Update all related Business Relations
                    SlaveBusRel.ChangeCompany(ZynCompany.Name);
                    SlaveBusRel.SetRange("Contact No.", SlaveContact."No.");

                    if SlaveBusRel.FindSet() then
                        repeat
                            UpdateLinkToTableForBusinessRelation(SlaveBusRel);
                        until SlaveBusRel.Next() = 0;

                    // 🔹 Recompute and update Contact Business Relation dynamically
                    RelationEnum := GetContactBusinessRelation(SlaveContact, ZynCompany.Name);

                    if RelationEnum <> SlaveContact."Contact Business Relation" then begin
                        SlaveContact.Validate("Contact Business Relation", RelationEnum);
                        SlaveContact.Modify(true);
                    end;
                end;
            until ZynCompany.Next() = 0;
    end;

    // 🔸 Helper procedure: Determine correct Business Relation dynamically
    local procedure GetContactBusinessRelation(SlaveContact: Record Contact; CompanyName: Text): Enum "Contact Business Relation"
    var
        SlaveBusRel: Record "Contact Business Relation";
        RelationEnum: Enum "Contact Business Relation";
    begin
        SlaveBusRel.ChangeCompany(CompanyName);
        SlaveBusRel.SetRange("Contact No.", SlaveContact."No.");

        if SlaveBusRel.FindFirst() then begin
            case SlaveBusRel."Business Relation Code" of
                'CUS':
                    RelationEnum := Enum::"Contact Business Relation"::Customer;
                'VEND':
                    RelationEnum := Enum::"Contact Business Relation"::Vendor;
                else
                    RelationEnum := Enum::"Contact Business Relation"::" ";
            end;
        end else
            RelationEnum := Enum::"Contact Business Relation"::" ";

        exit(RelationEnum);
    end;

    // 🔸 Helper procedure: Fix missing Link to Table dynamically
    local procedure UpdateLinkToTableForBusinessRelation(var BusRel: Record "Contact Business Relation")
    var
        SlaveCustomer: Record Customer;
        SlaveVendor: Record Vendor;
    begin
        // Only update if Link to Table is empty
        if BusRel."Link to Table".AsInteger() = 0 then begin
            case BusRel."Business Relation Code" of
                'CUS':
                    // Check if Customer exists
                    if SlaveCustomer.Get(BusRel."No.") then
                        BusRel."Link to Table" := Enum::"Contact Business Relation"::Customer;
                'VEND':
                    // Check if Vendor exists
                    if SlaveVendor.Get(BusRel."No.") then
                        BusRel."Link to Table" := Enum::"Contact Business Relation"::Vendor;
            end;

            if BusRel."Link to Table".AsInteger() <> 0 then
                BusRel.Modify(true); // Save updated value
        end;
    end;


    var
        ModifyContactInSlaveErr: Label 'You cannot modify contacts in a slave company %1. Modify contacts only in the master company.';
}
