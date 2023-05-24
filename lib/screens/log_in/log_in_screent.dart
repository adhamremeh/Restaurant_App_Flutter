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
  late List<OrdersList> tableList;

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
    if (await ActiveUserViewModel.logInUser(
        _UserNameinputTEXT.text, _PasswordinputTEXT.text)) {
      if (ActiveUserViewModel.role == 'Manager') {
      } else if (ActiveUserViewModel.role == 'Chief') {
      } else if (ActiveUserViewModel.role == 'Waiter') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TablesScreen()),
        );
      }
    } else {
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
    return Scaffold(
      backgroundColor: CustomStyle.colorPalette.darkBackground,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 5),
            SizedBox(
              height: 250,
              width: 250,
              child: Image.asset('assets/logo/logo-color.png'),
            ),
            customTextField(
                width: MediaQuery.of(context).size.width / 1.6,
                height: 45,
                hintText: "User SSN",
                textEditingController: _UserNameinputTEXT),
            SizedBox(height: 10),
            customTextField(
                width: MediaQuery.of(context).size.width / 1.6,
                height: 45,
                hintText: "Password",
                textEditingController: _PasswordinputTEXT),
            SizedBox(height: 20),
            customButton(
                context: context,
                onPressed: LogInButton,
                childText: "Log In",
                width: MediaQuery.of(context).size.width / 2,
                height: 45)
          ],
        ),
      ),
    );
  }
}

// customTextField(
// width: MediaQuery.of(context).size.width * 0.4,
// height: MediaQuery.of(context).size.height * 0.35,
// hintText: "LOL",
// textEditingController: _inputTEXT
// ),
