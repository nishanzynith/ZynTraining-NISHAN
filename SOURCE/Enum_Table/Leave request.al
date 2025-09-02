enum 50105 "Leave Approval Status"
{
    Extensible = false;
    Caption = 'Approval Status';

    value(0; Pending)
    {
        Caption = 'Pending';
    }

    value(1; Approved)
    {
        Caption = 'Approved';
    }

    value(2; Rejected)
    {
        Caption = 'Rejected';
    }
}