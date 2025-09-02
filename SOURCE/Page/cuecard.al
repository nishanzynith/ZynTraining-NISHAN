page 50108 CustomerCountCue
{
    PageType = CardPart;
    ApplicationArea = All;
    SourceTable = "Visit Log";
    Caption = 'Customer Count Cue';

    layout
    {
        area(content)
        {
            cuegroup("Visit log")
            {
                field(CustomerCount; Count)
                {
                    Caption = 'Total Customers';
                    ApplicationArea = All;
                    Style = StrongAccent; // Optional: adds color
                    Image = Time; // Optional: cue icon
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        CustomerList: Page "Customer List";
                        Visit: Record "Visit Log";
                        Customer: Record Customer;
                        TempCustomer: Record Customer temporary;
                    begin
                        Visit.Reset();
                        Visit.SetRange("Visit Date", WorkDate());

                        if Visit.FindSet() then begin
                            repeat
                                if Customer.Get(Visit."Customer No.") then begin
                                    if not TempCustomer.Get(Visit."Customer No.") then begin
                                        TempCustomer := Customer;
                                        TempCustomer.Insert();
                                    end;
                                end;
                            until Visit.Next() = 0;
                        end;
                        Page.RunModal(Page::"Customer List", TempCustomer);
                    end;
                }
            }
        }
    }

    var
        Count: Integer;

    trigger OnOpenPage()
    begin
        Count := GetCustomerCount();
    end;

    local procedure GetCustomerCount(): Integer
    var
        Visit: Record "Visit Log";
        Today: Date;
        Count: Integer;
    begin
        Today := WorkDate(); // Get current BC work date

        Visit.SetRange("Visit Date", Today);
        Count := Visit.Count();
        // if Visit.FindSet() then begin
        //     repeat
        //         Count += 1;
        //     until Visit.Next() = 0;
        // end;

        exit(Count);

    end;
}