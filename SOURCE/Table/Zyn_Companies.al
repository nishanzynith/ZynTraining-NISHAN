table 50121 "Zynith_Company"
{
    Caption = 'Zynith Company';
    DataPerCompany = false;

    fields
    {
        field(1; Name; Text[30])
        {
            Caption = 'Name';
            trigger OnValidate()
            begin
                if xRec.Name <> '' then
                    Error(nameerr);
            end;
        }
        field(2; "Evaluation Company"; Boolean)
        {
            Caption = 'Evaluation Company';
        }
        field(3; "Display Name"; Text[250])
        {
            Caption = 'Display Name';
        }
        field(8000; Id; Guid)
        {
            Caption = 'Id';
        }
        field(8005; "Business Profile Id"; Text[250])
        {
            Caption = 'Business Profile Id';
        }

        field(4; "Is Master"; Boolean)
        {
            Caption = 'Is Master';
            ToolTip = 'Select Your Master Company.';
            trigger OnValidate()
            var
                Zyn_company: Record Zynith_Company;
            begin
                if "Is Master" then begin
                    // Check if another record is already true
                    Zyn_company.Reset();
                    Zyn_company.SetRange("Is Master", true);
                    if Zyn_company.FindFirst() then
                        if Zyn_company.Name <> Rec.Name then
                            Error(comperr, Zyn_company.Name);
                end;
            end;
        }

        field(5; "Master Company"; Text[30])
        {
            Caption = 'Master Company';
            ToolTip = 'This is the Master Company ';
            TableRelation = Zynith_Company.Name;
            trigger OnValidate()
            begin
                if ("Is Master") or (Rec.Name = rec."Master Company") then
                    Error(Mastercomperr, rec.Name);
            end;
        }
    }

    keys
    {
        key(Key1; Name)
        {
            Clustered = true;
        }
    }

    var
        nameerr: label 'Name cannot be changed once filled.';
        comperr: label 'Only one Company can be selected as Master in a time .Company :%1 is already selected.';
        mastercomperr: label 'The company: %1 has been selected. Cannot assign another company to a Master Company Or to Itself';
}