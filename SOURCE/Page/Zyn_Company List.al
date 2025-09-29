page 50181 "Zynith Company List"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = Zynith_Company;
    Caption = 'Zynith Company List';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name) { }
                field("Display Name"; Rec."Display Name") { }
                field(Id; Rec.Id) { }
                field("Business Profile Id"; Rec."Business Profile Id") { }
                field("Evaluation Company"; Rec."Evaluation Company") { }
                field("Is Master"; Rec."Is Master") { }
                field("Master Company"; Rec."Master Company") { }
            }
        }

    }
}
