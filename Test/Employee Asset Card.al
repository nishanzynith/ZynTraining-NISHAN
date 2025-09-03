page 50164 "Employee Asset Card"
{
    PageType = Card;
    ApplicationArea = All;
    // UsageCategory = Administration;
    SourceTable = "Employee Asset";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Employee ID"; Rec."Employee ID")
                {

                }

                field("Serial No."; Rec."Serial No.")
                {
                    TableRelation = Assets."Serial No.";
                    // trigger OnValidate()
                    // var
                    //     Asset: Record Assets;
                    // begin
                    //     Asset.SetRange("Serial No.", rec."Serial No.");
                    //     if Asset.FindFirst() then
                    //         rec."Asset Type" := Asset."Asset Type";

                    // end;

                    
                }

                field("Asset Type"; Rec."Asset Type")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    trigger OnValidate()
                    begin
                        avis := true;
                        Rvis := true;
                        Lvis := true;
                        case Rec.Status of
                            rec.Status::Assigned:
                                begin
                                    Rvis := false;
                                    Lvis := false;
                                end;
                            rec.Status::Returned:
                                begin
                                    Lvis := false;
                                end;
                            rec.Status::Lost:
                                begin
                                    Rvis := false;
                                end;
                        end;
                    end;
                }
                field("Assinging Date"; Rec."Assinging Date")
                {
                    Editable = Avis;
                }

                field("Returned Date"; Rec."Returned Date")
                {
                    Editable = Rvis;
                }

                field("Lost Date"; rec."Lost Date")
                {
                    Editable = Lvis;
                }
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;

        Avis: boolean;
        Rvis: Boolean;
        Lvis: Boolean;
}