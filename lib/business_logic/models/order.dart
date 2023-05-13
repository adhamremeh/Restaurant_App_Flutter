import 'package:mysql1/mysql1.dart';

enum OrderStates { Placed, Preparing, Ready, Served, Completed, Cancelled }

class Order {
  int orderId;
  String orderStatus;
  DateTime dateTime;
  String comments;
  Map<String, int> menuItemsNamesAndCounts;
  double total = 0.0;

  get getTotal => this.total;

  set setTotal(total) => this.total = total;

  Order(
      {required this.orderId,
      required this.comments,
      required this.dateTime,
      required this.orderStatus,
      required this.menuItemsNamesAndCounts});

  static Order fromDatabase(ResultRow result) {
    final orderId = result['orderId'] as int;
    final comments = result['comments'];
    final dateTime = DateTime.parse(result['dateAndTime']);
    final orderStatus = result['orderStatus'];
    final Map<String, int> menuItemsNamesAndCounts = {};
    final menuItemsNamesAndCountsList =
        result['menuItemsNamesAndCounts'].toString().split(',');
    for (String item in menuItemsNamesAndCountsList) {
      final splitItem = item.split(':');
      menuItemsNamesAndCounts[splitItem[0]] = int.parse(splitItem[1]);
    }

    return Order(
        orderId: orderId,
        comments: comments,
        dateTime: dateTime,
        orderStatus: orderStatus,
        menuItemsNamesAndCounts: menuItemsNamesAndCounts);
  }

  @override
  String toString() {
    // TODO: implement toString
    return '$orderId , $comments , $dateTime , $orderStatus , $menuItemsNamesAndCounts';
  }
}
