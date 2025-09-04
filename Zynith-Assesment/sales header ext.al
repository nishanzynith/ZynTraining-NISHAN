tableextension 50102 "Sales Inv Header extenstion" extends "Sales Header"
{
    fields
    {
        field(50104; "Subscription ID"; Code[20])
        {
            Caption = 'Subscription ID';
            DataClassification = CustomerContent;
        }

        field(50107;"Subscription Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(50105; "Subscription Amount"; Decimal)
        {
            Caption = 'Subscription Amount';
            DataClassification = CustomerContent;
        }

        field(50108;"From Subscription";boolean)
        {
            Caption = 'From Subscription';
            DataClassification = ToBeClassified;
        }
    }
    
    keys
    {
        // Add changes to keys here
    }
    
    fieldgroups
    {
        // Add changes to field groups here
    }
    
    var
        myInt: Integer;
}