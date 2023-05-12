import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class ActiveUser extends ChangeNotifier {
  //attributes
  static String id = '';
  static String name = '';
  static String role = '';

  //setting current Active User of the application

  void setActiveUser(ResultRow result) {
    id = result['ssn'].toString();
    name = result['fName'] + ' ' + result['lName'];
    role = result['employeeRole']; //'employee' or 'manager'
    notifyListeners();
  }
}
