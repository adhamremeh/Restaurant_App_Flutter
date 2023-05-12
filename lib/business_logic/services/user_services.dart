import 'package:mat3ami/business_logic/models/user.dart';
import 'package:mat3ami/business_logic/services/backend_services.dart';
import 'package:mysql1/mysql1.dart';

class UserServices {
//add new employee
  Future<void> addNewEmployeeToDatabase(User user, int managerSsn) async {
    final query =
        "insert into employee values(null ,$managerSsn , '${user.fName}' , '${user.lName}' , '${user.password}' , ${user.salary} , '${user.employeeRole}');";
    await DatabaseServices.queryDatabase(query);
  }

//fetch employee by ssn
  Future<User> fetchEmployeeFromDatabase(int ssn) async {
    final query = "select * from employee where ssn = '$ssn';";
    final result = await DatabaseServices.queryDatabase(query);
    return User.fromDatabase(result.first);
  }

  //fetch all employees
  Future<List<User>> fetchAllEmlpoyeesFromDatabase() async {
    const query = "select * from employee ;";
    final result = await DatabaseServices.queryDatabase(query);
    List<User> employeeList = [];
    for (ResultRow emp in result) {
      employeeList.add(User.fromDatabase(emp));
    }
    return employeeList;
  }
}
