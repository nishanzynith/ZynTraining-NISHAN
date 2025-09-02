pageextension 50101 "Customer Card contact ext" extends "Customer Card"
{
    layout
    {
        addfirst(FactBoxes)
        {
            part(CustomerContactFactbox; "Customer Contact Factbox")
            {
                SubPageLink = "No." = FIELD("Primary Contact No.");
                ApplicationArea = All;
            }
        }
    }
}

pageextension 50104 "Customer List contact ext" extends "Customer List"
{
    layout
    {
        addfirst(FactBoxes)
        {
            part(CustomerContactFactbox; "Customer Contact Factbox")
            {
                SubPageLink = "No." = FIELD("Primary Contact No.");
                ApplicationArea = All;
            }
        }
    }
}
pageextension 50113 "Customer Card Cue Factbox" extends "Customer Card"
{
    layout
    {
        addfirst(factboxes)
        {
            part(CustomerSalesStatus; "Customer Sales Status Factbox")
            {
                SubPageLink = "No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }
}

pageextension 50111 "Customer list Cue Factbox" extends "Customer List"
{
    layout
    {
        addfirst(factboxes)
        {
            part(CustomerSalesStatus; "Customer Sales Status Factbox")
            {
                SubPageLink = "No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }
}