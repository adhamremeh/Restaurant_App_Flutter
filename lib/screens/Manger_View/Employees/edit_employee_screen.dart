import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/models/employee.dart';

import 'package:mat3ami/business_logic/view_models/employee_view_model.dart';
import 'package:mat3ami/screens/common_components/common_components.dart';
import 'package:mat3ami/screens/common_components/custom_scaffold.dart';
import 'package:mat3ami/style/style.dart';
import 'package:provider/provider.dart';

class EditEmployeeScreen extends StatefulWidget {
  const EditEmployeeScreen({Key? key, required this.employee})
      : super(key: key);
  final Employee employee;
  @override
  _EditEmployeeState createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployeeScreen> {
  final TextEditingController _FirstNameinputTEXT = TextEditingController();
  final TextEditingController _LastNameinputTEXT = TextEditingController();
  final TextEditingController _PasswordinputTEXT = TextEditingController();
  final TextEditingController _FirstPhoneinputTEXT = TextEditingController();
  final TextEditingController _SecondPhoneinputTEXT = TextEditingController();
  final TextEditingController _SalaryinputTEXT = TextEditingController();
  String dropdownValue = '';
  List<String> employeeRoles = ['Waiter', 'Kitchen', 'Manager'];

  @override
  void initState() {
    // TODO: implement initState
    _FirstNameinputTEXT.text = widget.employee.fName;
    _LastNameinputTEXT.text = widget.employee.lName;
    _PasswordinputTEXT.text = widget.employee.password;
    _SalaryinputTEXT.text = widget.employee.salary.toStringAsFixed(2);
    _FirstPhoneinputTEXT.text =
        (widget.employee.phone.length >= 1) ? widget.employee.phone[0] : '';
    _SecondPhoneinputTEXT.text =
        (widget.employee.phone.length >= 2) ? widget.employee.phone[1] : '';
    dropdownValue = widget.employee.employeeRole;
  }

  Future<void> EditButton() async {
    if (validateTextFields()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Container(
            color: CustomStyle.colorPalette.lightBackgorund,
            child: Center(
              child: CircularProgressIndicator(
                color: CustomStyle.colorPalette.orange,
              ),
            ),
          );
        },
      );
      List<String> phoneNumbers = [];
      if (_FirstPhoneinputTEXT.text != null &&
          _FirstPhoneinputTEXT.text.length >= 11) {
        phoneNumbers.add(_FirstPhoneinputTEXT.text);
      }
      if (_SecondPhoneinputTEXT.text != null &&
          _SecondPhoneinputTEXT.text.length >= 11) {
        phoneNumbers.add(_SecondPhoneinputTEXT.text);
      }
      widget.employee.employeeRole = dropdownValue;
      widget.employee.fName = _FirstNameinputTEXT.text;
      widget.employee.lName = _LastNameinputTEXT.text;
      widget.employee.password = _PasswordinputTEXT.text;
      widget.employee.salary = double.parse(_SalaryinputTEXT.text);
      widget.employee.phone = phoneNumbers;
      widget.employee.employeeRole = dropdownValue;

      await Provider.of<EmployeeViewModel>(context, listen: false)
          .updateEmployee(widget.employee);
    }
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Employee Edited succsefuly')));
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future<void> FireButton() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Container(
          color: CustomStyle.colorPalette.lightBackgorund,
          child: Center(
            child: CircularProgressIndicator(
              color: CustomStyle.colorPalette.orange,
            ),
          ),
        );
      },
    );
    await Provider.of<EmployeeViewModel>(context, listen: false)
        .deleteEmployee(widget.employee as Employee);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Employee deleted succsefuly')));
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    return customScaffold(
      title: "Edit Employee",
      context: context,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customTextField(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.036,
                    hintText: "First Name",
                    textEditingController: _FirstNameinputTEXT),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.07,
                ),
                customTextField(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.036,
                    hintText: "Last Name",
                    textEditingController: _LastNameinputTEXT),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            customTextField(
                width: MediaQuery.of(context).size.width * 0.87,
                height: MediaQuery.of(context).size.height * 0.036,
                hintText: "Password",
                textEditingController: _PasswordinputTEXT),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            customTextField(
                width: MediaQuery.of(context).size.width / 1.15,
                height: MediaQuery.of(context).size.height * 0.036,
                hintText: "First Phone Number",
                textEditingController: _FirstPhoneinputTEXT),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            customTextField(
                width: MediaQuery.of(context).size.width / 1.15,
                height: MediaQuery.of(context).size.height * 0.036,
                hintText: "Second Phone Number",
                textEditingController: _SecondPhoneinputTEXT),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            customTextField(
                width: MediaQuery.of(context).size.width / 1.15,
                height: MediaQuery.of(context).size.height * 0.036,
                hintText: "Salary",
                textEditingController: _SalaryinputTEXT),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.87,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Select Role:",
                    style: TextStyle(
                        fontFamily: CustomStyle.fontFamily,
                        fontSize: CustomStyle.fontSizes.textFieldFont,
                        color: CustomStyle.colorPalette.textColor),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 45,
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
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: CustomStyle.colorPalette.orange
                                  .withOpacity(0.5), // Specify the shadow color
                              spreadRadius:
                                  1, // Control the spread of the shadow
                              blurRadius: 3, // Control the blur of the shadow
                              offset: const Offset(
                                  0, 3), // Specify the offset of the shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(30.0),
                          color: CustomStyle.colorPalette.orange),
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(30.0),
                        isExpanded: true,
                        underline: SizedBox(),
                        alignment: Alignment.center,
                        dropdownColor: CustomStyle.colorPalette.orange,
                        hint: Text(
                          dropdownValue,
                          style: TextStyle(
                              fontFamily: CustomStyle.fontFamily,
                              fontSize: CustomStyle.fontSizes.dropDownMenu,
                              color: CustomStyle.colorPalette.textColor),
                        ),
                        value: dropdownValue.isNotEmpty ? dropdownValue : null,
                        items: employeeRoles
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      fontFamily: CustomStyle.fontFamily,
                                      fontSize:
                                          CustomStyle.fontSizes.dropDownMenu,
                                      color:
                                          CustomStyle.colorPalette.textColor),
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
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            customButton(
              context: context,
              onPressed: EditButton,
              childText: "Edit",
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            customButton(
              color: CustomStyle.colorPalette.red,
              context: context,
              onPressed: FireButton,
              childText: "Fire",
            )
          ],
        ),
      ),
    );
  }

  bool validateTextFields() {
    bool allValid = true;
    if (_FirstNameinputTEXT.text == '') {
      _FirstNameinputTEXT.text = 'Please Enter a First name';
      allValid = false;
    }
    if (_LastNameinputTEXT.text == '') {
      _LastNameinputTEXT.text = 'Please Enter a last Name';
      allValid = false;
    }
    if (_FirstPhoneinputTEXT.text.length < 11 &&
        _SecondPhoneinputTEXT.text.length < 11) {
      _FirstPhoneinputTEXT.text = 'Please Enter at least 1 valid phoneNumber';
      _SecondPhoneinputTEXT.text = '';
      allValid = false;
    }

    if (_PasswordinputTEXT.text == '' || _PasswordinputTEXT.text.length < 12) {
      _PasswordinputTEXT.text = 'Please Enter a Valid Password';
      allValid = false;
    }
    if (double.tryParse(_SalaryinputTEXT.text) == null) {
      _SalaryinputTEXT.text = 'Please Enter a valid Salary';
      allValid = false;
    }
    if (dropdownValue == '') {
      final temp = 'Please Select a valid Role';
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(temp)));
      allValid = false;
    }

    return allValid;
  }
}
