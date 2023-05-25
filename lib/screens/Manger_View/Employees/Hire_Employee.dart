import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/models/employee.dart';
import 'package:mat3ami/business_logic/models/table_in_restaurant.dart';
import 'package:mat3ami/business_logic/services/employee_services.dart';
import 'package:mat3ami/business_logic/view_models/active_user_view_model.dart';
import 'package:mat3ami/screens/common_components/combo_box.dart';
import 'package:mat3ami/screens/common_components/common_components.dart';
import 'package:mat3ami/screens/common_components/custom_scaffold.dart';
import 'package:mat3ami/style/style.dart';
import 'package:provider/provider.dart';

class HireEmployeeScreen extends StatefulWidget {
  const HireEmployeeScreen({Key? key}) : super(key: key);

  @override
  _HireEmployeeState createState() => _HireEmployeeState();
}

class _HireEmployeeState extends State<HireEmployeeScreen> {
  final TextEditingController _FirstNameinputTEXT = TextEditingController();
  final TextEditingController _LastNameinputTEXT = TextEditingController();
  final TextEditingController _PasswordinputTEXT = TextEditingController();
  final TextEditingController _FirstPhoneinputTEXT = TextEditingController();
  final TextEditingController _SecondPhoneinputTEXT = TextEditingController();
  final TextEditingController _SalaryinputTEXT = TextEditingController();
  String dropdownValue = '';

  final double customPadding = 30;
  final double customHeight = 70;

  @override
  void initState() {
    // TODO: implement initState
  }

  Future<void> HireButton() async {
    String managerSSN = ActiveUserViewModel.id;
    Employee newUser = Employee(
        ssn: -1,
        managerSsn: int.parse(managerSSN),
        fName: _FirstNameinputTEXT.text,
        lName: _LastNameinputTEXT.text,
        employeeRole: dropdownValue,
        password: _PasswordinputTEXT.text,
        phone: [_FirstPhoneinputTEXT.text, _SecondPhoneinputTEXT.text],
        salary: double.parse(_SalaryinputTEXT.text));
    EmployeeServices.addNewEmployeeToDatabase(newUser, int.parse(managerSSN));
  }

  @override
  Widget build(BuildContext context) {
    return customScaffold(
      title: "Hire Employee",
      context: context,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customTextField(
                    width: MediaQuery.of(context).size.width / 2.48,
                    height: customHeight,
                    hintText: "First Name",
                    textEditingController: _FirstNameinputTEXT),
                SizedBox(height: customPadding, width: 20),
                customTextField(
                    width: MediaQuery.of(context).size.width / 2.48,
                    height: customHeight,
                    hintText: "Last Name",
                    textEditingController: _LastNameinputTEXT),
              ],
            ),
            SizedBox(height: customPadding),
            customTextField(
                width: MediaQuery.of(context).size.width / 1.15,
                height: customHeight,
                hintText: "Password",
                textEditingController: _PasswordinputTEXT),
            SizedBox(height: customPadding),
            customTextField(
                width: MediaQuery.of(context).size.width / 1.15,
                height: customHeight,
                hintText: "First Phone Number",
                textEditingController: _FirstPhoneinputTEXT),
            SizedBox(height: customPadding),
            customTextField(
                width: MediaQuery.of(context).size.width / 1.15,
                height: customHeight,
                hintText: "Second Phone Number",
                textEditingController: _SecondPhoneinputTEXT),
            SizedBox(height: customPadding),
            customTextField(
                width: MediaQuery.of(context).size.width / 1.15,
                height: customHeight,
                hintText: "Salary",
                textEditingController: _SalaryinputTEXT),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Choose employee role:",
                  style: TextStyle(
                      fontSize: CustomStyle.fontSizes.textFieldFont,
                      color: CustomStyle.colorPalette.textColor),
                ),
                SizedBox(width: 40),
                Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: CustomStyle.colorPalette.orangeShadow
                                .withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3))
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: CustomStyle.colorPalette.orange),
                  child: DropdownButton<String>(
                    dropdownColor: CustomStyle.colorPalette.orange,
                    value: dropdownValue.isNotEmpty ? dropdownValue : null,
                    items: <String>['Cheif', 'Waiter']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              value,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: CustomStyle.colorPalette.textColor),
                            ),
                          ));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            customButton(
                context: context,
                onPressed: HireButton,
                childText: "Save",
                width: MediaQuery.of(context).size.width / 2,
                height: 45)
          ],
        ),
      ),
    );
  }
}