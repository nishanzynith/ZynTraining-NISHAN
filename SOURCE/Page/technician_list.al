page 50116 "Zyn_Technician List"
{
    PageType = List;
    SourceTable = "Zyn_Technician Table";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Zyn_Technician Card";

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
                field("No Of Problems"; Rec."No Of Problems")
                { }


            }
            part("Assigned Problems"; "Zyn_Technician Problems")
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