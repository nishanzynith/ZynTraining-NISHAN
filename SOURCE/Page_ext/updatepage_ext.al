pageextension 50112 "Zyn_Companies Extension" extends Companies
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
                    Page.RunModal(PAGE::Zyn_UpdatePage)
                end;
            }

        }
    }
}