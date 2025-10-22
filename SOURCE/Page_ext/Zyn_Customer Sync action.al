pageextension 50144 Zyn_Customer_List_Ext extends "customer List"
{
    actions
    {
        addlast(Processing)
        {
            action(ReplicateToSlaves)
            {
                ApplicationArea = All;
                Caption = 'Replicate to Slave Companies';
                Image = SendTo;

                trigger OnAction()
                var
                    Zyn_Comp: Record "Zynith_Company";
                    "Cust&VendorSync": Codeunit "Customer&VendorSyncMgt";
                    // SyncControlMgt: Codeunit "SyncControlMgt";
                begin
                    // Allow Business Relation change during intentional send
                    // SyncControlMgt.SetAllowBusinessRelationChange(true);
                    Zyn_Comp.Reset();
                    Zyn_Comp.SetRange("Is Master", false);
                    Zyn_Comp.SetRange("Master Company", CompanyName);

                    if Page.RunModal(Page::"Zynith Company List", Zyn_Comp) = Action::LookupOK then begin
                        if Zyn_Comp.FindSet() then
                            repeat
                                "Cust&VendorSync".SendCustomerToSlave(Rec, Zyn_Comp."Display Name");
                            until Zyn_Comp.Next() = 0;
                    end;
                        // Always reset flag after operation
                    // SyncControlMgt.ClearAll();
                end;
            }

        }
    }

}

pageextension 50145 Zyn_Vendor_List_Ext extends "Vendor List"
{
    actions
    {
        addlast(Processing)
        {
            action(ReplicateToSlaves)
            {
                ApplicationArea = All;
                Caption = 'Replicate to Slave Companies';
                Image = SendTo;

                trigger OnAction()
                var
                    Zyn_Comp: Record "Zynith_Company";
                    VendSync: Codeunit "Customer&VendorSyncMgt";
                    // SyncControlMgt: Codeunit "SyncControlMgt";
                begin
                    // Allow Business Relation change during intentional send
                    // SyncControlMgt.SetAllowBusinessRelationChange(true);
                    Zyn_Comp.Reset();
                    Zyn_Comp.SetRange("Is Master", false);
                    Zyn_Comp.SetRange("Master Company", CompanyName);

                    if Page.RunModal(Page::"Zynith Company List", Zyn_Comp) = Action::LookupOK then begin
                        if Zyn_Comp.FindSet() then
                            repeat
                                VendSync.SendVendorToSlave(Rec, Zyn_Comp."Display Name");
                            until Zyn_Comp.Next() = 0;
                    end;
                    // Always reset flag after operation
                    // SyncControlMgt.ClearAll();
                end;
            }
        }
    }
}

