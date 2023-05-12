import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/services/backend_services.dart';
import 'package:mysql1/mysql1.dart';

class ActiveUser extends ChangeNotifier {
  //attributes
  static String id = '';
  static String name = '';
  static String role = '';

  Future<bool> logInUser(String userId, String password) async {
    String query =
        "select * from employee where ssn = '$userId' and password = '$password';";

    final result = await DatabaseServices.queryDatabase(query);

    if (result.isNotEmpty) {
      ActiveUser().setActiveUser(result.first);
      return true;
    } else {
      return false;
    }
  }
  //setting current Active User of the application

  void setActiveUser(ResultRow result) {
    id = result['ssn'].toString();
    name = result['fName'] + ' ' + result['lName'];
    role = result['employeeRole']; //'employee' or 'manager'
    notifyListeners();
  }
}
