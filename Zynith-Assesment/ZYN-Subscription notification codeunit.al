codeunit 50109 "subscription expiry checker"
{
    Subtype = Normal;
    trigger OnRun()
    begin
        CheckAndNotify();
    end;

    procedure CheckAndNotify()
    var
        subplan: Record "Subscription Plans Table";
        TargetDate: Date;
    begin
        TargetDate := CalcDate('<+15D>', WorkDate());
        subplan.Reset();
        subplan.SetRange(subplan.Status, subplan.Status::Active);
        if subplan.FindSet() then
            repeat
            if SubPlan."End Date" = TargetDate then begin
                NotifyExpiry(subplan."Subscription ID", subplan."End Date");
                subplan."Reminder Sent" := true;
                subplan.Modify();
            end;
            until subplan.Next() = 0;
    end;

    procedure NotifyExpiry(subID: Code[20]; ExpiryDate: Date)
    var
        Notification: Notification;
    begin
        Notification.Id := 'CDEF7990-ABCD-0123-1234-567890ABCDEF';
        Notification.Message := StrSubstNo('Subscription %1 will expire on %2.', subID, Format(ExpiryDate));
        Notification.Scope := NotificationScope::LocalScope;
        Notification.Send();
    end;
}
