enum 50100 "Zyn_Purchase Approval Status"
{
    Extensible = false;
    Caption = 'Purchase Approval Status';

    value(0; Open)
    {
        Caption = 'Open';
    }

    value(1; Pending)
    {
        Caption = 'Pending';
    }

    value(2; Escalated)
    {
        Caption = 'Escalated';
    }

    value(3; Approved)
    {
        Caption = 'Approved';
    }

}
