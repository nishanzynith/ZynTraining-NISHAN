table 50119 "Zyn_Expense Claim Table"
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
            TableRelation = "Zyn_Employee Table"."Emp ID";
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
    var
        myInt: Integer;
}