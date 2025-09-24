page 50125 "Zyn_Posted Beginning Text"
{
    PageType = ListPart;
    SourceTable = "Zyn_Beginning Text Line";
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