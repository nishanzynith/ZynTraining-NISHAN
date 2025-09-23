page 50150 "Pending Expense Approvals"
{
    PageType = List;
    SourceTable = ExpenseClaimTable;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Pending Expense Approvals';

    SourceTableView = where(Status = const(Pending));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Claim ID"; Rec."ClaimID")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        RecClaim: Record ExpenseClaimTable;
                    begin
                        if RecClaim.Get(Rec.ClaimID) then
                            PAGE.RunModal(PAGE::Expenseclaimcard, RecClaim);
                        Editable := false;
                    end;
                }
                field("Employee ID"; Rec.employeeID) { ApplicationArea = All; }
                field("Category"; Rec.Category) { ApplicationArea = All; }
                field("SubType"; Rec.SubType) { ApplicationArea = All; }
                field("Claim Date"; Rec.claimdate) { ApplicationArea = All; }
                field("Amount"; Rec.Amount) { ApplicationArea = All; }
                field("Status"; Rec.Status) { ApplicationArea = All; Editable = false; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ApproveClaim)
            {
                Caption = 'Approve';
                Image = Approve;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ValidateFullClaim(Rec);

                    Rec.Status := Rec.Status::Approved;
                    Rec.Modify(true);
                    Message('Claim %1 approved successfully.', Rec."ClaimID");
                    CurrPage.Update();
                end;


                // var
                //     Cat: Record Expenseclaimcat;
                //     ClaimCheck: Record ExpenseClaimTable;
                //     // availableamt : page Expenseclaimcard;
                //     MaxAllowed: Decimal;
                // begin
                //     // 1. Validate Bill Date (Claim Date)
                //     if Rec.billdate < CalcDate('<-3M>', WorkDate()) then
                //         Error('The claim date %1 is older than 3 months. Claim cannot be approved.', Rec.billdate);

                //     // 2. Validate Amount against Category Table
                //     Cat.Reset();
                //     Cat.SetRange(Catcode, Rec."Category");
                //     Cat.SetRange("SubType", Rec."SubType");

                //     if Cat.FindFirst() then begin
                //         MaxAllowed := ClaimCheck; // assume this field exists
                //         if Rec.Amount > MaxAllowed then
                //             Error('The claim amount %1 exceeds the allowed limit of %2 for this category/subtype.',
                //                   Rec.Amount, MaxAllowed);
                //     end;
                //     // 3. Check duplicates
                //     ClaimCheck.Reset();
                //     ClaimCheck.SetRange("EmployeeID", Rec."EmployeeID");
                //     ClaimCheck.SetRange("billDate", Rec."billDate");
                //     ClaimCheck.SetRange(Category, Rec.Category);
                //     ClaimCheck.SetRange(SubType, Rec.SubType);
                //     if ClaimCheck.FindFirst() then
                //         if ClaimCheck."ClaimID" <> Rec."ClaimID" then
                //             Error('Duplicate claim exists for Employee %1 on date %2 with same Category/SubType.',
                //                   Rec."EmployeeID", Rec."ClaimDate");

                //     // If all validations pass → Approve
                //     Rec.Status := Rec.Status::Approved;
                //     Rec.Modify(true);
                //     Message('Claim %1 approved successfully.', Rec."ClaimID");
                //     CurrPage.Update();
                // end;
            }


            action(RejectClaim)
            {
                Caption = 'Reject';
                Image = Cancel;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Rejected;
                    Rec.Modify(true);
                    CurrPage.Update();
                end;
            }
        }
    }
    procedure ValidateFullClaim(var Rec: Record ExpenseClaimTable)
var
    ClaimCheck: Record ExpenseClaimTable;
    ValidateAmount : page Expenseclaimcard;
begin
    // 1. Bill date check
    if Rec.billdate < CalcDate('<-3M>', WorkDate()) then
        Error('The claim date %1 is older than 3 months. Claim cannot be approved.', Rec.billdate);

    // 2. Amount checks
    ValidateAmount.ValidateAmountOnly(Rec);

    // 3. Duplicate check
    ClaimCheck.Reset();
    ClaimCheck.SetRange("EmployeeID", Rec."EmployeeID");
    ClaimCheck.SetRange("billDate", Rec."billDate");
    ClaimCheck.SetRange(Category, Rec.Category);
    ClaimCheck.SetRange(SubType, Rec.SubType);

    if ClaimCheck.FindFirst() then
        if ClaimCheck."ClaimID" <> Rec."ClaimID" then
            Error('Duplicate claim exists for Employee %1 on date %2 with same Category/SubType.',
                  Rec."EmployeeID", Rec."billDate");
end;

}
