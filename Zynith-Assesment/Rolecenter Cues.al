pageextension 50139 "Role Center Subscription Ext" extends MyCustomerRoleCenter
{
    layout
    {
        addfirst(RoleCenter)
        {
            part(SubscriptionCue; "Subscription Cue")
            {
                ApplicationArea = All;
            }

            part("Revenue Generated";"Revenue Cue")
            {
                ApplicationArea = All;
            }
        }
    }
    
    actions
    {
        // Add changes to page actions here
    }
    
    var
        myInt: Integer;
}