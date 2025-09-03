page 50166 "Employee Asset History CueCard"
{
    PageType = CardPart;
    SourceTable = "Employee Asset";
    Caption = 'Asset History';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup(Group)
            {
                field(HistoryCount; HistoryCount)
                {
                    ApplicationArea = All;
                    Caption = 'History Entries';

                    trigger OnDrillDown()
                    var
                        EA: Record "Employee Asset";
                    begin
                        EA.SetRange("Employee ID", Rec."Employee ID"); 
                        PAGE.Run(PAGE::"Employee Assets", EA);
                    end;
                }
            }
        }
    }

    var
        HistoryCount: Integer;

    trigger OnAfterGetRecord()
    var
        EA: Record "Employee Asset";
    begin
        EA.SetRange("Employee ID", Rec."Employee ID"); 
        HistoryCount := EA.Count();
    end;
}

