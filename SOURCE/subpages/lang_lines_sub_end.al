page 50102 "Posted Ending Text"
{
    PageType = ListPart;
    SourceTable = "Beginning Text Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(text_code; Rec.begintextcode)
                {
                    ApplicationArea = all;

                }
                field(Text; rec.Text)
                {
                    ApplicationArea = All;

                }

            }
        }
    }
}