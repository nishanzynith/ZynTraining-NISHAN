page 50110 "Zyn_Custom Customer List Page"
{
    PageType = List;
    SourceTable = Customer;
    Caption = 'Custom Customer List';
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            group("Customer List")
            {
                repeater(General)
                {
                    field("No."; rec."No.") { ApplicationArea = All; }
                    field(Name; rec.Name) { ApplicationArea = All; }
                    field("Phone No."; rec."Phone No.") { ApplicationArea = All; }
                    field("E-Mail"; Rec."E-Mail") { ApplicationArea = All; }
                    field("Post Code"; Rec."Post Code") { ApplicationArea = All; }
                    field("County"; Rec."County") { ApplicationArea = All; }
                }
            }

            part("Sales Orders"; "Zyn_Customer Sales Orders")
            {
                ApplicationArea = All;
                SubPageLink = "Sell-to Customer No." = field("No.");

            }

            part("Sales Invoices"; "Zyn_Customer Sales Invoices")
            {
                ApplicationArea = All;
                SubPageLink = "Sell-to Customer No." = field("No.");
            }

            part("Sales Credit Memos"; "Zyn_CustomerSales Credit Memos")
            {
                ApplicationArea = All;
                SubPageLink = "Sell-to Customer No." = field("No.");
            }
        }
    }
}


