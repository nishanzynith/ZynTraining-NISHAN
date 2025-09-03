codeunit 50107 "Update Availability"
{
    Subtype = Normal;

    trigger OnRun()
    var
        Asset: Record Assets;
    begin
        Asset.Reset();
        if Asset.FindSet() then
            repeat
                if (Asset."Procured Date" <> 0D) and
                   (CalcDate('<-5Y>', WorkDate()) > Asset."Procured Date") then begin
                    if Asset.Availability then begin
                        Asset.Availability := false;
                        Asset.Modify();
                    end;
                end;
            until Asset.Next() = 0;
    end;
}
