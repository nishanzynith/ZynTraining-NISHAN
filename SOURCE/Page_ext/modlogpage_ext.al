pageextension 50106 Modifylogext extends "Customer List"
{
    layout
    { }
    actions
    {

        addfirst(Processing)
        {
            action(ModifyLog)
            {
                ApplicationArea = All;
                Caption = 'Modify Log';
                Image = Log;
                trigger OnAction()
                begin
                    RunModal(Page::"Modify Log")
                end;
            }

        }


    }
}