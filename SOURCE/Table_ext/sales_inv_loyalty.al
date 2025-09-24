tableextension 50106 "Zyn_Customer Loyalty Points" extends Customer
{
    fields
    {
        field(50107; "Points"; Integer)
        {
            Caption = 'Points';
        }

        field(50108; "Loyalty Points"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Points where("No." = field("No.")));
            Caption = 'Loyalty Points';
        }

        
    }
}
