import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/models/order.dart';
import 'package:mat3ami/business_logic/services/order_services.dart';
import 'package:mat3ami/business_logic/services/table_services.dart';

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

  Future<void> checkOutOrder(int tableNum) async {
    final ordersListForTable =
        (await OrderServices.fetchOrderForTableFromDatabase(tableNum)
            as List<Order>);
    Map<String, int> allItemsAndCounts = {};
    String comments = '';
    List<int> ids = [];
    for (final order in ordersListForTable) {
      if (order.comments.isNotEmpty) comments += order.comments;
      ids.add(order.orderId);
      for (final item in order.menuItemsNamesAndCounts.keys) {
        if (allItemsAndCounts.containsKey(item)) {
          allItemsAndCounts[item] =
              allItemsAndCounts[item]! + order.menuItemsNamesAndCounts[item]!;
        } else {
          allItemsAndCounts[item] = order.menuItemsNamesAndCounts[item]!;
        }
      }
    }
    ordersListForTable.sort(((a, b) => a.dateTime.compareTo(b.dateTime)));
    await OrderServices.addOrderToDatabase(
        tableNum, allItemsAndCounts, comments,
        state: 'Completed', dateTime: ordersListForTable[0].dateTime);
    await OrderServices.deleteOrdersInDatabase(ids);
    await TableServices.changeTableState(tableNum, false);
    updateOrderList();
  }
}
