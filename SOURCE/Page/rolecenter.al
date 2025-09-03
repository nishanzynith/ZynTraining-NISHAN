page 50105 MyCustomerRoleCenter
{
    PageType = RoleCenter;
    ApplicationArea = All;
    UsageCategory = Administration; // Optional - controls where it shows in menus
    Caption = 'Customer Role Center';

    layout
    {
        area(RoleCenter)
        {
            part(CustomerCueTile; 50108)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Sections)
        {
            group(Customers)
            {
                action(CustomerList)
                {
                    Caption = 'Customers List';
                    ApplicationArea = All;
                    RunObject = PAGE "Customer List";
                    Image = Customer;
                }

                action(Update)
                {
                    Caption = 'Update Field';
                    ApplicationArea = All;
                    RunObject = PAGE Companies;
                    Image = Company;
                }
            }
            group(Contact)
            {
                action(Contacts)
                {
                    Caption = 'Contacts';
                    ApplicationArea = All;
                    Image = Calls;
                    RunObject = PAGE "Contact List";
                }
            }
            group("Sales group")
            {
                action(Sales)
                {
                    Caption = 'Sales';
                    ApplicationArea = All;
                    Image = Sales;
                    RunObject = PAGE "Sales List";


                }
            }

            group("Technician")
            {
                action(tech_help)
                {
                    Caption = 'Technician_list';
                    ApplicationArea = All;
                    Image = TextFieldConfirm;
                    RunObject = PAGE "Technician List";
                }
            }

             group("Asset Management")
            {
                action("Asset Type")
                {
                    ApplicationArea = All;
                    RunObject = Page "Asset Type";
                }
                action("Asset List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Asset Type";
                }

                action("Employee List")
                {
                    ApplicationArea = all;
                    runobject = Page "Employee entry List";
                }
            }
        }
    }
}