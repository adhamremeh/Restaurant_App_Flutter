import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/view_models/employee_view_model.dart';
import 'package:mat3ami/business_logic/view_models/order_view_model.dart';
import 'package:mat3ami/business_logic/view_models/table_view_model.dart';
import 'package:mat3ami/screens/Manger_View/DeafultViewScreen.dart';
import 'package:mat3ami/screens/Manger_View/Employees/Employee_Screen.dart';
import 'package:mat3ami/screens/Manger_View/MenuItem/add_menu_item_screen.dart';
import 'package:mat3ami/screens/common_components/custom_order_details.dart';
import 'package:mat3ami/screens/orders_screen/orders_screen.dart';
import 'package:mat3ami/screens/playGround.dart';
import 'package:mat3ami/screens/log_in/log_in_screent.dart';
import 'package:mat3ami/screens/table/table_screen.dart';
import 'package:mat3ami/screens/table_keeping_available/table_keeping_occupied.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TableViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderViewModel(),
        ),
        ChangeNotifierProvider(create: (context) => EmployeeViewModel())
      ],
      child: MaterialApp(
        home: AddMenuItemScreen(),
      ),
    );
  }
}
