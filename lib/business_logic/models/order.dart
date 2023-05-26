import 'package:mysql1/mysql1.dart';
import 'package:mat3ami/business_logic/services/order_services.dart' as o;

enum OrderStates { Placed, Preparing, Ready, Served, Completed, Cancelled }

class Order {
  int orderId;
  String orderStatus;
  DateTime dateTime;
  String comments;
  Map<String, int> menuItemsNamesAndCounts;
  double total = 0.0;
  int tableNum;

  List<String> _sortedStates = [
    'Placed',
    'Ready',
    'Preparing',
    'Served',
    'Completed',
    'Cancelled'
  ];

  get getTotal => this.total;

  get allItemsAndCounts => null;

  set setTotal(total) => this.total = total;

  Order(
      {required this.orderId,
      required this.comments,
      required this.dateTime,
      required this.orderStatus,
      required this.menuItemsNamesAndCounts,
      required this.tableNum});

  static Order fromDatabase(ResultRow result) {
    final orderId = result['orderId'] as int;
    final comments = result['comments'];
    final dateTime = DateTime.parse(result['dateAndTime']);
    final orderStatus = result['orderStatus'];
    final Map<String, int> menuItemsNamesAndCounts = {};
    final menuItemsNamesAndCountsList =
        result['menuItemsNamesAndCounts'].toString().split(',');
    final tableNum = result['tableNumber'] as int;
    for (String item in menuItemsNamesAndCountsList) {
      final splitItem = item.split(':');
      menuItemsNamesAndCounts[splitItem[0]] = int.parse(splitItem[1]);
    }

    return Order(
        orderId: orderId,
        comments: comments,
        dateTime: dateTime,
        orderStatus: orderStatus,
        menuItemsNamesAndCounts: menuItemsNamesAndCounts,
        tableNum: tableNum);
  }

  int compareTo(Order other) {
    if (_sortedStates.indexOf(orderStatus) <
        _sortedStates.indexOf(other.orderStatus)) {
      return -1;
    } else if (_sortedStates.indexOf(orderStatus) >
        _sortedStates.indexOf(other.orderStatus)) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return '$orderId , $comments , $dateTime , $orderStatus , $menuItemsNamesAndCounts,$tableNum';
  }
}
