page 50170 "Subscription Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Subscription Plans Table";

    layout
    {
        area(Content)
        {
            group("Subscription Details")
            {
                field("Subscription ID"; Rec."Subscription ID") { Editable = false; }
                field("Customer ID"; Rec."Customer ID") { TableRelation = Customer."No."; }
                field("Plan ID"; Rec."Plan ID") { }
                field("Start Date"; Rec."Start Date") { }
                field(Duration; Rec."Duration (Months)") { }
                field("End Date"; Rec."End Date") { Editable = false; }
                field(Status; Rec.Status) { }
                field("Next Billing Date"; Rec."Next Billing Date") { Editable = false; }
            }

            group(Notification)
            {
                field("Next Renewal Date"; Rec."Next Renewal Date") { }
                field("Reminder Sent"; Rec."Reminder Sent") { }
            }
        }
    }
}