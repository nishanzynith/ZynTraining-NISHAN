page 50119 "Modify Log"
{
    PageType = List;
    SourceTable = ModLogTable;
    ApplicationArea = All;
    UsageCategory = None;

    Editable = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Field Name"; rec."Field Name") { }
                field("Modifyied By"; rec."Modified By") { }
                field("Old Value"; rec."Old Value") { }
                field("New Value"; rec."New Value") { }
            }
        }
    }

    actions
    {
        // No actions defined
    }
}