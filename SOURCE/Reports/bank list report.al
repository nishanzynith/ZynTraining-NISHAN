report 50136 "Bank Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'SOURCE/Layout/bankacclist.rdl';

    dataset
    {
        dataitem("Bank account lsit"; "Bank Account")
        {
            RequestFilterFields = "No.", "Date Filter";
            column(Bank_No; "No.")
            {

            }
            column(Bank_Name; name)
            {

            }
            column(Bank_Branch_No; "Bank Branch No.")
            {

            }
            column(Bank_Balance; "Balance (LCY)")
            {

            }
            column(Company_Name; CompanyName)
            {

            }
            column(Company_Pic; info.Picture)
            {

            }
            column(bank_label; bank_label)
            {

            }
        }
    }
    trigger OnPreReport()
    begin
        info.Get();
        info.CalcFields(Picture);
    end;

    var
        myInt: Integer;
        info: record "Company Information";
        bank_label: Label 'Bank Account report ';
}