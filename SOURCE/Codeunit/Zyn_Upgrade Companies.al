codeunit 50114 UpgradeMyCompanies
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    var
        BC_Company: Record Company;
        Zyn_company: Record Zynith_Company;
        UpgradeTag: Codeunit "Upgrade Tag";
        TagName: Code[50];
    begin
        TagName := 'Company_update_v1';

        // Run only once per company
        if UpgradeTag.HasUpgradeTag(TagName) then
            exit;

        if BC_Company.FindSet() then
            repeat
                if not Zyn_company.Get(BC_Company.Name) then begin
                    Zyn_company.Init();
                    Zyn_company."Name" := BC_Company.Name;
                    Zyn_company."Display Name" := BC_Company."Display Name";
                    Zyn_company."Business Profile Id" := BC_Company."Business Profile Id";
                    Zyn_company."Evaluation Company" := BC_Company."Evaluation Company";
                    Zyn_company.Id := BC_Company.Id;
                    Zyn_company."Is Master" := false;
                    Zyn_company.Insert(true);
                end;
            until BC_Company.Next() = 0;

        // Mark upgrade as done in this company
        UpgradeTag.SetUpgradeTag(TagName);
    end;
}

