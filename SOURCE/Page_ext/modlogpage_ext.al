pageextension 50106 "Zyn_ModifyLog Ext" extends "Customer List"
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
                    RunModal(Page::"Zyn_Modify Log")
                end;
            }

        }


    }
}