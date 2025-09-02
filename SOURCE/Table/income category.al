table 50103 "Income Category"
{
    Caption = 'Income Category';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Description"; Text[100])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

   
    trigger OnInsert()
    begin
        if "Code" = '' then
            Error('Category Code must not be empty.');
    end;
}
