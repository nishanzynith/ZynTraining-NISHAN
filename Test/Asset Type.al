table 50111 "Asset Type"
{
    DataClassification = ToBeClassified;
    
    fields
    {

        field(1;Category; enum "Asset Enum")
        {
            DataClassification = ToBeClassified;
            
        }

        field(2;Name;Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
    
    keys
    {
        key(PK;Category,Name)
        {
            Clustered = true;
        }
    }
    
    fieldgroups
    {
        
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
    
}