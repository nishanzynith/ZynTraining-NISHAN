// PageExtension for Customer Card
pageextension 50107 CuscreditCardExt extends "Customer Card"
{
    layout
    {
        addlast(Content)
        {
            group(CreditInfo)
            {
                Caption = 'Credit Information';

                field("Credit Allowed"; Rec."Credit Allowed")
                {
                    ApplicationArea = All;

                }

                field("Credit Used"; Rec."Credit Used")
                {
                    ApplicationArea = All;

                }

            }
            
        }
    }

    trigger OnModifyRecord(): Boolean
    begin
        if Rec."Credit Used" > Rec."Credit Allowed" then
            error('credit limit has been exceeded.');
    end;



}

