codeunit 50108 "Subscription Billing"
{
    Subtype = Normal;

    trigger OnRun()
    begin
        ProcessSubscriptions();
    end;

    local procedure ProcessSubscriptions()
    var
        Subscription: Record "Subscription Plans Table";
    begin

        Subscription.SetRange("Next Billing Date", WorkDate());
        Subscription.SetRange(Status, Subscription.Status::Active);

        if Subscription.FindSet() then
            repeat
                if Subscription."End Date" >= Subscription."Next Billing Date" then
                    CreateSalesInvoice(Subscription);
            until Subscription.Next() = 0;
    end;

    local procedure CreateSalesInvoice(Subscription: Record "Subscription Plans Table")
    var
        SalesHeader: Record "Sales Header";
        saleline : Record "Sales Line";
        Plan: Record "Plans Table";
        InvoiceNo: Code[20];
    begin

        Plan.Reset();
        Plan.SetRange("Plan ID", Subscription."Plan ID");

        if not Plan.FindFirst() then
            Error('Plan %1 not found for Subscription %2', Subscription."Plan ID", Subscription."Subscription ID");


        InvoiceNo := 'SUBINV-' + Format(Subscription."Subscription ID") + '-' + Format(WorkDate(), 0,'<Year4><Month,2>');


        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        SalesHeader."No." := InvoiceNo;
        SalesHeader."Subscription ID" := Subscription."Subscription ID";
        SalesHeader."Subscription Name" := Plan.Name;
        SalesHeader."Document Date" := WorkDate();
        // SalesHeader.Amount := Plan.Fee;
        SalesHeader."From Subscription" := True;
        SalesHeader.Validate("Sell-to Customer No.", Subscription."Customer ID");
        SalesHeader.Insert();
        

        saleline.init();
        saleline."Document Type" := Saleline."Document Type"::Invoice;
        saleline."Document No." := SalesHeader."No.";
        saleline.Validate(Amount , Plan.fee);
        saleline.Insert();

        Subscription."Next Billing Date" := CalcDate('<1M>', Subscription."Next Billing Date");
        Subscription.Modify();
    end;
    
}
