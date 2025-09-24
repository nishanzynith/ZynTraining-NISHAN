table 50102 "Zyn_Index List Part"
{
    Caption = 'Index LInes';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; entryno; integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;

        }

        field(2; Index; code[30])
        {
            TableRelation = "Zyn_Index Table".Index;
            DataClassification = SystemMetadata;

        }

        field(3; Year; code[4])
        {

        }

        field(4; Value; Decimal)
        {

        }
    }

    keys
    {
        key(PK; Index, entryno)
        {
            Clustered = true;
        }
    }


    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

}