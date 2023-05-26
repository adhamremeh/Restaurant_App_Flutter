import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/models/employee.dart';
import 'package:mat3ami/business_logic/view_models/active_user_view_model.dart';
import 'package:mat3ami/business_logic/view_models/employee_view_model.dart';
import 'package:mat3ami/business_logic/view_models/order_view_model.dart';
import 'package:mat3ami/screens/Manger_View/Employees/edit_employee_screen.dart';
import 'package:mat3ami/screens/Manger_View/Employees/hire_employee_screen.dart';

import 'package:mat3ami/screens/common_components/common_components.dart';
import 'package:mat3ami/screens/common_components/custom_scaffold.dart';
import 'package:mat3ami/screens/orders_screen/orders_screen.dart';
import 'package:mat3ami/style/style.dart';
import 'package:provider/provider.dart';
///////////////////You must enter all employee data to make it show here (Phone Numbers)

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  late List<Employee> employeesList;
  var timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        Duration(seconds: 10),
        (Timer t) => Provider.of<EmployeeViewModel>(context, listen: false)
            .updateEmployeeList());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    employeesList = Provider.of<EmployeeViewModel>(context, listen: true)
        .employeeList
        .cast<Employee>();
    return Scaffold(
      backgroundColor: CustomStyle.colorPalette.lightBackgorund,
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: ListView.separated(
                      itemCount: employeesList.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                        thickness: 2,
                        color: CustomStyle.colorPalette.textColor,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            leading: Text(
                              "#${employeesList[index].ssn}",
                              style: TextStyle(
                                  fontSize:
                                      CustomStyle.fontSizes.employeeNameFont,
                                  color: CustomStyle.colorPalette.textColor,
                                  fontFamily: CustomStyle.fontFamily,
                                  fontWeight: FontWeight.bold),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "${employeesList[index].fName} ${employeesList[index].lName}",
                                  style: TextStyle(
                                      fontSize: CustomStyle
                                          .fontSizes.employeeNameFont,
                                      color: CustomStyle.colorPalette.textColor,
                                      fontFamily: CustomStyle.fontFamily,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            trailing: customButton(
                                context: context,
                                onPressed: () {
                                  //Navigate to edit
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditEmployeeScreen(
                                              employee: employeesList[index],
                                            )),
                                  );
                                },
                                childText: "Edit",
                                width:
                                    MediaQuery.of(context).size.width * 0.182,
                                height: MediaQuery.of(context).size.height *
                                    0.035));
                      },
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: CustomStyle.colorPalette.textColor,
                    thickness: 2.0,
                  );
                },
                itemCount: employeesList.length),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                customButton(
                    height: MediaQuery.of(context).size.height * 0.0812,
                    width: MediaQuery.of(context).size.width * 0.7044,
                    context: context,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HireEmployeeScreen()),
                      );
                    },
                    childText: "Hire Employee"),
                SizedBox(
                  height: 15.0,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
