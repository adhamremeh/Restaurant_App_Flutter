import 'package:mat3ami/business_logic/services/backend_services.dart';

import '../models/menu_item.dart';

class MenuServices {
  // add new item to menue
  Future<void> addNewMenuItemToDatabase(MenuItem item, int managerSsn) async {
    final query =
        "insert into menuitem values('${item.name}' , ${item.price} , '${item.category}' , ${item.image} , ${item.availability},'${item.description}',$managerSsn);";
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
  Future<void> editMenuItemInDatabase(MenuItem item, int managerSsn) async {
    final query =
        "UPDATE menuitem SET name = '${item.name}', price = ${item.price},category = '${item.category}',image = ${item.image},availability = ${item.availability},description = '${item.description}' , managerSsn = $managerSsn where name= '${item.name}';";
    await DatabaseServices.queryDatabase(query);
  }
}
