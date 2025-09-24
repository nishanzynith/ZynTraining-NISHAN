table 50104 "Zyn_Budget Entry"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; fromdate; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }

        field(2; Enddate; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }

        field(3; "Expense Category"; Code[50])
        {
            TableRelation = "Zyn_Expense Category".Code;
            DataClassification = ToBeClassified;

        }

        field(4; Amount; Decimal)
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(PK; fromdate, Enddate, "Expense Category")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if fromdate = 0D then
            fromdate := CalcDate('<-CM>', workdate());

        if Enddate = 0D then
            Enddate := CalcDate('<CM>', WorkDate());
    end;
}