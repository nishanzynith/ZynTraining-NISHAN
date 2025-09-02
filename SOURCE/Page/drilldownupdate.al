page 50115 "Field Buffer List"
{
    PageType = List;
    SourceTable = "Buffer Field";
    ApplicationArea = All;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID"; rec."Field ID") { }
                field("Name"; rec."Field Name") { }

            }
        }
    }


}

