page 50159 "Asset Type Card"
{
    PageType = Card;
    ApplicationArea = All;
    // UsageCategory = Administration;
    SourceTable = "Asset Type";
    
    layout
    {
        area(Content)
        {
            group("Assets Type Entry")
            {
                field(Category;Rec.Category)
                {
                    
                }

                field(Name;Rec.Name)
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