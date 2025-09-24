codeunit 50104 "Zyn_Leave Req Cue Mgt."
{
    procedure OpenLeaveBalance(Notification: Notification)
    var
        LeavePage: Page "Leave Request List";
    begin
        LeavePage.Run();
    end;
}
codeunit 50105 "Zyn_Leave Req Notification Mgt"
{
    //     procedure ShowLeaveBalanceNotification(EmployeeID: Code[20])
    // var
    //     Notification: Notification;
    //     LeaveReq: Record "Leave Request";
    // begin
    //     LeaveReq.Reset();
    //     LeaveReq.SetRange("Employee ID", EmployeeID);
    //     LeaveReq.SetRange(Status, LeaveReq.Status::Approved);

    //     // Pick the latest Approved leave by Request No. or Date
    //     if LeaveReq.FindLast() then begin
    //         Notification.Message :=
    //           StrSubstNo('Your leave balance is : %1 !', LeaveReq."Remaining Days");
    //     end else begin
    //         Notification.Message := 'No approved leave requests found!';
    //     end;

    //     Notification.Scope := NotificationScope::LocalScope;
    //     Notification.AddAction('View Balance', Codeunit::"My Notification Actions", 'OpenLeaveBalance');
    //     Notification.Send();
    // end;


    procedure ShowLeaveBalanceNotification()
    var
        Notification: Notification;
        LeaveReq: Record "Leave Request";
        // leaveBal: page "Leave Request card";
        remaining: integer;
    begin
        LeaveReq.Reset();
        LeaveReq.SetRange(Status, LeaveReq.Status::Approved);
        LeaveReq.SetCurrentKey(SystemModifiedAt);
        LeaveReq.SetAscending(SystemModifiedAt, true);

        Clear(Notification);
        Notification.Id := 'CDEF7890-ABCD-0123-1234-567890ABCDEF';
        Notification.Scope := NotificationScope::LocalScope;

        if LeaveReq.FindLast() then
            Notification.Message :=
                StrSubstNo('Last approved request: %1 for %2 days.',
                           LeaveReq."Employee ID", LeaveReq."End Date" - LeaveReq."Start Date" + 1)
        else
            Notification.Message := 'No approved leave requests found!';

        Notification.Send();
    end;

    //   procedure ShowLeaveBalanceNotification()
    // var
    //     Notification: Notification;
    //     EmployeeRec: Record "Employee Table"; 
    // begin
    //     if EmployeeRec.FindSet() then
    //         repeat
    //             Notification.Message :=
    //                 StrSubstNo('Hello %1, current leave request status is %2.',
    //                            EmployeeRec."Employee Name");

    //             Notification.Scope := NotificationScope::LocalScope;

    //             // Correctly reference action


    //             Notification.Send();
    //         until EmployeeRec.Next() = 0;
    // end;

    procedure ShowLeaveRejectNotification()
    var
        Notification: Notification;
        LeaveReq: Record "Leave Request";
        leaveBal: page "Leave Request card";
        remaining: integer;
    begin
        LeaveReq.Reset();
        LeaveReq.SetRange(Status, LeaveReq.Status::Rejected);
        LeaveReq.SetCurrentKey(SystemModifiedAt);
        LeaveReq.SetAscending(SystemModifiedAt, true);

        Clear(Notification);
        Notification.Id := 'CDEF7880-ABCD-0123-1234-567890ABCDEF';
        Notification.Scope := NotificationScope::LocalScope;

        if LeaveReq.FindLast() then
            Notification.Message :=
                StrSubstNo('Last Rejected request: %1 for %2 days.',
                           LeaveReq."Employee ID", LeaveReq."End Date" - LeaveReq."Start Date" + 1)
        else
            Notification.Message := 'No approved leave requests found!';

        Notification.Send();
    end;

    procedure ShowLeavePendingNotification()
    var
        Notification: Notification;
        LeaveReq: Record "Leave Request";
        leaveBal: page "Leave Request card";
        remaining: integer;
        pending: integer;
    begin
        LeaveReq.Reset();
        LeaveReq.SetRange(Status, LeaveReq.Status::Pending);
        LeaveReq.SetCurrentKey(SystemModifiedAt);
        LeaveReq.SetAscending(SystemModifiedAt, true);

        Clear(Notification);
        Notification.Id := 'CDEF7870-ABCD-0123-1234-567890ABCDEF';
        Notification.Scope := NotificationScope::LocalScope;
        pending := LeaveReq.Count;

        if LeaveReq.FindSet() then
            Notification.Message :=
                StrSubstNo('Pending requests: %1', pending)
        else
            Notification.Message := 'No approved leave requests found!';

        Notification.Send();
    end;

}



