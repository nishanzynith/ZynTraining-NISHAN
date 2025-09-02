page 50101 "Beginning Text Subpage"
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
                field(Text; rec.Text) { ApplicationArea = All; }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CurrPage.SetRecord(Rec);
    end;
}
