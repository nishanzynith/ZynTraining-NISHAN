page 50102 "Zyn_Posted Ending Text"
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