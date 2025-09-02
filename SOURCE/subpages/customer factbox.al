page 50128 "Customer Contact Factbox"
{
    PageType = CardPart;
    SourceTable = Contact;
    Caption = 'Customer Contact';
    ApplicationArea = All;



    layout
    {

        area(content)
        {

            group("")
            {
                Visible = hascontent;
                field("Contact No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Contact ID';
                    DrillDown = true;
                    Lookup = true;
                    trigger OnDrillDown()
                    var
                        ContactCard: Page "Contact Card";
                    begin
                        ContactCard.SetRecord(Rec);
                        ContactCard.Run();
                    end;
                }

                field("Contact Name"; rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Contact Name';
                    DrillDown = true;
                    Lookup = true;
                    trigger OnDrillDown()
                    var
                        ContactCard: Page "Contact Card";
                    begin
                        ContactCard.SetRecord(Rec);
                        ContactCard.Run();
                    end;
                }
            }
        }
    }
    var
        HasContent: Boolean;

    trigger OnAfterGetcurrRecord()

    begin
        HasContent := (rec."No." <> '');
    end;
}
