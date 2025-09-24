page 50103 "Zyn_Index List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Zyn_Index Table";
    CardPageId = "Zyn_Index Card";


    layout
    {
        area(Content)
        {
            repeater("Index List")
            {
                field(Index; Rec.Index)
                {

                }

                field(Desc; Rec.Desc)
                {

                }

                field(percentinc; Rec.percentinc)
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