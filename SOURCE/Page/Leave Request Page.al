page 50151 "Zyn_Leave Request List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Leave Request List';
    SourceTable = "Zyn_Leave Request";
    UsageCategory= Lists;
    CardPageId ="Zyn_Leave Request Card";
 
    layout
    {
        area(Content)
        {
            repeater(LeaveRequest)
            {
                Editable=false;
             field("Request ID";Rec.EntryID)
                {
                    ApplicationArea = All;
                }
                field("Employee ID";Rec."Employee ID")
                {
                    ApplicationArea = All;
                }
                field("Leave Category";Rec."Leave Category")
                {}
                 field(Reason; Rec.Reason)
                { }
                // field("Remaining leave"; Rec.)
                // { }
                field("Start Date"; Rec."Start Date")
                { }
                field("End Date"; Rec."End Date")
                { }
                field(Status;Rec.Status)
                {}
                field("Remaining Days";GetRemainingDays()){}
 
               
            }
           
        }
       
        }
    actions
    {
        area(Processing)
        {
            action("Leave request approval")
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    if (rec.Status.AsInteger()=0) or (rec.Status.AsInteger()=2) then 
                    begin  
                    recopy := rec;
                    ApproveLeaveRequest(rec);
                    CurrPage.Update();
                    end
                    else
                    Message('cannot approve an already approved request');
                end;
            }

            action("Leave request Reject")
            {
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    recopy := Rec;
                    RejectLeaveRequest(rec);
                    CurrPage.Update();

                end;
            }
        }
       
    }
  
 var 
 recopy : record "Zyn_Leave Request";
 notify : Notification;

//  trigger OnOpenPage()
// begin
//     recopy.Reset();  // clear old filters
//     recopy.SetRange("Employee ID", Rec."Employee ID");
//     recopy.SetRange(Status, recopy.Status::Approved);
//     recopy.SetCurrentKey(EntryID); 
//     if recopy.FindLast() then begin
//         notify.Id := 'LeaveApproved_' + Rec."Employee ID";
//         notify.Message :=
//           StrSubstNo('The request for leave by %1 has been approved', recopy."Employee ID");
//         notify.Scope := NotificationScope::LocalScope;
//         notify.Send();
//     end;
//  end;
 procedure ApproveLeaveRequest(var LeaveReq: Record "Zyn_Leave Request")
var
    LeaveBal: Record "Zyn_Leave Balance";
    DaysTaken: Integer;
begin


  
    DaysTaken := LeaveReq."End Date" - LeaveReq."Start Date" + 1;
     LeaveBal.Reset();
    LeaveBal.SetRange("Employee ID", LeaveReq."Employee ID");
    LeaveBal.SetRange("Leave Category", LeaveReq."Leave Category");

    if LeaveBal.FindFirst() then begin
        if LeaveBal."Remaining Days" < DaysTaken then begin
            LeaveReq.Status := LeaveReq.Status::Rejected;
            LeaveReq.Modify();
            Message('Not enough leave balance! %1 days remaining, but %2 days requested.',
                  LeaveBal."Remaining Days", DaysTaken);
            exit
           end;
    end;
        
    LeaveReq.Status := LeaveReq.Status::Approved;
    LeaveReq.Modify();

    LeaveBal.SetRange("Employee ID", LeaveReq."Employee ID");
    LeaveBal.SetRange("Leave Category", LeaveReq."Leave Category");
    if LeaveBal.FindFirst() then begin
        LeaveBal."Remaining Days" := LeaveBal."Remaining Days" - DaysTaken;
        LeaveBal."Last Updated" := Today;
        LeaveBal.Modify();
        Message('Leave request approved. %1 days deducted.', ReCopy."End Date" - ReCopy."Start Date" + 1);
    end else begin
        
        LeaveBal.Init();
        LeaveBal."Employee ID" := LeaveReq."Employee ID";
        LeaveBal."Leave Category" := LeaveReq."Leave Category";
        LeaveBal."Remaining Days" := -DaysTaken; 
        LeaveBal."Last Updated" := Today;
        LeaveBal.Insert();
    end;
end;

   procedure GetRemainingDays(): Integer
    var
        LeaveBal: Record "Zyn_Leave Balance";
    begin
        if LeaveBal.Get(Rec."Employee ID", Rec."Leave Category") then
            exit(LeaveBal."Remaining Days")
        else
            exit(0);
    end;

     procedure RejectLeaveRequest(var LeaveReq: Record "Zyn_Leave Request")
var
    LeaveBal: Record "Zyn_Leave Balance";
    DaysTaken: Integer;
begin
    if LeaveReq.Status = LeaveReq.Status::Approved then
    Message('Leave request has been approved , thus cannot be Rejected.');
    exit;
    LeaveReq.Status := LeaveReq.Status::Rejected;
    Message('Leave request Rejected.');
    LeaveReq.Modify();
end;

    }
 
   
 
 