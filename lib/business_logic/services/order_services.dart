import 'package:mat3ami/business_logic/models/menu_item.dart';
import 'package:mat3ami/business_logic/models/order.dart';
import 'package:mat3ami/business_logic/services/backend_services.dart';
import 'package:mat3ami/business_logic/services/table_services.dart';
import 'package:mysql1/mysql1.dart';

class OrderServices {
  //add order
  static Future<void> addOrderToDatabase(
      int tableNumber, Map<String, int> menuItemsAndAmounts, String comments,
      {String? state, DateTime? dateTime}) async {
    final String customerOrderQueuery =
        "insert into customerOrder values (null,'${state ?? 'Placed'}', '${dateTime ?? DateTime.now()}', $tableNumber ,'$comments' );";

    List<String> orderMenuItemQueueries = [];

    for (final item in menuItemsAndAmounts.entries) {
      orderMenuItemQueueries.add(
          "insert into orderMenuItems values ( '${item.key}', (select orderId from customerOrder order by orderId desc limit 1), ${item.value} );");
    }
    await TableServices.changeTableState(tableNumber, true);

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
  static Future<void> deleteOrdersInDatabase(List<int> orderIds) async {
    String ids = '( ';
    for (int id in orderIds) {
      ids += "$id ,";
    }

    ids += ')';
    ids = ids.replaceAll(',)', ')');
    final String deleteQueuery =
        "delete from customerOrder where orderId in $ids;";
    await DatabaseServices.queryDatabase(deleteQueuery);
  }

  //fetch order from database
  Future<Order> fetchOrderFromDatabase(int orderId) async {
    String query =
        "select c.orderId , c.orderStatus, c.dateAndTime, c.tableNumber , c.comments ,GROUP_CONCAT(o.name , ':', o.ammount) as menuItemsNamesAndCounts from customerOrder as c join orderMenuItems as o on c.orderId = o.orderId where c.orderId = $orderId  GROUP by c.orderId;";
    final result = await DatabaseServices.queryDatabase(query);
    return Order.fromDatabase(result.first);
  }

  //fetch all orders
  static Future<List<Order>> fetchAllOrdersFromDatabase(
      {String status = '', bool activeOnly = true}) async {
    if (activeOnly) {
      if (status != '') {
        status =
            "where c.orderStatus = $status and c.orderStatus != '${OrderStates.Completed}'";
      } else {
        status = "where c.orderStatus != '${OrderStates.Completed}'";
      }
    } else if (status != '') {
      status = 'where c.orderStatus = $status';
    }
    final query =
        "select c.orderId , c.orderStatus, c.dateAndTime, c.tableNumber , c.comments ,GROUP_CONCAT(o.name , ':', o.ammount) as menuItemsNamesAndCounts from customerOrder as c join orderMenuItems as o on c.orderId = o.orderId $status  GROUP by c.orderId;";
    final result = await DatabaseServices.queryDatabase(query);
    if (result.isEmpty) return [];
    List<Order> orderList = [];
    for (final row in result) {
      orderList.add(Order.fromDatabase(row));
    }

    return orderList;
  }

  static Future<List<Order>> fetchOrderForTableFromDatabase(
      int tableNum) async {
    String query =
        "select c.orderId , c.orderStatus, c.dateAndTime, c.tableNumber , c.comments ,GROUP_CONCAT(o.name , ':', o.ammount) as menuItemsNamesAndCounts from customerOrder as c join orderMenuItems as o on c.orderId = o.orderId WHERE orderStatus NOT IN ('Completed', 'Cancelled') AND tableNumber = ${tableNum} GROUP by c.orderId;";

    // "SELECT * FROM orders WHERE orderStatus NOT IN ('Completed', 'Cancelled') AND tableNumber = ${tableNum};";
    final results = await DatabaseServices.queryDatabase(query);
    List<Order> orderList = [];
    for (ResultRow row in results) {
      orderList.add(Order.fromDatabase(row));
    }
    return orderList;
  }

  static Future<double> fetchOrderTotalForTableFromDatabase(
      Map<String, int> allItemsAndCounts) async {
    double total = 0.0;
    String query = '';
    Results result;
    for (final itemName in allItemsAndCounts.keys) {
      query = "Select price from menuItem where name = '$itemName' ;";
      result = await DatabaseServices.queryDatabase(query);
      for (final row in result) {
        total += (row['price'] as double) * allItemsAndCounts[itemName]!;
      }
    }

    return total;
  }

  static Future<List<Order>> fetchOrderForTableMangerViewFromDatabase() async {
    String query =
        "SELECT c.orderId, c.orderStatus, c.dateAndTime, c.tableNumber, c.comments, GROUP_CONCAT(o.name, ':', o.ammount) AS menuItemsNamesAndCounts FROM customerOrder AS c JOIN orderMenuItems AS o ON c.orderId = o.orderId WHERE c.orderStatus NOT IN ('Placed', 'Ready', 'Preparing', 'Served') GROUP BY c.orderId";

    // "SELECT * FROM orders WHERE orderStatus NOT IN ('Completed', 'Cancelled') AND tableNumber = ${tableNum};";
    final results = await DatabaseServices.queryDatabase(query);
    List<Order> orderList = [];
    for (ResultRow row in results) {
      orderList.add(Order.fromDatabase(row));
    }
    return orderList;
  }

  static Future<List<Order>> SearchOrderForTableMangerViewFromDatabase(
      int orderId) async {
    String query =
        "SELECT c.orderId, c.orderStatus, c.dateAndTime, c.tableNumber, c.comments, GROUP_CONCAT(o.name, ':', o.ammount) AS menuItemsNamesAndCounts FROM customerOrder AS c JOIN orderMenuItems AS o ON c.orderId = o.orderId WHERE c.orderStatus NOT IN ('Placed', 'Ready', 'Preparing', 'Served') and c.orderId=$orderId GROUP BY c.orderId";

    // "SELECT * FROM orders WHERE orderStatus NOT IN ('Completed', 'Cancelled') AND tableNumber = ${tableNum};";
    final results = await DatabaseServices.queryDatabase(query);
    List<Order> orderList = [];
    for (ResultRow row in results) {
      orderList.add(Order.fromDatabase(row));
    }
    return orderList;
  }
}
