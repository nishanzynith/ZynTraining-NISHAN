table 50114 "Zyn_Technician Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Tech ID"; Code[20])
        {
            DataClassification = CustomerContent;
            editable = false;
        }

        field(2; "Tech Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }

        field(3; "Phone Number"; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(4; "department"; Enum "Zyn_Depatment_enum")
        {
            DataClassification = CustomerContent;
        }
        field(5; "No Of Problems"; Integer)
        {
            Caption = 'No Of Problems';
            FieldClass = FlowField;
            CalcFormula = count("Zyn_Customer Problem" where("Technician" = field("Tech ID")));
        }


    }

    keys
    {
        key(PK; "Tech ID", "Tech Name") { Clustered = true; }
    }
    trigger OnInsert()
    var
        LastTech: Record "Zyn_Technician Table";
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