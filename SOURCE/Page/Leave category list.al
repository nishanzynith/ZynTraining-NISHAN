page 50147 "Leave Category List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Leave Category";
    editable = false;
    CardPageId = "Leave Category Card";
    
    layout
    {
        area(Content)
        {
            repeater("Leave Category")
            {
                field("Category Name";Rec."Category Name"){}
                field(Description;Rec.Description){}
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
}