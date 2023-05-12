import 'package:mysql1/mysql1.dart';

class User {
  String ssn;
  String managerSsn;
  String fName;
  String lName;
  String phoneNumber1;
  String phoneNumber2;
  double salary;
  String employeeRole;
  String password;

  User(
      {required this.ssn,
      required this.managerSsn,
      required this.fName,
      required this.lName,
      required this.employeeRole,
      required this.password,
      required this.phoneNumber1,
      required this.phoneNumber2,
      required this.salary});
  /* User.fromDatabase(ResultRow result){

  } */
}
