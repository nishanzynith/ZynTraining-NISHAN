pageextension 50112 Updatefield extends Companies
{
    layout { }
    actions
    {

        addlast(processing)
        {

            action(Updatefield)
            {
                ApplicationArea = All;
                Caption = 'Updatefield';
                Image = UpdateDescription;
                trigger OnAction()
                begin
                    Page.RunModal(PAGE::UpdatePage)
                end;
            }

        }
    }
}