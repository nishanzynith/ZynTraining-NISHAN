page 50140 "Index List Part Page"
{
    PageType = ListPart;
    SourceTable = "Index List Part";
    ApplicationArea = All;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Details)
            {
                field(Year; rec.Year) { ApplicationArea = All; }
                field(Value; rec.Value) { ApplicationArea = All; }
            }
        }
    }
}