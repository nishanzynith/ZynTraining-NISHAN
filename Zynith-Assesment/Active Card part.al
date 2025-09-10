page 50171 "Subscription Cue"
{
    PageType = CardPart;
    SourceTable = "Subscription Plans Table";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup(Subscriptions)
            {
                Caption = 'Subscriptions';

                field("Active Subscriptions"; ActiveSubsCount)
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Subscription List";
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        SubRec: Record "Subscription Plans Table";
                    begin
                        SubRec.SetRange(Status, SubRec.Status::Active);
                        PAGE.RunModal(PAGE::"Subscription List", SubRec);
                    end;
                }
            }
        }
    }

    var
        ActiveSubsCount: Integer;
        Subscription: Record "Subscription Plans Table";

    trigger OnOpenPage()

    begin
        ActiveSubsCount := CountActiveSubscriptions();

    end;

    local procedure CountActiveSubscriptions(): Integer
    begin
        Subscription.Reset();
        Subscription.SetRange(Status, Subscription.Status::Active);
        exit(Subscription.Count());
    end;

    trigger OnAfterGetRecord()
    var
        SubsChecker: Codeunit "subscription expiry checker";
    begin
        SubsChecker.CheckAndNotify();
        
    end;
}

