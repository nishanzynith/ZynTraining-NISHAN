page 50125 "Posted Beginning Text"
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