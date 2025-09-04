table 50117 "Plans Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Plan ID"; Code[6])
        {
            DataClassification = ToBeClassified;

        }

        field(2; Name; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Plan Status"; enum "Plans status Enum")
        {
            DataClassification = ToBeClassified;


            // trigger OnValidate()
            // begin
            //     if Rec."Plan Status" = Rec."Plan Status"::Inactive then begin
            //         DeactivateSubscriptions(Rec."Plan ID");
            //     end;
            // end;


        }

        field(5; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Plan ID")
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
        LastPlan: Record "Plans Table";
        LastId: Integer;
    begin
        if "Plan ID" = '' then begin
            if LastPlan.FindLast() then
                Evaluate(LastId, CopyStr(LastPlan."Plan ID", 2))
            else
                LastId := 99;

            "Plan ID" := 'P' + Format(LastId + 1);
        end;
    end;


    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        Subscription: Record "Subscription Plans Table";
    begin
        Subscription.Reset();
        Subscription.SetRange("Plan ID", Rec."Plan ID");

        if Subscription.FindSet() then begin
            repeat
                Subscription.Status := Subscription.Status::Inactive;
                Subscription.Modify();
            until Subscription.Next() = 0;
        end;
    end;


    trigger OnRename()
    begin

    end;

    procedure DeactivateSubscriptions(PlanId: Code[20])
    var
        Subscription: Record "Subscription Plans Table";
    begin

        Subscription.SetRange("Plan ID", PlanId);

        if Subscription.FindSet() then begin
            repeat
                Subscription.Status := Subscription.Status::Inactive;
                Subscription.Modify();
            until Subscription.Next() = 0;
        end;
    end;


}