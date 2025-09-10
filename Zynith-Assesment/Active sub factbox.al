page 50173 "Active Subscriptions List part"
{
    PageType = ListPart;
    SourceTable = "Subscription Plans Table";
    ApplicationArea = All;
    Caption = 'Active Subscriptions';
    SourceTableView = where(Status = const(Active));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Subscription ID"; Rec."Subscription ID")
                {
                    ApplicationArea = All;
                }
                field("Plan ID"; Rec."Plan ID")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                
            }
        }
    }
}
