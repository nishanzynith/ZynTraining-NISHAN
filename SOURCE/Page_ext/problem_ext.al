pageextension 50119 "Zyn_CustomerCard Ext Problem" extends "Customer Card"
{
    actions
    {
        addlast(Processing)
        {

            action("Log Problem")
            {
                ApplicationArea = All;
                Caption = 'Problem';
                Image = Log;

                trigger OnAction()
                var
                    ProblemRec: Record "Zyn_Customer Problem";
                    CustomerRec: Record Customer;
                begin
                    CustomerRec.Get(Rec."No.");
                    ProblemRec.Init();
                    ProblemRec."Customer No." := CustomerRec."No.";
                    ProblemRec."customer Name" := CustomerRec."Name";
                    ProblemRec.Insert(true);
                    Page.Run(Page::"Zyn_Customer Problem Card Page", ProblemRec);
                end;
            }
        }
    }
}