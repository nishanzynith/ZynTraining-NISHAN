page 50129 "Zyn_BeginText credit Subpage"
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
                field(Text; rec.Text) { ApplicationArea = All; }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CurrPage.SetRecord(Rec);
    end;
}
