import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/models/order.dart';
import 'package:mat3ami/business_logic/services/order_services.dart';

class OrderViewModel extends ChangeNotifier {
  List<Order> ordersList = [];

  OrderViewModel() {
    updateOrderList();
  }
  Future<void> updateOrderList() async {
    ordersList =
        (await OrderServices.fetchAllOrdersFromDatabase()).cast<Order>();
    ordersList.sort(((a, b) => a.compareTo(b)));
    notifyListeners();
  }

  Future<void> updateOrderStatus(int orderId, String newStatus) async {
    await OrderServices.modifyOrderStatusInDatabase(orderId, newStatus);
    await updateOrderList();
  }

  Future<List<Order>> tableOrder(int tableNum) async {
    final ordersListForTable =
        (await OrderServices.fetchOrderForTableFromDatabase(tableNum)
            as List<Order>);
    return ordersListForTable;
  }

  Future<List<Order>> mangerViewSearchOrder(int orderId) async {
    final ordersListForTable =
        (await OrderServices.SearchOrderForTableMangerViewFromDatabase(orderId)
            as List<Order>);
    return ordersListForTable;
  }

  Future<List<Order>> mangerViewOrder() async {
    final ordersListForTable =
        (await OrderServices.fetchOrderForTableMangerViewFromDatabase()
            as List<Order>);
    return ordersListForTable;
  }
}
