codeunit 50112 Zyn_Customereventpublisher
{
    [IntegrationEvent(false, false)]
    procedure onnewcustomercreated("customer name": text)
    begin

    end;
}


codeunit 50113 Customercreatedsubs
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::Zyn_Customereventpublisher, 'onnewcustomercreated', '', false, false)]
    procedure HandleOnNewCustomerCreated("customer name": text)
    begin
        Message('A new customer has been added : %1', "customer name");
    end;
}