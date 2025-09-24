pageextension 50139 "Role Center Subscription Ext" extends "Zyn_Custom RoleCenter"
{
    layout
    {
        addfirst(RoleCenter)
        {
            part(SubscriptionCue; "Subscription Cue")
            {
                ApplicationArea = All;
            }

            part("Revenue Generated"; "Revenue Cue")
            {
                ApplicationArea = All;
            }
        }
    }

}