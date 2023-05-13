import 'package:mat3ami/business_logic/models/employee.dart';
import 'package:mat3ami/business_logic/services/backend_services.dart';
import 'package:mysql1/mysql1.dart';

class EmployeeServices {
//add new employee

  static Future<void> addNewEmployeeToDatabase(
      Employee user, int managerSsn) async {
    final empQuery =
        "insert into employee values(null ,$managerSsn , '${user.fName}' , '${user.lName}' , '${user.password}' , ${user.salary} , '${user.employeeRole}');";
    await DatabaseServices.queryDatabase(empQuery);
    for (String phone in user.phone) {
      String empPhoneQueuery =
          "insert into employeePhone(ssn , phoneNumber) values(${user.ssn} , $phone);";
      DatabaseServices.queryDatabase(empPhoneQueuery);
    }
  }

//delete  employee
  static Future<void> deleteEmployeeFromDatabase(Employee user) async {
    final String deleteQueuery =
        "delete from employee where orderId = ${user.ssn};";
    await DatabaseServices.queryDatabase(deleteQueuery);
  }

//fetch employee by ssn
  static Future<Employee> fetchEmployeeFromDatabase(int ssn) async {
    final query =
        "SELECT e.* , GROUP_CONCAT(p.phoneNumber) as phone FROM employee as e inner join employeePhone as p on e.ssn = p.ssn WHERE e.ssn = $ssn  GROUP by e.ssn";
    final result = await DatabaseServices.queryDatabase(query);
    return Employee.fromDatabase(result.first);
  }

  //fetch all employees
  static Future<List<Employee>> fetchAllEmlpoyeesFromDatabase() async {
    const query =
        "SELECT e.* , GROUP_CONCAT(p.phoneNumber) as phone FROM employee as e inner join employeePhone as p on e.ssn = p.ssn GROUP by e.ssn";
    final result = await DatabaseServices.queryDatabase(query);
    List<Employee> employeeList = [];
    for (ResultRow emp in result) {
      employeeList.add(Employee.fromDatabase(emp));
    }
    return employeeList;
  }
}
