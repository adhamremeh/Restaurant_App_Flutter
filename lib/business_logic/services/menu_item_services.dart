import 'package:mat3ami/business_logic/services/backend_services.dart';
import 'package:mysql1/mysql1.dart';

import '../models/employee.dart';
import '../models/menu_item.dart';

class MenuServices {
  // add new item to menue
  Future<void> addNewMenuItemToDatabase(MenuItem name) async {
    final query =
        "insert into menuitem values('${name.name}' , '${name.price}' , '${name.category}' , ${name.image} , '${name.availability}','${name.description}');";
    await DatabaseServices.queryDatabase(query);
  }

//fetch MenuItem by name
  Future<MenuItem> fetchMenuItemFromDatabase(String name) async {
    final query = "select * from menuitem where name = '$name';";
    final result = await DatabaseServices.queryDatabase(query);
    return MenuItem.fromDatabase(result.first);
  }

// Delete menu items
  Future<MenuItem> deleteMenuItemFromDatabase(String name) async {
    final query = "DELETE FROM menuitem where name = '$name';";
    final result = await DatabaseServices.queryDatabase(query);
    return MenuItem.fromDatabase(result.first);
  }

// Edit Item from menu items
}
