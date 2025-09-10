page 50168 "Plans Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Plans Table";

    layout
    {
        area(Content)
        {
            group(Plans)
            {
                field("Plan ID"; Rec."Plan ID") { Editable = false; }
                field(Name; Rec.Name) { }
                field(Description; Rec.Description) { }
                field(Fee; Rec.Fee) { }
                field("Plan Status"; Rec."Plan Status") { }
            }
        }
    }
    
}