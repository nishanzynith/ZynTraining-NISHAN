table 50105 "Zyn_Recurring Expense"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Category';
            AutoIncrement = true;


        }
        field(2; Category; Code[25])
        {
            DataClassification = ToBeClassified;
            Caption = 'Category';
        }

        field(3; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';

        }

        field(4; "Cycling Period"; Enum "Zyn_Cycling Period")
        {
            DataClassification = ToBeClassified;
            Caption = 'Cycling Period';
            trigger OnValidate()
            begin
                if ("Start Date" = 0D) then
                    exit;

                case rec."Cycling Period" of
                    rec."Cycling Period"::Weekly:
                        rec."Next Cycle Date" := CalcDate('<+1W>', "Start Date");
                    rec."Cycling Period"::Monthly:
                        rec."Next Cycle Date" := CalcDate('<+1M>', "Start Date");
                    rec."Cycling Period"::Quaterly:
                        rec."Next Cycle Date" := CalcDate('<+3M>', "Start Date");
                    rec."Cycling Period"::"Half Yearly":
                        rec."Next Cycle Date" := CalcDate('<+6M>', "Start Date");
                    rec."Cycling Period"::Yearly:
                        rec."Next Cycle Date" := CalcDate('<+1Y>', "Start Date");
                end;
            end;

        }

        field(5; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';

        }

        field(6; "Next Cycle Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Next Cycle Date';
            Editable = false;
        }

        field(7; Description; Text[250])
        {
            DataClassification = CustomerContent;
            caption = 'Description';
        }
    }

    keys
    {
        key(PK; ID)
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


    // local procedure CalcNextDate()
    // begin
    //     if ("Start Date" = 0D) then
    //         exit;

    //     case rec."Cycling Period" of
    //         rec."Cycling Period"::Weekly:
    //             rec."Next Cycle Date" := CalcDate('<+1W>', "Start Date");
    //         rec."Cycling Period"::Monthly:
    //             rec."Next Cycle Date" := CalcDate('<+1M>', "Start Date");
    //         rec."Cycling Period"::Quaterly:
    //             rec."Next Cycle Date" := CalcDate('<+3M>', "Start Date");
    //         rec."Cycling Period"::"Half Yearly":
    //             rec."Next Cycle Date" := CalcDate('<+6M>', "Start Date");
    //         rec."Cycling Period"::Yearly:
    //             rec."Next Cycle Date" := CalcDate('<+1Y>', "Start Date");
    //     end;
    // end;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}