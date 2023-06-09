import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/models/table_in_restaurant.dart';
import 'package:mat3ami/business_logic/view_models/employee_view_model.dart';
import 'package:mat3ami/business_logic/models/menu_item.dart' as m;
import 'package:mat3ami/business_logic/view_models/menu_view_model.dart';
import 'package:mat3ami/business_logic/view_models/order_view_model.dart';
import 'package:mat3ami/business_logic/view_models/table_view_model.dart';
import 'package:mat3ami/screens/log_in/log_in_screent.dart';

import 'package:provider/provider.dart';

import 'screens/Manger_View/manger_home_screen.dart';

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
          create: (context) => MenuViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderViewModel(),
        ),
        ChangeNotifierProvider(create: (context) => EmployeeViewModel())
      ],
      child: MaterialApp(home: LogInScreen()),
    );
  }
}
