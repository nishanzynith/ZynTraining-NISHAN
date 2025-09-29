codeunit 50106 "Zyn_LastPrice Database Upgrade"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    var
        SalesInvLine: Record "Sales Invoice Line";
        SalesInvHeader: Record "Sales Invoice Header";
        LastPrice: Record "Zyn_Last Price Finder";
        UpgradeTag: Codeunit "Upgrade Tag";
        TagName: Code[50];
    begin
        TagName := 'LastPriceUpgrade_InsertOnly_v1';

        if not UpgradeTag.HasUpgradeTag(TagName) then begin
            if SalesInvLine.FindSet() then
                repeat
                    if SalesInvHeader.Get(SalesInvLine."Document No.") then begin

                        if (SalesInvLine."Sell-to Customer No." = '') or
                           (SalesInvLine."No." = '') then begin
                            LastPrice.Init();
                            LastPrice."Customer No." := SalesInvLine."Sell-to Customer No.";
                            LastPrice."Item No." := SalesInvLine."No.";
                            LastPrice."Posting Date" := SalesInvHeader."Posting Date";
                            LastPrice."Item Price" := SalesInvLine."Unit Price";
                            LastPrice."Line No." := SalesInvLine."Line No.";
                            LastPrice.Insert(true);

                        end
                        else begin

                            LastPrice.Init();
                            LastPrice.Validate("Posting Date", SalesInvLine."Posting Date");
                            LastPrice.Validate("Item Price", SalesInvLine."Unit Price");
                            LastPrice.modify(true);
                        end;

                    end;
                until SalesInvLine.Next() = 0;

            UpgradeTag.SetUpgradeTag(TagName);
        end;
    end;
}