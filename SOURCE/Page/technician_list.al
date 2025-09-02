page 50116 "Technician List"
{
    PageType = List;
    SourceTable = Technician_table;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Technician Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Technician ID"; rec."Tech ID")
                { }
                field("Name"; rec."Tech Name")
                { }
                field("Ph. No."; rec."Phone Number")
                { }
                field("No Of Problems";Rec."No Of Problems")
                { }
                

            }
            part("Assigned Problems"; "Technician Problems")
            {
                SubPageLink = "Technician" = field("Tech Id");
                ApplicationArea = All;
            }

        }
    }

    actions
    {
        area(processing)
        {
        }
    }


}