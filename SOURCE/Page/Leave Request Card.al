page 50149 "Leave Request card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Leave Request";

    layout
    {
        area(Content)
        {
            group("Leave request details")
            {
                field("Employee ID"; Rec."Employee ID") { }
                field("Leave Category"; Rec."Leave Category") { TableRelation = "Leave Category"."Category Name"; }
                field(Reason; Rec.Reason) { }
                field("Start Date"; Rec."Start Date") { }
                field("End Date"; Rec."End Date") { }
                field("Remaining Days"; GetRemainingDays()){}
            }
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

    var
        myInt: Integer;

    procedure GetRemainingDays(): Integer
    var
        LeaveBal: Record "Leave Balance";
    begin
        if LeaveBal.Get(Rec."Employee ID", Rec."Leave Category") then
            exit(LeaveBal."Remaining Days")
    end;
}