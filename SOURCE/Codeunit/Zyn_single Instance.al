codeunit 50119 "SyncControlMgt"
{
    var
        AllowBusinessRelationChange: Boolean;

    procedure SetAllowBusinessRelationChange(NewValue: Boolean)
    begin
        AllowBusinessRelationChange := NewValue;
    end;

    procedure GetAllowBusinessRelationChange(): Boolean
    begin
        exit(AllowBusinessRelationChange);
    end;

    procedure ClearAll()
    begin
        AllowBusinessRelationChange := false;
    end;

    // procedure SetSyncingCustomer(State: Boolean)
    // var 
    //     isSyncingCustomer : Boolean;
    // begin
    //     IsSyncingCustomer := State;
    // end;

    // procedure IsSyncingCustomer(): Boolean
    // begin
    //     exit(IsSyncingCustomer);
    // end;
}


