codeunit 50137 "Zyn_Last Sale Price"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterSalesInvLineInsert, '', false, false)]
    procedure lastpricefinder(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; ItemLedgShptEntryNo: Integer; WhseShip: Boolean; WhseReceive: Boolean; CommitIsSuppressed: Boolean; var SalesHeader: Record "Sales Header"; var TempItemChargeAssgntSales: Record "Item Charge Assignment (Sales)" temporary; var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary; PreviewMode: Boolean)
    var
        LastSoldPrice: Record "Zyn_Last Price Finder";
    begin
        SalesInvLine.Reset();
        SalesInvLine.SetRange("Document No.", SalesInvHeader."No.");

        if SalesInvLine.FindSet() then begin
            repeat
                LastSoldPrice.Init();
                LastSoldPrice."Customer No." := SalesInvHeader."Sell-to Customer No.";
                LastSoldPrice."Item No." := SalesInvLine."No.";
                LastSoldPrice."Item Price" := SalesInvLine."Unit Price";
                LastSoldPrice."Posting date" := SalesInvHeader."Posting Date";
                LastSoldPrice.Insert(true);
            until SalesInvLine.Next() = 0;
        end;
    end;
}

