import 'package:mysql1/mysql1.dart';

class Employee {
  int ssn;
  int managerSsn;
  String fName;
  String lName;
  List<String> phone;
  double salary;
  String employeeRole;
  String password;

  Employee(
      {required this.ssn,
      required this.managerSsn,
      required this.fName,
      required this.lName,
      required this.employeeRole,
      required this.password,
      required this.phone,
      required this.salary});
  Employee.fromDatabase(ResultRow result)
      : ssn = result['ssn'] as int,
        managerSsn = result['managerSsn'] as int,
        fName = result['fName'],
        lName = result['lName'],
        employeeRole = result['employeeRole'],
        password = result['password'],
        phone = result['phone'] != null
            ? result['phone'].toString().split(',')
            : [],
        salary = result['salary'] as double;

  @override
  String toString() {
    // TODO: implement toString
    return '$ssn , $managerSsn , $fName , $lName , $phone , $salary , $employeeRole , $password';
  }
}
