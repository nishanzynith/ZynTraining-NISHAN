pageextension 50122 "rolecenter notification" extends "O365 Activities"
{
    layout
    { }

    actions
    { }
    trigger OnOpenPage()
    var
        MyNotifMgt: Codeunit "Zyn_Leave Req Notification Mgt";
    begin
        MyNotifMgt.ShowLeaveBalanceNotification();
        MyNotifMgt.ShowLeaveRejectNotification();
        MyNotifMgt.ShowLeavePendingNotification();
    end;
}