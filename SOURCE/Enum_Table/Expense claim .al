enum 50110 Expenseclaim
{
    Extensible = true;
    
    value(0;pending)
    {
        Caption = 'Pending';
    }

    value(1; Approved)
    {
        Caption = 'Approved';
    }

    value(2;Rejected)
    {
        Caption = 'Rejected';
    }

    value(3; cancelled)
    {
        Caption = 'Cancelled';
    }
}