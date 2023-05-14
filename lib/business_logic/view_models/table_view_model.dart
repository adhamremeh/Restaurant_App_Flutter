import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/models/table_in_restaurant.dart';
import 'package:mat3ami/business_logic/services/table_services.dart';

class TableViewModel extends ChangeNotifier {
  List<TableInRestaurant> tableList = [];

  TableViewModel() {
    updateTableList();
  }
  Future<void> updateTableList() async {
    tableList = await TableServices.fetchAllTablesFromDatabase();
    notifyListeners();
  }
}
