import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/services/backend_services.dart';

import 'package:mat3ami/business_logic/services/employee_services.dart';
import 'package:mat3ami/business_logic/services/menu_item_services.dart';
import 'package:mat3ami/business_logic/services/order_services.dart';
import 'package:mat3ami/business_logic/services/table_services.dart';
import 'package:mat3ami/business_logic/view_models/table_view_model.dart';
import 'package:mat3ami/my_app.dart';
import 'package:mat3ami/screens/common_components/combo_box.dart';
import 'package:mat3ami/screens/playGround.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await DatabaseServices.initializeDatabase();

  runApp(const MyApp());

/*   final result1 = await TableServices.fetchAllTablesFromDatabase();
  print('tables\n');
  for (final res in result1) print(res);
  final result2 = await EmployeeServices.fetchAllEmlpoyeesFromDatabase();
  print('employees\n');
  for (final res in result2) print(res);
  final result3 = await OrderServices.fetchAllOrdersFromDatabase();
  print('Orders\n');
  for (final res in result3) print(res);

  final result4 = await MenuItemServices.fetchAllMenuItemsFromDatabase();
  print('MenuItems\n');
  for (final res in result4) print(res); */
}
