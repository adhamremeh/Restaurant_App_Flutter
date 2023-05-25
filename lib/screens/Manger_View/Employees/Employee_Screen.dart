import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/models/employee.dart';
import 'package:mat3ami/business_logic/view_models/active_user_view_model.dart';
import 'package:mat3ami/business_logic/view_models/employee_view_model.dart';
import 'package:mat3ami/business_logic/view_models/order_view_model.dart';
import 'package:mat3ami/style/style.dart';
import 'package:provider/provider.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  late List<Employee> employeesList;
  @override
  void initState() {
    super.initState();
    var timer = Timer.periodic(
        Duration(seconds: 10),
        (Timer t) => Provider.of<OrderViewModel>(context, listen: false)
            .updateOrderList());
  }

  @override
  Widget build(BuildContext context) {
    employeesList = Provider.of<EmployeeViewModel>(context, listen: true)
        .employeeList
        .cast<Employee>();
    return Container(
      child: Column(
        children: [
          ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return Container();
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: CustomStyle.colorPalette.textColor,
                  thickness: 2.0,
                );
              },
              itemCount: 3)
        ],
      ),
    );
  }
}
