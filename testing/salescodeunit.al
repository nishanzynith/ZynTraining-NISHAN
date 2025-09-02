codeunit 50110 "Sales quote check"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order (Yes/No)", 'OnAfterSalesQuoteToOrderRun', '', false, false)]
    local procedure CheckApprovalStatus(salesHeader: Record "Sales Header")
    begin
        if salesHeader."summa" <> salesHeader."summa"::Approved then
            Error('You cannot post this Purchase Order because it is not approved.');
    end;
}
