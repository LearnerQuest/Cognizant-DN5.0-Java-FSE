public class EmployeeManagementTest {
    public static void main(String[] args) {
        EmployeeManager manager = new EmployeeManager(5);

        manager.addEmployee(new Employee(101, "Aashi", "Developer", 50000));
        manager.addEmployee(new Employee(102, "Riya", "Tester", 42000));
        manager.addEmployee(new Employee(103, "Ankit", "Manager", 70000));

        System.out.println();
        manager.displayEmployees();

        System.out.println("\nSearching employee with ID 102:");
        Employee employee = manager.searchEmployee(102);

        if (employee != null) {
            employee.displayEmployee();
        } else {
            System.out.println("Employee not found.");
        }

        System.out.println("\nDeleting employee with ID 102:");
        manager.deleteEmployee(102);

        System.out.println();
        manager.displayEmployees();
    }
}