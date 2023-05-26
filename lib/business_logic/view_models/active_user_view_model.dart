import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/services/backend_services.dart';
import 'package:mysql1/mysql1.dart';

class ActiveUserViewModel extends ChangeNotifier {
  //attributes
  static int id = -1;
  static String name = '';
  static String role = '';

  static Future<bool> logInUser(String userId, String password) async {
    String query =
        "select * from employee where ssn = '$userId' and password = '$password';";

    final result = await DatabaseServices.queryDatabase(query);

    if (result.isNotEmpty) {
      ActiveUserViewModel().setActiveUser(result.first);
      return true;
    } else {
      return false;
    }
  }
  //setting current Active User of the application

  void setActiveUser(ResultRow result) {
    id = result['ssn'];
    name = result['fName'] + ' ' + result['lName'];
    role = result['employeeRole']; //'employee' or 'manager'
    notifyListeners();
  }
}
