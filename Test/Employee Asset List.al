page 50163 "Employee Assets"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Employee Asset";
    CardPageId = "Employee Asset Card";

    layout
    {
        area(Content)
        {
            repeater("Employee Asset")
            {
                field("Employee ID"; Rec."Employee ID")
                {

                }

                field("Serial No."; Rec."Serial No.") { }

                field("Asset Type"; Rec."Asset Type") { Editable = false; }
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
                                    Avis := false;
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
        area(Factboxes)
        {
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
        Avis: boolean;
        Rvis: Boolean;
        Lvis: Boolean;
}