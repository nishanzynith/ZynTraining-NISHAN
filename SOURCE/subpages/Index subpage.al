page 50140 "Zyn_Index List Part Page"
{
    PageType = ListPart;
    SourceTable = "Zyn_Index List Part";
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