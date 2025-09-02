// table 50105 "Expense Cue"
// {
//     DataClassification = ToBeClassified;

//     fields
//     {
//         field(1; "Primary Key"; Integer)
//         {
//             DataClassification = SystemMetadata;
//         }
//         field(2; "Year Total"; Decimal)
//         {
//             Caption = 'Year';
//             FieldClass = FlowField;
//             CalcFormula = sum("Expense_Tracker".Amount
//                               where(Date = field("DateFilterYear")
//                               ,Expense_Category = field(CategoryFilter)));
        
//         }
//         field(3; "Month Total"; Decimal)
//         {
//             Caption = 'Month';
//             FieldClass = FlowField;
//             CalcFormula = sum("Expense_Tracker".Amount
//                               where(Date = field("DateFilterMonth"),Expense_Category = field(CategoryFilter)));
//         }
//         field(4; "Quarter Total"; Decimal)
//         {
//             Caption = 'Quarter';
//             FieldClass = FlowField;
//             CalcFormula = sum("Expense_Tracker".Amount
//                               where(Date = field("DateFilterQuarter"),Expense_Category = field(CategoryFilter)));
//         }
//         field(5; "Half Year Total"; Decimal)
//         {
//             Caption = 'Half Year';
//             FieldClass = FlowField;
//             CalcFormula = sum("Expense_Tracker".Amount
//                               where(Date = field("DateFilterHalfYear"),Expense_Category = field(CategoryFilter)));
//         }
//         field(10; "DateFilterYear"; Date)
//         {
//             FieldClass = FlowFilter;
//         }
//         field(11; "DateFilterMonth"; Date)
//         {
//             FieldClass = FlowFilter;
//         }
//         field(12; "DateFilterQuarter"; Date)
//         {
//             FieldClass = FlowFilter;
//         }
//         field(13; "DateFilterHalfYear"; Date)
//         {
//             FieldClass = FlowFilter;
//         }
//         field(14; "CategoryFilter"; text[100])
//         {
//             Caption = 'Category Filter';
//             FieldClass = FlowFilter;
            
//         }
//     }

//     keys
//     {
//         key(PK; "Primary Key")
//         {
//             Clustered = true;
//         }
//     }
// }
