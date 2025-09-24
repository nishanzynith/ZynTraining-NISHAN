page 50119 "Zyn_Modify Log"
{
    PageType = List;
    SourceTable = "Zyn_Modify Log Table";
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