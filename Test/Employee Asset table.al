table 50116 "Employee Asset"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Employee ID"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Zyn_Employee Table"."Emp ID";
        }

        field(2; "Serial No."; Code[6])
        {
            DataClassification = ToBeClassified;
            TableRelation = Assets."Serial No.";

            // trigger OnLookup()
            // var
            //     AssetRec: Record Assets;
            // begin
            //     AssetRec.Reset();
            //     AssetRec.SetRange(Availability, true);

            //     if Page.RunModal(Page::"Assets List", AssetRec) = Action::LookupOK then
            //         Rec."Serial No." := AssetRec."Serial No.";
            // end;

            trigger OnLookup()
            var
                AssetRec: Record Assets;
            begin
                AssetRec.Reset();
                AssetRec.SetRange(Availability, true);

                if Page.RunModal(Page::"Assets List", AssetRec) = Action::LookupOK then begin
                    Rec."Serial No." := AssetRec."Serial No.";
                    Rec."Asset Type" := Assetrec."Asset Type";
                end;

            end;
        }

        field(3; "Asset Type"; text[250])
        {
            DataClassification = ToBeClassified;

        }

        field(4; Status; enum "Assigning Status")
        {
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // begin
            //     avis := true;
            //     Rvis := true;
            //     Lvis := true;
            //     case Status of
            //         Status::Assigned:
            //             begin
            //                 Avis := false;
            //                 Lvis := false;
            //             end;
            //         Status::Returned:
            //             begin
            //                 Lvis := false;
            //             end;
            //         Status::Lost:
            //             begin
            //                 Rvis := false;
            //             end;
            //     end;
            // end;

            trigger OnValidate()
            var
                ARec: Record Assets;
            begin
                ARec.Reset();
                ARec.SetRange("Serial No.", "Serial No.");
                if ARec.FindFirst() then begin
                    ARec.UpdateAvailability(Status);
                    ARec.Modify();
                end;
            end;


        }

        field(5; "Assinging Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Returned Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Lost Date"; Date)
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(PK; "Employee ID", "Serial No.")
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
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        ARec: Record Assets;
    begin
        ARec.Reset();
        case Status of
            Status::Assigned:
                begin
                    Error('Cannot delete a assinged Asset');
                end;
            status::Returned:
                begin
                    ARec.SetRange("Serial No.", "Serial No.");
                    if ARec.FindFirst() then begin
                        ARec.Availability := true;
                        ARec.Modify();
                    end;
                end;
            status::Lost:
                begin
                    ARec.SetRange("Serial No.", "Serial No.");
                    if ARec.FindFirst() then begin
                        ARec.Availability := false;
                        ARec.Modify();
                    end;
                end;
        end;
    end;



    trigger OnRename()
    begin

    end;

}