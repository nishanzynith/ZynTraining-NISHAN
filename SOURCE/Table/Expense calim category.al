table 50120 "Zyn_Expense claim category"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Catcode; code[6])
        {
            Caption = 'Claim Category Code';
            DataClassification = ToBeClassified;
        }

        field(2; Name; text[250])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }

        field(3; Subtype; text[250])
        {
            Caption = 'SubType';
            DataClassification = ToBeClassified;
        }

        field(4; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }

        field(5; Limit; Decimal)
        {
            Caption = 'Amount Limit';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; Catcode, Subtype, Name)
        {
            Clustered = true;
        }
    }

    var

    trigger OnInsert()
    begin

    end;

}