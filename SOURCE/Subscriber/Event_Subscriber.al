
codeunit 50115 compchangepublisher
{
    [IntegrationEvent(false, false)]
    procedure onaddcustomercreated("customer rec": Record Customer)
    begin

    end;
}

codeunit 50116 compchangesubs
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::compchangepublisher, 'onaddcustomercreated', '', false, false)]
    local procedure OnCustomerCreated("customer rec": Record Customer)
    var
        TargetCustomer: Record Customer;
        CompanyName: Text;
    begin

        CompanyName := 'Wayne Enterprises';

        if TargetCustomer.ChangeCompany(CompanyName) then begin
            if not TargetCustomer.Get("customer rec"."No.") then begin
                TargetCustomer.Init();
                TargetCustomer.TransferFields("customer rec");
                TargetCustomer.Insert();
            end;
        end else
            Error('Unable to access target company: %1', CompanyName);
    end;
}

codeunit 50100 "Loyalty Points Handler"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure AddLoyaltyPoints(
        var SalesHeader: Record "Sales Header";
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        SalesShptHdrNo: Code[20];
        RetRcpHdrNo: Code[20];
        SalesInvHdrNo: Code[20];
        SalesCrMemoHdrNo: Code[20];
        CommitIsSuppressed: Boolean;
        InvtPickPutaway: Boolean;
        var CustLedgerEntry: Record "Cust. Ledger Entry";
        WhseShip: Boolean;
        PreviewMode: Boolean)
    var
        Customer: Record Customer;
    begin
        if PreviewMode then
            exit;

        // Only process if an invoice was posted
        if SalesInvHdrNo = '' then
            exit;

        if Customer.Get(SalesHeader."Sell-to Customer No.") then begin
            Customer.Points := Customer.Points + 10;
            Customer.Modify();
        end;
    end;
}

codeunit 50101 "Loyalty Points PreCheck"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure PreventPosting(
        var SalesHeader: Record "Sales Header";
        var IsHandled: Boolean)
    var
        Customer: Record Customer;
    begin
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) or (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) then begin
            if Customer.Get(SalesHeader."Sell-to Customer No.") then
                Customer.CalcFields("Loyalty Points");

            if Customer."Loyalty Points" >= 10000 then begin
                Error('Posting blocked. Customer has more than 40 loyalty points.');
            end;
        end;
    end;
}
