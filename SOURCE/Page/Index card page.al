page 50109 "Zyn_Index Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Zyn_Index Table";

    layout
    {
        area(Content)
        {
            group("Index card")
            {
                field(Index; Rec.Index)
                {
                    Caption = 'Index';
                }

                field(Desc; Rec.Desc)
                {
                    Caption = 'Description';
                }

                field(percentinc; Rec.percentinc)
                {
                    Caption = 'Percentage Increase';
                }

                field(startyear; Rec.startyear)
                {
                    Caption = 'Start Year';
                }

                field(endyear; Rec.endyear)
                {
                    Caption = 'End Year';
                }
            }
            part(IndexLines; "Zyn_Index List Part Page")
            {
                SubPageLink = Index = FIELD(Index);
                ApplicationArea = All;
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


    var
        myInt: Integer;
}