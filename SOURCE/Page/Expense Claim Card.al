page 50175 "Zyn_Expense Claim Card"
{
    Caption = 'Expense Claim Card';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Zyn_Expense Claim Table";

    layout
    {
        area(Content)
        {
            group(ExpenseClaim)
            {
                Caption = 'Expense Claim';
                field(ClaimID; Rec.ClaimID) { }
                field(employeeID; Rec.employeeID) { }
                field(Category; Rec.Category)
                {
                    trigger OnDrillDown()
                    var
                        expcat: Record "Zyn_Expense claim category";
                        claimcardpage: page "Zyn_Expense Claim Card";
                    begin
                        if Page.RunModal(Page::"Zyn_Expense Claim Category", expcat) = Action::LookupOK then begin
                            Rec."Category" := expcat.Catcode;
                            Rec.Subtype := expcat.Subtype;
                        end;
                        CalcAvailableLimit();
                    end;

                    trigger OnValidate()
                    begin
                        CalcAvailableLimit();
                    end;
                }
                field(Subtype; Rec.Subtype) { Editable = false; }
                field(claimdate; Rec.claimdate) { }
                field(Amount; Rec.Amount)
                {
                    trigger OnValidate()
                    begin
                        ValidateAmountOnly(rec);
                    end;
                }
                field(Filename; Rec.Filename)
                {
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        InStr: InStream;
                    begin
                        if Rec.Bill.HasValue then begin
                            Rec.Bill.CreateInStream(InStr);
                            DownloadFromStream(InStr, '', '', Rec.Filename, Rec.Filename);
                        end else
                            Message('No file has been uploaded.');
                    end;
                }
                field(Status; Rec.Status) { }
                field(Billdate; Rec.Billdate) { }
                field(Bill; Rec.Bill)
                {
                    trigger OnAssistEdit()
                    var
                        InStream: InStream;
                        FileName: Text;
                        outstr: OutStream;
                    begin
                        if UploadIntoStream('Select file', '', '', FileName, InStream) then begin
                            Rec.Bill.CreateOutStream(OutStr); // <-- Need OutStream, not InStream
                            CopyStream(OutStr, InStream);             // Copies file into Blob
                            rec.Filename := FileName;
                            Rec.Bill.CreateInStream(InStream);
                            Rec.Modify();
                            CurrPage.Update();
                        end;
                    end;

                    // trigger OnValidate()
                    // var
                    //     InStr: InStream;
                    //     FileMgmt: Codeunit "File Management";
                    //     openpdf: boolean;
                    // begin
                    //     if not OpenPDF and rec.Bill.HasValue then begin
                    //         OpenPDF := true; // prevent repeated triggers
                    //         rec.Bill.CreateInStream(InStr);
                    //         FileMgmt.DownloadFromStreamHandler(
                    //             InStr, // FromInStream
                    //             '',    // ToFolder (empty for default)
                    //             'MyFile.pdf', // ToFile
                    //             'Open PDF',   // DialogTitle
                    //             '');          // DialogCaption
                    //         OpenPDF := false;
                    //     end;
                    // end;
                }

                field(Availableamount; AvailableAmount) { Editable = false; }
            }
        }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(ImportAttachment)
    //         {
    //             Caption = 'Import File';
    //             ApplicationArea = All;

    //             trigger OnAction()
    //             var
    //                 InStream: InStream;
    //                 FileName: Text;
    //                 outstr: OutStream;
    //             begin
    //                 if UploadIntoStream('Select file', '', '', FileName, InStream) then begin
    //                     Rec.Bill.CreateOutStream(OutStr); // <-- Need OutStream, not InStream
    //                     CopyStream(OutStr, InStream);             // Copies file into Blob
    //                     rec.Filename := FileName;
    //                     Rec.Bill.CreateInStream(InStream);
    //                     Rec.Modify();
    //                     CurrPage.Update();
    //                 end;
    //             end;
    //         }

    //     }
    // }

    var
        AvailableAmount: Decimal;

    procedure CalcAvailableLimit()
    var
        ExpenseClaimRec: Record "Zyn_Expense Claim Table";
        ClaimCategoryRec: Record "Zyn_Expense claim category";
        TotalApproved: Decimal;
        StartDate: Date;
        EndDate: Date;
    begin
        Clear(AvailableAmount);
        TotalApproved := 0;

        if (Rec."EmployeeID" = '') or (Rec."Subtype" = '') or (Rec.Category = '') then
            exit;
        StartDate := CALCDATE('<-CY>', WORKDATE);
        EndDate := CALCDATE('<CY>', WORKDATE);

        ClaimCategoryRec.SetRange(Catcode, rec.Category);
        ClaimCategoryRec.SetRange(Subtype, rec.Subtype);
        if not ClaimCategoryRec.FindSet() then
            exit;

        ExpenseClaimRec.Reset();
        ExpenseClaimRec.SetRange("EmployeeID", Rec."EmployeeID");
        ExpenseClaimRec.SetRange(Category, Rec.Category);
        ExpenseClaimRec.SetRange("Subtype", Rec."Subtype");
        ExpenseClaimRec.SetRange(Status, ExpenseClaimRec.Status::Approved);
        ExpenseClaimRec.SetRange("ClaimDate", StartDate, EndDate);

        if ExpenseClaimRec.FindSet() then
            repeat
                TotalApproved += ExpenseClaimRec.Amount;
            until ExpenseClaimRec.Next() = 0;

        AvailableAmount := ClaimCategoryRec."Limit" - TotalApproved;
        CurrPage.Update();
    end;


    procedure ValidateAmountOnly(var Rec: Record "Zyn_Expense Claim Table")
    var
        Cat: Record "Zyn_Expense claim category";
        ClaimCheck: Record "Zyn_Expense Claim Table";
        MaxAllowed: Decimal;
        ApprovedAmount: Decimal;
    begin
        // Validate Amount against Category Table
        Cat.Reset();
        Cat.SetRange(Catcode, Rec."Category");
        Cat.SetRange("SubType", Rec."SubType");

        if Cat.FindFirst() then begin
            MaxAllowed := Cat.Limit; // category limit

            // Sum previously approved claims for employee/category/subtype
            ClaimCheck.Reset();
            ClaimCheck.SetRange("EmployeeID", Rec."EmployeeID");
            ClaimCheck.SetRange("Category", Rec."Category");
            ClaimCheck.SetRange("SubType", Rec."SubType");
            ClaimCheck.SetRange(Status, ClaimCheck.Status::Approved);

            ApprovedAmount := 0;
            if ClaimCheck.FindSet() then
                repeat
                    ApprovedAmount += ClaimCheck.Amount;
                until ClaimCheck.Next() = 0;

            // Add current claim amount
            ApprovedAmount += Rec.Amount;

            if ApprovedAmount > MaxAllowed then
                Error(
                    'The total approved amount %1 (including this claim) exceeds the allowed limit of %2 for this category/subtype.',
                    ApprovedAmount, MaxAllowed
                );
        end;
    end;

}