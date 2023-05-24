import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/models/table_in_restaurant.dart';
import 'package:mat3ami/business_logic/services/order_services.dart';

class OrderViewModel extends ChangeNotifier {
  List<OrdersList> ordersList = [];

  OrderViewModel() {
    updateOrderList();
  }
  Future<void> updateOrderList() async {
    ordersList =
        (await OrderServices.fetchAllOrdersFromDatabase()).cast<OrdersList>();
    notifyListeners();
  }
}
