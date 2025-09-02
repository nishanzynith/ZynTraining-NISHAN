table 50114 Technician_table
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Tech ID"; Code[20])
        {
            DataClassification = CustomerContent;
            editable =false;
        }

        field(2; "Tech Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }

        field(3; "Phone Number"; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(4; "department"; Enum Depatment_enum)
        {
            DataClassification = CustomerContent;
        }
        field(5; "No Of Problems"; Integer)
        {
            Caption = 'No Of Problems';
            FieldClass = FlowField;
            CalcFormula = count("Customer Problem" where("Technician" = field("Tech ID")));
        }


    }

    keys
    {
        key(PK; "Tech ID", "Tech Name") { Clustered = true; }
    }
    trigger OnInsert()
    var
        LastTech: Record "Technician_table";
        LastId: Integer;
    begin
        if "Tech Id" = '' then begin
            if LastTech.FindLast() then
                Evaluate(LastId, CopyStr(LastTech."Tech Id", 2))
            else
                LastId := 99;

            "Tech Id" := 'T' + Format(LastId + 1);
        end;
    end;
}