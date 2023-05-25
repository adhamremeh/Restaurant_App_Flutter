import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/models/employee.dart';
import 'package:mat3ami/business_logic/services/employee_services.dart';

class EmployeeViewModel extends ChangeNotifier {
  List<Employee> employeeList = [];

  EmployeeViewModel() {
    updateOrderList();
  }
  Future<void> updateOrderList() async {
    employeeList = (await EmployeeServices.fetchAllEmlpoyeesFromDatabase())
        .cast<Employee>();
    notifyListeners();
  }
}
