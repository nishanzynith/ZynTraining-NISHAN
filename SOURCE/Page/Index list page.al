page 50103 "Index List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = IndexTable;
    CardPageId = "Index card";

    
    layout
    {
        area(Content)
        {
            repeater("Index List")
            {
                field(Index;Rec.Index)
                {
                    
                }

                field(Desc;Rec.Desc)
                {

                }

                field(percentinc;Rec.percentinc)
                {

                }
            }
        }
    }
    
    // actions
    // {
    //     area(Processing)
    //     {
    //         action(ActionName)
    //         {
                
    //             trigger OnAction()
    //             begin
                    
    //             end;
    //         }
    //     }
    // }
}