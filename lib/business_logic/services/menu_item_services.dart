import 'package:mat3ami/business_logic/services/backend_services.dart';
import 'package:mysql1/mysql1.dart';

import '../models/menu_item.dart';

class MenuItemServices {
  // add new item to menue
  static Future<void> addNewMenuItemToDatabase(MenuItem item) async {
    final query =
        "insert into menuItem values('${item.name}' , ${item.price} , '${item.category}' , '${item.imageBytes}' , ${item.availability},'${item.description}');";
    await DatabaseServices.queryDatabase(query);
  }

//fetch MenuItem by name
  static Future<MenuItem> fetchMenuItemFromDatabase(String name) async {
    final query = "select * from menuItem where name = '$name';";
    final result = await DatabaseServices.queryDatabase(query);
    return MenuItem.fromDatabase(result.first);
  }

//fetch all MenuItems
  static Future<List<MenuItem>> fetchAllMenuItemsFromDatabase() async {
    const query = "select * from menuItem ;";
    final result = await DatabaseServices.queryDatabase(query);
    List<MenuItem> menuItemList = [];
    for (ResultRow item in result) {
      menuItemList.add(MenuItem.fromDatabase(item));
    }
    return menuItemList;
  }

// Delete menu items
  static Future<void> deleteMenuItemFromDatabase(String name) async {
    final query = "DELETE FROM menuItem where name = '$name';";
    await DatabaseServices.queryDatabase(query);
  }

// Edit Item from menu items
  static Future<void> editMenuItemInDatabase(MenuItem item) async {
    final query =
        "UPDATE menuItem SET name = '${item.name}', price = ${item.price},category = '${item.category}',image = '${item.imageBytes}',availability = ${item.availability},description = '${item.description}' where name= '${item.name}';";
    await DatabaseServices.queryDatabase(query);
  }
}
