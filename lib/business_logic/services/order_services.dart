import 'package:mat3ami/business_logic/models/menu_item.dart';
import 'package:mat3ami/business_logic/models/order.dart';
import 'package:mat3ami/business_logic/services/backend_services.dart';
import 'package:mysql1/mysql1.dart';

class OrderServices {
  //add order
  static Future<void> addOrderToDatabase(int tableNumber,
      Map<MenuItem, int> menuItemsAndAmounts, String comments) async {
    final String customerOrderQueuery =
        "insert into customerOrder values (null,'Placed', '${DateTime.now()}', $tableNumber ,$comments );";

    List<String> orderMenuItemQueueries = [];

    for (final item in menuItemsAndAmounts.entries) {
      orderMenuItemQueueries.add(
          "insert into orderMenuItems values ( '${item.key.name}', (select orderId from customerOrder order by orderId desc limit 1), ${item.value} );");
    }

    await DatabaseServices.queryDatabase(customerOrderQueuery);
    for (String q in orderMenuItemQueueries) {
      await DatabaseServices.queryDatabase(q);
    }
  }

  //modify order status
  static Future<void> modifyOrderStatusInDatabase(
      int orderId, String newStatus) async {
    final String modifyStatusQueuery =
        "update customerOrder set orderStatus = '$newStatus' where orderId = $orderId;";
    await DatabaseServices.queryDatabase(modifyStatusQueuery);
  }

  //modify order items or comment
  static Future<void> modifyOrderItemsInDatabase(int orderId,
      {Map<MenuItem, int>? menuItemsAndAmountsToAddTo,
      Map<MenuItem, int>? newMenuItemsAndAmountsToAdd,
      Map<MenuItem, int>? menuItemsAndAmountsToRemove,
      String? comments}) async {
    if (comments != null) {
      String commentsQueuery =
          "update customerOrder set comments = '$comments' where orderId = $orderId;";
      await DatabaseServices.queryDatabase(commentsQueuery);
    }
    if (menuItemsAndAmountsToAddTo != null) {
      for (final item in menuItemsAndAmountsToAddTo.entries) {
        String itemAddingQueuery =
            "update orderMenuItems set ammount = '${item.value}' where orderId = $orderId and name = ${item.key.name};";
        await DatabaseServices.queryDatabase(itemAddingQueuery);
      }
    }
    if (menuItemsAndAmountsToRemove != null) {
      for (final item in menuItemsAndAmountsToRemove.entries) {
        String itemRemovingQueuery = (item.value > 0)
            ? "update orderMenuItems set ammount = '${item.value}' where orderId = $orderId and name = ${item.key.name};"
            : "delete from orderMenuItems where orderId = $orderId and name = ${item.key.name};";

        await DatabaseServices.queryDatabase(itemRemovingQueuery);
      }
    }
    if (newMenuItemsAndAmountsToAdd != null) {
      for (final item in newMenuItemsAndAmountsToAdd.entries) {
        String itemAddingQueuery =
            "insert into orderMenuItems values ( '${item.key.name}', (select orderId from customerOrder order by orderId desc limit 1), ${item.value} );";

        await DatabaseServices.queryDatabase(itemAddingQueuery);
      }
    }
  }

  //delete order
  static Future<void> deleteOrderInDatabase(int orderId) async {
    final String deleteQueuery =
        "delete from orderMenuItems where orderId = $orderId;";
    await DatabaseServices.queryDatabase(deleteQueuery);
  }

  //fetch order from database
  Future<Order> fetchOrderFromDatabase(int orderId) async {
    String query =
        "select c.orderId , c.orderStatus, c.dateAndTime, c.tableNumber ,o.name , o.ammount,c.comments from customerOrder as c join orderMenuItems as o on c.orderId = o.orderId where c.orderId = $orderId and orderStatus != 'CheckedOut' ;";
    final result = await DatabaseServices.queryDatabase(query);
    return Order.fromDatabase(result);
  }

  //fetch all orders
  static Future<List<Order>> fetchAllOrdersFromDatabase() async {
    const query =
        "select c.orderId , c.orderStatus, c.dateAndTime, c.tableNumber ,o.name , o.ammount,c.comments from customerOrder as c join orderMenuItems as o on c.orderId = o.orderId where c.orderStatus != 'completed' order by orderId asc  ;";
    final result = await DatabaseServices.queryDatabase(query);
    if (result.isEmpty) return [];
    List<Order> orderList = [];
    int currentOrderId = result.first['orderId'] as int;
    String currentComments = result.first['comments'];
    DateTime curreentDateTime = result.first['dateTime'];
    String currentOrderStatus = result.first['orderStatus'];
    Map<String, int> currentMenuItemsNamesAndCounts = {};
    for (ResultRow row in result) {
      if (row['orderId'] as int == currentOrderId && row != result.last) {
        currentMenuItemsNamesAndCounts[row['name']] = row['ammount'];
      } else {
        orderList.add(Order(
            comments: currentComments,
            dateTime: curreentDateTime,
            menuItemsNamesAndCounts: currentMenuItemsNamesAndCounts,
            orderId: currentOrderId,
            orderStatus: currentOrderStatus));
        currentOrderId = row['orderId'] as int;
        currentComments = row['comments'];
        curreentDateTime = row['dateTime'];
        currentOrderStatus = row['orderStatus'];
        currentMenuItemsNamesAndCounts = {};
        currentMenuItemsNamesAndCounts[row['name']] = row['ammount'];
      }
    }
    return orderList;
  }
}
