page 50115 "Zyn_Field Buffer List Page"
{
    PageType = List;
    SourceTable = "Zyn_Buffer Field";
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

