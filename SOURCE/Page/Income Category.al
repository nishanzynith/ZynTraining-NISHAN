page 50146 "Income Category List"
{
    PageType = List;
    SourceTable = "Income Category";
    Caption = 'Income Categories';
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; rec."Code")
                {
                    ApplicationArea = All;
                }
                field("Description"; rec."Description")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            part(IncomeStats; "Income Factbox")
            {
                SubPageLink = Code = FIELD(Code);
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
