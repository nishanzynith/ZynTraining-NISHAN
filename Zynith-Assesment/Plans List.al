page 50167 "Plan List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Plans Table";
    CardPageId = "Plans Card";
    
    layout
    {
        area(Content)
        {
            repeater(Plans)
            {
                Editable = false;
                field("Plan ID";Rec."Plan ID"){Editable = false;}
                field(Name;Rec.Name){}
                field(Description;Rec.Description){}
                field(Fee;Rec.Fee){}
                field("Plan Status";Rec."Plan Status"){}

            }
        }

    }
    
    actions
    {
        area(Processing)
        {
            action(DeactivateSubs)
            {
                Caption = 'Deactivate Subscriptions';
                ApplicationArea = All;
                Image = Stop;

                trigger OnAction()
                begin
                    Rec.DeactivateSubscriptions(Rec."Plan ID"); 
                    Message('All subscriptions for Plan %1 are set to Inactive.', Rec."Plan ID");
                end;
            }
        }
    }
}