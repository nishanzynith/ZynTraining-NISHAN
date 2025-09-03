page 50161 "Assets Card"
{
    PageType = Card;
    ApplicationArea = All;
    // UsageCategory = Administration;
    SourceTable = Assets;
    
    layout
    {
        area(Content)
        {
            group("Assets Entry")
            {
                field("Asset Entry";Rec."Asset Entry")
                {
                    Editable = false;
                }

                field("Asset Type";Rec."Asset Type")
                {
                    TableRelation ="Asset Type".Name;
                }

                field("Serial No.";Rec."Serial No.")
                {

                }

                field(Vendor;Rec.Vendor){}

                field("Procured Date";Rec."Procured Date")
                {

                }

                field(Availability;Rec.Availability)
                {

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
}