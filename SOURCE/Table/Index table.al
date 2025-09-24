table 50139 "Zyn_Index Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Index; Code[30])
        {
            caption = 'Index';
            DataClassification = ToBeClassified;

        }

        field(2; Desc; text[250])
        {
            caption = 'Description';
            DataClassification = CustomerContent;
        }

        field(3; percentinc; decimal)
        {
            Caption = '% increase';
            DataClassification = CustomerContent;
        }

        field(4; startyear; code[4])
        {
            Caption = 'Start Year';
            DataClassification = CustomerContent;
        }

        field(5; endyear; code[4])
        {
            Caption = 'End Year';
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(Pk; Index)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        LastTech: Record "Zyn_Index Table";
        LastId: Integer;
    begin
        if Index = '' then begin
            if LastTech.FindLast() then
                Evaluate(LastId, CopyStr(LastTech.Index, 3))
            else
                LastId := 99;

            Index := 'IN' + Format(LastId + 1);
        end;
        GenIndexList();
    end;

    trigger OnModify()
    begin
        GenIndexList();
    end;

    trigger OnDelete()
    var
        IndexListPart: Record "Zyn_Index List Part";
    begin
        IndexListPart.SetRange(Index, Rec.Index);
        if IndexListPart.FindSet() then
            IndexListPart.DeleteAll();
    end;

    local procedure GenIndexList()
    var
        IndexListPart: Record "Zyn_Index List Part";
        YearInt: Integer;
        EndYearInt: Integer;
        Value: Decimal;
        year: Integer;
    begin
        IndexListPart.SetRange(Index, Rec.Index);
        if IndexListPart.FindSet() then
            IndexListPart.DeleteAll();

        if (startyear = '') or (endyear = '') then
            exit;

        if not Evaluate(YearInt, startyear) then
            exit;
        if not Evaluate(EndYearInt, endyear) then
            exit;

        if YearInt > EndYearInt then
            exit;

        Value := 100;
        for year := YearInt to EndYearInt do begin
            IndexListPart.Init();
            IndexListPart.EntryNo := 0;
            IndexListPart.Index := Rec.Index;
            IndexListPart.Year := Format(YearInt);
            IndexListPart.Value := Round(Value, 0.01);
            IndexListPart.Insert();

            Value := Value * (1 + (percentinc / 100));
            YearInt += 1;
        end;
    end;

}