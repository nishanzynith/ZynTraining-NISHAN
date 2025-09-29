codeunit 50118 "CustomerVendorSyncMgt"
{
    var
        IsSyncing: Boolean;

    // =========================================================================================
    // Public method called from page action → handles replication
    // =========================================================================================

    // procedure ReplicateCustomerToSlave(var Cust: Record Customer; TargetCompanyName: Text)
    // var
    //     SlaveCustomer: Record Customer;
    //     ContactBusRel: Record "Contact Business Relation";
    //     SourceContactBusRel: Record "Contact Business Relation";
    //     MasterCompany: Text;
    // begin
    //     if Cust.IsEmpty() then
    //         exit;

    //     // Save master company
    //     MasterCompany := COMPANYNAME;

    //     // --- Create customer in slave company ---
    //     SlaveCustomer.ChangeCompany(TargetCompanyName);
    //     ContactBusRel.ChangeCompany(TargetCompanyName);

    //     SlaveCustomer.Init();
    //     SlaveCustomer.TransferFields(Cust, false);
    //     SlaveCustomer.Insert(true); // inserts in slave company

    //     // --- Update Contact Business Relation in slave company ---
    //     SourceContactBusRel.ChangeCompany(MasterCompany); // master company context
    //     if SourceContactBusRel.FindSet() then
    //         repeat
    //             // Only business relations for this customer and code 'CUS'
    //             if (SourceContactBusRel."Business Relation Code" = 'CUS') and
    //                (SourceContactBusRel."No." = Cust."No.") then begin

    //                 ContactBusRel.Init();
    //                 ContactBusRel."Contact No." := SourceContactBusRel."Contact No.";
    //                 ContactBusRel."No." := SlaveCustomer."No.";
    //                 ContactBusRel.Insert();
    //             end;
    //         until SourceContactBusRel.Next() = 0;

    //     Message('Customer %1 replicated to %2 as %3 with contact relations updated.',
    //         Cust."No.", TargetCompanyName, SlaveCustomer."No.");
    // end;




    // procedure ReplicateCustomerToSlave(var Cust: Record Customer; TargetCompanyName: Text)
    // var
    //     SlaveCustomer: Record Customer;
    //     ContactBusRel: Record "Contact Business Relation";
    //     SourceContactBusRel: Record "Contact Business Relation";
    //     MasterCompany: Text;
    // begin
    //     if Cust.IsEmpty() then
    //         exit;

    //     // Save master company
    //     MasterCompany := COMPANYNAME;

    //     // --- Create customer in slave company ---
    //     SlaveCustomer.ChangeCompany(TargetCompanyName);
    //     ContactBusRel.ChangeCompany(TargetCompanyName);

    //     if not SlaveCustomer.Get(Cust."No.") then begin
    //         SlaveCustomer.Init();
    //         SlaveCustomer.Validate("No.",cust."No.");
    //         SlaveCustomer.TransferFields(Cust, false);
    //         SlaveCustomer.Insert(); // insert with same No.
    //     end;

    //     // --- Update Contact Business Relation in slave company ---
    //     SourceContactBusRel.ChangeCompany(MasterCompany);
    //     if SourceContactBusRel.FindSet() then
    //         repeat
    //             if (SourceContactBusRel."Business Relation Code" = 'CUS') and
    //                (SourceContactBusRel."No." = Cust."No.") then begin

    //                 if not ContactBusRel.Get(SourceContactBusRel."Contact No.", SlaveCustomer."No.") then begin
    //                     ContactBusRel.Init();
    //                     ContactBusRel."Contact No." := SourceContactBusRel."Contact No.";
    //                     ContactBusRel."No." := SlaveCustomer."No.";
    //                     ContactBusRel.Insert();
    //                 end;
    //             end;
    //         until SourceContactBusRel.Next() = 0;

    //     Message('Customer %1 replicated to %2 as %3 with contact relations updated.',
    //         Cust."No.", TargetCompanyName, SlaveCustomer."No.");
    // end;


    procedure ReplicateCustomerToSlave(var Cust: Record Customer; TargetCompanyName: Text)
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

        MasterCompany := COMPANYNAME;

        // --- Create customer in slave company ---
        SlaveCustomer.ChangeCompany(TargetCompanyName);
        if not SlaveCustomer.Get(Cust."No.") then begin
            SlaveCustomer.Init();
            SlaveCustomer.Validate("No.", Cust."No."); // requires "Manual Nos." in slave company
            SlaveCustomer.TransferFields(Cust, false);
            SlaveCustomer.Insert();
        end;

        // --- Get master’s business relations for this customer ---
        SourceBusRel.ChangeCompany(MasterCompany);
        SourceContact.ChangeCompany(MasterCompany);
        SourceBusRel.SetRange("Business Relation Code", 'CUS');
        SourceBusRel.SetRange("No.", Cust."No.");

        if SourceBusRel.FindSet() then
            repeat
                if SourceContact.Get(SourceBusRel."Contact No.") then begin
                    // Try to find a *matching contact in the slave company* by some key fields
                    FoundSlaveContactNo := '';

                    SlaveContact.ChangeCompany(TargetCompanyName);
                    SlaveContact.Reset();
                    // // First try Email
                    // if SourceContact."E-Mail" <> '' then begin
                    //     SlaveContact.SetRange("E-Mail", SourceContact."E-Mail");
                    //     if SlaveContact.FindFirst() then
                    //         FoundSlaveContactNo := SlaveContact."No.";
                    // end;

                    // If no match yet, try Phone
                    // if (FoundSlaveContactNo = '') and (SourceContact."Phone No." <> '') then begin
                    //     SlaveContact.Reset();
                    //     SlaveContact.SetRange("Phone No.", SourceContact."Phone No.");
                    //     if SlaveContact.FindFirst() then
                    //         FoundSlaveContactNo := SlaveContact."No.";
                    // end;

                    // If still no match, try Name
                    if (FoundSlaveContactNo = '') and (SourceContact.Name <> '') then begin
                        SlaveContact.Reset();
                        SlaveContact.SetRange(Name, SourceContact.Name);
                        if SlaveContact.FindFirst() then
                            FoundSlaveContactNo := SlaveContact."No.";
                    end;

                    // If a matching contact exists in the slave company → link it
                    if FoundSlaveContactNo <> '' then begin
                        SlaveBusRel.ChangeCompany(TargetCompanyName);
                        if not SlaveBusRel.Get(FoundSlaveContactNo, SlaveCustomer."No.") then begin
                            SlaveBusRel.Init();
                            SlaveBusRel."Contact No." := FoundSlaveContactNo;
                            SlaveBusRel."No." := SlaveCustomer."No.";
                            SlaveBusRel."Link to Table" := SlaveBusRel."Link to Table"::Customer;
                            SlaveBusRel."Business Relation Code" := 'CUS';
                            SlaveBusRel.Insert();
                        end;
                    end;
                end;
            until SourceBusRel.Next() = 0;

        Message('Customer %1 replicated to %2 as %3. Contact relations were linked to existing slave contacts.',
            Cust."No.", TargetCompanyName, SlaveCustomer."No.");
    end;



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

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeModifyEvent', '', true, true)]
    local procedure PreventModifyInSlave(var Rec: Record Customer; var xRec: Record Customer; RunTrigger: Boolean)
    var
        ZynCompany: Record Zynith_Company;
    begin
        if ZynCompany.Get(CompanyName()) then
            if (not ZynCompany."Is Master") and (ZynCompany."Master Company" <> '') then
                Error('You cannot modify Customers in slave company %1. Modify them only in the Master company.', CompanyName);
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
}
