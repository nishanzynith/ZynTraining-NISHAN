page 50160 "Assets List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Assets;
    CardPageId = "Assets Card";

    layout
    {
        area(Content)
        {

            repeater(Assets)
            {
                Editable = false;
                field("Asset Entry"; Rec."Asset Entry")
                {

                }

                field("Asset Type"; Rec."Asset Type")
                {

                }

                field("Serial No."; Rec."Serial No.")
                {

                }

                field(Vendor; Rec.Vendor) { }

                field("Procured Date"; Rec."Procured Date")
                {

                }

                field(Availability; Rec.Availability)
                {

                }


            }
        }
        area(Factboxes)
        {

            part(AssignmentCount; "Asset Assignment CueCard")
            {}
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
}