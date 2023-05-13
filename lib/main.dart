import 'package:mat3ami/business_logic/models/menu_item.dart';
import 'package:mat3ami/business_logic/services/backend_services.dart';

import 'package:mat3ami/business_logic/services/employee_services.dart';
import 'package:mat3ami/business_logic/services/menu_item_services.dart';
import 'package:mat3ami/business_logic/services/order_services.dart';
import 'package:mat3ami/business_logic/services/table_services.dart';

Future<void> main() async {
  await DatabaseServices.initializeDatabase();

  final result1 = await TableServices.fetchAllTablesFromDatabase();
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
  for (final res in result4) print(res);
}
