page 50147 "Zyn_Leave Category List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Zyn_Leave Category";
    editable = false;
    CardPageId = "Zyn_Leave Category Card";

    layout
    {
        area(Content)
        {
            repeater("Leave Category")
            {
                field("Category Name"; Rec."Category Name") { }
                field(Description; Rec.Description) { }
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