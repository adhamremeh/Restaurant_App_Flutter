import 'package:mat3ami/business_logic/models/employee.dart';
import 'package:mat3ami/business_logic/services/backend_services.dart';
import 'package:mysql1/mysql1.dart';

class EmployeeServices {
//add new employee
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Neshel el managerSsn 3ashan ne2dar na5doh men el Employee aslan .... 3shan el parameter user feh managerSsn required //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static Future<void> addNewEmployeeToDatabase(Employee user, int managerSsn) async {
    final query =
        "insert into employee values(null ,$managerSsn , '${user.fName}' , '${user.lName}' , '${user.password}' , ${user.salary} , '${user.employeeRole}');";
    await DatabaseServices.queryDatabase(query);
  }

//delete  employee
  static Future<void> deleteEmployeeFromDatabase(Employee user) async {
    final String deleteQueuery =
        "delete from employee where orderId = ${user.ssn};";
    await DatabaseServices.queryDatabase(deleteQueuery);
  }

//fetch employee by ssn
  static Future<Employee> fetchEmployeeFromDatabase(int ssn) async {
    final query = "select * from employee where ssn = '$ssn';";
    final result = await DatabaseServices.queryDatabase(query);
    return Employee.fromDatabase(result.first);
  }

  //fetch all employees
  static Future<List<Employee>> fetchAllEmlpoyeesFromDatabase() async {
    const query = "select * from employee;";
    final result = await DatabaseServices.queryDatabase(query);
    List<Employee> employeeList = [];
    for (ResultRow emp in result) {
      print(emp);
      // employeeList.add(Employee.fromDatabase(emp));
    }
    return employeeList;
  }
}
