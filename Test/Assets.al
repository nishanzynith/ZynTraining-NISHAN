table 50112 Assets
{
    DataClassification = ToBeClassified;
    LookupPageId = "Assets List";
    
    fields
    {
        field(1;"Asset Entry"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(2; "Asset Type"; Text[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Asset Type".Name;
        }

        field(3;"Serial No."; Code[6])
        {
            DataClassification = ToBeClassified;
            
        }

        field(4; "Procured Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(5; Vendor; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(6; Availability; Boolean)
        {
            DataClassification = ToBeClassified;
            InitValue = true;
        }
    }
    
    keys
    {
        key(PK; "Asset Entry","Serial No.")
        {
            Clustered = true;
        }

    }
    
    fieldgroups
    {
        // Add changes to field groups here
    }
    
    var
        myInt: Integer;
    
    trigger OnInsert()
    begin
        
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;

    procedure UpdateAvailability(Status: Enum "Assigning Status")
    begin
        case Status of
            Status::Assigned:
                Availability := false;
            Status::Returned:
                Availability := true;
            Status::Lost:
                Availability := false;
        end;
    end;
    
}