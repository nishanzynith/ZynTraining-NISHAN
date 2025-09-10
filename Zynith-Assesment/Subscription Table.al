table 50118 "Subscription Plans Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Subscription ID"; code[6])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Customer ID"; Code[25])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }

        field(3; "Plan ID"; code[6])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Plans Table"."Plan ID";
        }

        field(4; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Subscription ID" <> '' then begin
                    "End Date" := Calcdate('<+1M', "Start Date");
                    rec.Modify();
                end;

                if "Subscription ID" <> '' then begin
                    "Next Billing Date" := "Start Date";
                end;
            end;
        }

        field(5; "Duration (Months)"; integer)
        {
            DataClassification = ToBeClassified;
            MaxValue = 11;
            trigger OnValidate()
            var
                StartDate: Date;
            begin
                StartDate := Rec."Start Date";

                if StartDate <> 0D then begin
                    Rec."End Date" := CalcDate(StrSubstNo('<%1M>', "Duration (Months)"), StartDate);
                    rec.Modify();
                end else begin
                    Rec."End Date" := 0D;
                end;
            end;
        }

        field(6; "End Date"; Date)
        {
            DataClassification = ToBeClassified;

        }

        field(7; Status; Enum "Subscription Enum")
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Next Billing Date"; Date)
        {
            DataClassification = SystemMetadata;

        }

        field(9; "Next Renewal Date"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Next Renewal Date" < "End Date" then begin
                    Error('The next renewal date should be more than the end date !!');
                end;
            end;
        }

        field(10; "Reminder Sent"; Boolean)
        {
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Subscription ID", "Customer ID")
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

    trigger OnInsert()
    var
        LastSub: Record "Subscription Plans Table";
        LastId: Integer;
    begin
        if "Subscription ID" = '' then begin
            if LastSub.FindLast() then
                Evaluate(LastId, CopyStr(LastSub."Subscription ID", 2))
            else
                LastId := 99;

            "Subscription ID" := 'S' + Format(LastId + 1);
        end;
    end;

}