import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/models/table_in_restaurant.dart';
import 'package:mat3ami/business_logic/view_models/active_user_view_model.dart';
import 'package:mat3ami/screens/common_components/common_components.dart';
import 'package:mat3ami/screens/common_components/custom_scaffold.dart';
import 'package:mat3ami/style/style.dart';
import 'package:provider/provider.dart';

import '../table/table_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  int _selectedBoxIndex = -1;
  late List<Table> tableList;

  final TextEditingController _UserNameinputTEXT = TextEditingController();
  final TextEditingController _PasswordinputTEXT = TextEditingController();

  void _onBoxPressed(int index) {
    setState(() {
      _selectedBoxIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
  }

  Future<void> LogInButton() async {
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

    if (await ActiveUserViewModel.logInUser(
        _UserNameinputTEXT.text, _PasswordinputTEXT.text)) {
      Navigator.of(context, rootNavigator: true).pop();
      if (ActiveUserViewModel.role == 'Manager') {
        //Navigate to deafult manger screen
      } else if (ActiveUserViewModel.role == 'Chief') {
        //Navigate to orders screen
      } else if (ActiveUserViewModel.role == 'Waiter') {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TablesScreen()),
        );
      }
    } else {
      Navigator.of(context, rootNavigator: true).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Wrong password or ID'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<int> tableList = [1, 2];
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomStyle.colorPalette.darkBackground,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "LOG IN",
                      style: TextStyle(
                          fontSize: CustomStyle.fontSizes.titleFont + 8,
                          color: CustomStyle.colorPalette.textColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              SizedBox(
                height: 350,
                width: MediaQuery.of(context).size.width,
                child: Image.asset('assets/logo/logo-color.png'),
              ),
              customTextField(
                  width: MediaQuery.of(context).size.width * 0.876,
                  keyboardType: TextInputType.number,
                  height: 25,
                  hintText: "User SSN",
                  textEditingController: _UserNameinputTEXT),
              SizedBox(height: 10),
              customTextField(
                  width: MediaQuery.of(context).size.width * 0.876,
                  height: 25,
                  hintText: "Password",
                  textEditingController: _PasswordinputTEXT),
              SizedBox(height: 60.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: customButton(
                    context: context,
                    onPressed: LogInButton,
                    childText: "Log In",
                    width: MediaQuery.of(context).size.width / 2,
                    height: 50),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
