page 50105 "Zyn_Custom RoleCenter"
{
    PageType = RoleCenter;
    ApplicationArea = All;
    UsageCategory = Administration;
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
                    RunObject = PAGE "Zyn_Technician List";
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

                action("EmployeeList")
                {
                    ApplicationArea = all;
                    Runobject = Page "Zyn_Employee Entry List Page";
                }

                action("Employee Asset List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Employee Assets";
                }
            }

            group("Expense Management")
            {
                action("Expense Category")
                {
                    ApplicationArea = All;
                    RunObject = Page "Zyn_Expense Category List Page";
                }

                action("Expense List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Zyn_Expense List";
                }

                action("Recurring Expense")
                {
                    ApplicationArea = All;
                    RunObject = Page "Zyn_Recurring Expense";
                }

                action("Budget List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Zyn_Budget List Page";
                }

                action("Income List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Zyn_Income List";
                }

                action("Income category")
                {
                    ApplicationArea = All;
                    RunObject = Page "Zyn_Income Category List";
                }
            }

            group("Leave Management")
            {
                action("Leave Request List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Zyn_Leave Request List";
                }

                action("Employee List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Zyn_Employee Entry List Page";
                }

                action("Leave Category")
                {
                    ApplicationArea = All;
                    RunObject = Page "Zyn_Leave Category List";
                }
            }

            group("Assesment")
            {
                action("Plan List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Plan List";
                }

                action("Subscription")
                {
                    ApplicationArea = All;
                    RunObject = Page "Subscription List";
                }

            }
        }
    }
}