page 50169 "Subscription List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Subscription Plans Table";
    CardPageId = "Subscription Card";
    
    layout
    {
        area(Content)
        {
            repeater("Subscription List")
            {
                field("Subscription ID";Rec."Subscription ID"){}
                field("Customer ID";Rec."Customer ID"){TableRelation = Customer."No.";}
                field("Plan ID";Rec."Plan ID"){}
                field("Start Date";Rec."Start Date"){}
                field(Duration;Rec."Duration (Months)"){}
                field("End Date";Rec."End Date"){}
                field(Status;Rec.Status){}
                field("Next Billing Date";Rec."Next Billing Date"){}
            }
        }
        area(Factboxes)
        {
            
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
}