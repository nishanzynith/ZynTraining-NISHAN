// codeunit 50272 "ZYN_ContactReplication"
// {
//     Subtype = Normal;
 
//     var
//         IsSync: Boolean;
 
//     // -----------------------------
//     // Event Subscribers
//     // -----------------------------
 
//     [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeInsertEvent', '', true, true)]
//     local procedure ContactOnBeforeInsert(var Rec: Record Contact; RunTrigger: Boolean)
//     var
//         CustomCompany: Record "ZYN_CustomCompany";
//     begin
//         CustomCompany.Reset();
//         if CustomCompany.Get(CompanyName()) then begin
//             if CustomCompany."Is Master" then exit; // Master can insert
//             if CustomCompany."Master Company Name" <> '' then
//                 Error(ContactSlaveInsertErr, CompanyName()); // Slave cannot insert
//             // Standalone companies are allowed
//         end;
//     end;
 
//     [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeModifyEvent', '', true, true)]
//     local procedure ContactOnBeforeModify(var Rec: Record Contact; RunTrigger: Boolean)
//     var
//         CustomCompany: Record "ZYN_CustomCompany";
//     begin
//         CustomCompany.Reset();
//         if CustomCompany.Get(CompanyName()) then begin
//             if CustomCompany."Is Master" then exit; // Master can modify
//             if CustomCompany."Master Company Name" <> '' then
//                 Error(ContactSlaveModifyErr, CompanyName()); // Slave cannot modify
//             // Standalone companies can modify freely
//         end;
//     end;
 
//     [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterInsertEvent', '', true, true)]
//     local procedure ContactOnAfterInsert(var Rec: Record Contact; RunTrigger: Boolean)
//     var
//         SlaveCompany: Record "ZYN_CustomCompany";
//     begin
//         if IsSync then exit;
//         if not IsMasterCompany() then exit;
 
//         IsSync := true; // Start replication lock
 
//         // Replicate to all slave companies
//         SlaveCompany.Reset();
//         SlaveCompany.SetRange("Master Company Name", CompanyName());
//         if SlaveCompany.FindSet() then
//             repeat
//                 ReplicateContactToCompany(Rec, SlaveCompany.Name);
//             until SlaveCompany.Next() = 0;
 
//         IsSync := false; // Release replication lock
//     end;
 
//     [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterModifyEvent', '', true, true)]
//     local procedure ContactOnAfterModify(var Rec: Record Contact; RunTrigger: Boolean)
//     var
//         SlaveCompany: Record "ZYN_CustomCompany";
//     begin
//         if IsSync then exit;
//         if not IsMasterCompany() then exit;
 
//         IsSync := true; // Prevent recursion
 
//         SlaveCompany.Reset();
//         SlaveCompany.SetRange("Master Company Name", CompanyName());
//         if SlaveCompany.FindSet() then
//             repeat
//                 UpdateContactInSlaveCompany(Rec, SlaveCompany.Name);
//             until SlaveCompany.Next() = 0;
 
//         IsSync := false; // Release replication lock
//     end;
 
//     // -----------------------------
//     // Helper Procedures
//     // -----------------------------
 
//     local procedure IsMasterCompany(): Boolean
//     var
//         CustomCompany: Record "ZYN_CustomCompany";
//     begin
//         CustomCompany.Reset();
//         CustomCompany.SetRange("Is Master", true);
//         CustomCompany.SetRange(Name, CompanyName());
//         exit(CustomCompany.FindFirst());
//     end;
 
//     local procedure ReplicateContactToCompany(SourceContact: Record Contact; TargetCompany: Text)
//     var
//         NewContact: Record Contact;
//         Rel: Record "Contact Business Relation";
//         SourceRel: Record "Contact Business Relation";
//     begin
//         NewContact.ChangeCompany(TargetCompany);
//         Rel.ChangeCompany(TargetCompany);
 
//         if not NewContact.Get(SourceContact."No.") then begin
//             NewContact.Init();
//             NewContact.TransferFields(SourceContact, true);
//             NewContact.Insert(true);
 
//             SourceRel.Reset();
//             SourceRel.SetRange("Contact No.", SourceContact."No.");
//             if SourceRel.FindSet() then
//                 repeat
//                     Rel.Init();
//                     Rel.TransferFields(SourceRel, true);
//                     Rel.Insert(true);
//                 until SourceRel.Next() = 0;
//         end;
//     end;
 
//     local procedure UpdateContactInSlaveCompany(SourceContact: Record Contact; TargetCompany: Text)
//     var
//         ContactSlave: Record Contact;
//         Rel: Record "Contact Business Relation";
//         SourceRel: Record "Contact Business Relation";
//     begin
//         ContactSlave.ChangeCompany(TargetCompany);
//         Rel.ChangeCompany(TargetCompany);
 
//         if ContactSlave.Get(SourceContact."No.") then
//             ContactSlave.Delete(true); // Delete existing contact to avoid recursion
 
//         // Insert updated contact
//         ContactSlave.Init();
//         ContactSlave.TransferFields(SourceContact, true);
//         ContactSlave.Insert(true);
 
//         // Sync Contact Business Relation
//         Rel.DeleteAll();
//         SourceRel.Reset();
//         SourceRel.SetRange("Contact No.", SourceContact."No.");
//         if SourceRel.FindSet() then
//             repeat
//                 Rel.Init();
//                 Rel.TransferFields(SourceRel, true);
//                 Rel.Insert(true);
//             until SourceRel.Next() = 0;
//     end;
 
//     // -----------------------------
//     // Labels
//     // -----------------------------
//     var
//         ContactInsertErr: Label 'You cannot create contacts directly in the slave company: %1', Locked = true;
//         ContactSlaveInsertErr: Label 'You cannot create contacts in a slave company: %1', Locked = true;
//         ContactSlaveModifyErr: Label 'You cannot modify contacts in a slave company: %1', Loc