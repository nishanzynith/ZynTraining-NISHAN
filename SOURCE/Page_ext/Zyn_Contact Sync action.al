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
                    CustSync: Codeunit "CustomerVendorSyncMgt"; // contains ReplicateCustomerToSlave
                begin
                    // Filter only slave companies
                    Zyn_Comp.Reset();
                    Zyn_Comp.SetRange("Is Master", false);

                    // Show slave company selection page
                    // 1 = OK, 2 = Cancel
                    if Page.RunModal(Page::"Zynith Company List", Zyn_Comp) = Action ::LookupOK then begin
                        // Loop through selected companies
                        if Zyn_Comp.FindSet() then
                            repeat
                                // Replicate the selected customer (Rec) to each selected slave company
                                CustSync.ReplicateCustomerToSlave(Rec, Zyn_Comp.Name);
                            until Zyn_Comp.Next() = 0;
                    end;
                end;
            }

        }
    }

}
