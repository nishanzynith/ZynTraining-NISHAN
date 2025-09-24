tableextension 50100 "Zyn_Customer Table Extension" extends Customer
{
    fields
    {
        field(50100; "Credit Allowed"; Decimal)
        {
            Caption = 'Credit Allowed';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                // Direct logic to check credit limit
                if "Credit Allowed" < "Credit Used" then
                    Error(
                        'Credit limit exceeded!\nCredit Allowed: %1\nCredit Used: %2',
                        "Credit Allowed", "Credit Used");
            end;
        }

        field(50101; "Credit Used"; Decimal)
        {
            Caption = 'Credit Used';
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."Line Amount" WHERE("Sell-to Customer No." = FIELD("No.")));
            Editable = false;
        }


    }

    trigger OnModify()
    begin
        // Direct logic again inside modify trigger
        if "Credit Allowed" < "Credit Used" then
            Error(
                'Credit limit exceeded while modifying the customer.\nCredit Allowed: %.2f\nCredit Used: %.2f',
                "Credit Allowed", "Credit Used");
    end;
}
