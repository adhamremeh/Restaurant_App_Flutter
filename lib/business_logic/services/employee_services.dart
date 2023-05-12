import 'package:mat3ami/business_logic/models/employee.dart';
import 'package:mat3ami/business_logic/services/backend_services.dart';
import 'package:mysql1/mysql1.dart';

class UserServices {
//add new employee
  Future<void> addNewEmployeeToDatabase(Employee user, int managerSsn) async {
    final query =
        "insert into employee values(null ,$managerSsn , '${user.fName}' , '${user.lName}' , '${user.password}' , ${user.salary} , '${user.employeeRole}');";
    await DatabaseServices.queryDatabase(query);
  }

//fetch employee by ssn
  Future<Employee> fetchEmployeeFromDatabase(int ssn) async {
    final query = "select * from employee where ssn = '$ssn';";
    final result = await DatabaseServices.queryDatabase(query);
    return Employee.fromDatabase(result.first);
  }

  //fetch all employees
  Future<List<Employee>> fetchAllEmlpoyeesFromDatabase() async {
    const query = "select * from employee ;";
    final result = await DatabaseServices.queryDatabase(query);
    List<Employee> employeeList = [];
    for (ResultRow emp in result) {
      employeeList.add(Employee.fromDatabase(emp));
    }
    return employeeList;
  }
}
