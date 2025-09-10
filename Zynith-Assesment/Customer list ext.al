pageextension 50140 "Customer list factbox" extends "Customer List"
{
    layout
    {
        addfirst(FactBoxes)
        {
            part(ActiveSubscriptions; "Active Subscriptions List Part")
            {
                ApplicationArea = All;
                SubPageLink = "Customer ID" = field("No."); 
            }
        }
    }
    
}