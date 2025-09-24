table 50119 ExpenseClaimTable
{
    DataClassification = ToBeClassified;
    caption = 'Expense CLaim Table';

    fields
    {
        field(1; ClaimID; Code[6])
        {
            Caption = 'Claim ID';
            DataClassification = ToBeClassified;
        }

        field(2; Category; Code[6])
        {
            Caption = 'Category of Claim';
            DataClassification = ToBeClassified;
        }

        field(3; employeeID; code[6])
        {
            Caption = 'Employee ID';
            DataClassification = ToBeClassified;
            TableRelation = "Employee Table"."Emp ID";
        }

        field(4; claimdate; Date)
        {
            Caption = 'Claim Date';
            DataClassification = ToBeClassified;
        }

        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }

        field(6; Status; enum Zyn_Expenseclaim)
        {
            DataClassification = ToBeClassified;
        }

        field(7; Bill; Blob)
        {
            Caption = 'Upload Bill';
            DataClassification = ToBeClassified;
        }

        field(8; Billdate; Date)
        {
            Caption = 'Bill Date';
            DataClassification = ToBeClassified;
        }

        field(9; Subtype; Text[250])
        {
            Caption = 'SubType';
            DataClassification = ToBeClassified;
        }

        field(10; Filename; text[250])
        {
            Editable = false;
            Caption = 'Bill Image Name';
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; ClaimID, employeeID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    // trigger OnInsert()
    // var
    //     rec: record ExpenseClaimTable;
    //     LastId: Integer;
    // begin
    //     if ClaimID = '' then begin
    //         if Rec.FindLast() then
    //             Evaluate(LastId, CopyStr(Rec.ClaimID, 2))
    //         else
    //             LastId := 99;

    //         ClaimID := 'C' + Format(LastId + 1);
    //     end;
    // end;

}