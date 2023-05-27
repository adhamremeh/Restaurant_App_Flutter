import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/models/employee.dart';
import 'package:mat3ami/business_logic/services/employee_services.dart';

class EmployeeViewModel extends ChangeNotifier {
  List<Employee> employeeList = [];

  Future<void> updateEmployee(Employee employee) async {
    await EmployeeServices.editEmployeeInDatabase(employee);
    await updateEmployeeList();
  }

  Future<void> addEmployee(Employee employee) async {
    await EmployeeServices.addNewEmployeeToDatabase(
        employee, employee.managerSsn);
    await updateEmployeeList();
  }

  Future<void> deleteEmployee(Employee employee) async {
    await EmployeeServices.deleteEmployeeFromDatabase(employee);
    await updateEmployeeList();
  }

  Future<void> updateEmployeeList() async {
    employeeList = (await EmployeeServices.fetchAllEmlpoyeesFromDatabase());
    notifyListeners();
  }
}
