page 50165 "Asset Assignment CueCard"
{
    PageType = CardPart;
    SourceTable = "Employee Asset";
    Caption = 'Current Assignments';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup(Group)
            {
                field(AssignedCount; AssignedCount)
                {
                    ApplicationArea = All;
                    Caption = 'Currently Assigned';
                    trigger OnDrillDown()
                    var
                        EA: Record "Employee Asset";
                    begin
                        EA.SetRange(Status, EA.Status::Assigned);
                        PAGE.Run(PAGE::"Employee Assets", EA);
                    end;
                }
            }
        }
    }

    var
        AssignedCount: Integer;

    trigger OnAfterGetRecord()
    var
        EA: Record "Employee Asset";
    begin
        EA.SetRange(Status, EA.Status::Assigned);
        AssignedCount := EA.Count();
    end;
}
