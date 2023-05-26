import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/models/menu_item.dart' as m;
import 'package:mat3ami/business_logic/services/menu_item_services.dart';

class MenuViewModel extends ChangeNotifier {
  List<m.MenuItem> MenuItemList = [];
  MenuViewModel() {
    updateMenuList();
  }
  Future<void> updateMenuList() async {
    MenuItemList = (await MenuItemServices.fetchAllMenuItemsFromDatabase())
        .cast<m.MenuItem>();
    notifyListeners();
  }

  Future<void> addNewMenuItem(m.MenuItem item) async {
    await MenuItemServices.addNewMenuItemToDatabase(item);
    await updateMenuList();
  }
}
