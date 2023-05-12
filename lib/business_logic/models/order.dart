import 'package:mat3ami/business_logic/models/menu_item.dart';
import 'package:mysql1/mysql1.dart';

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

  static Order fromDatabase(Results result) {
    final orderId = result.first['orderId'];
    final comments = result.first['comments'];
    final dateTime = result.first['dateTime'];
    final orderStatus = result.first['orderStatus'];
    final Map<String, int> menuItemsNamesAndCounts = {};
    for (ResultRow row in result) {
      menuItemsNamesAndCounts[row['name']] = row['ammount'];
    }
    return Order(
        orderId: orderId,
        comments: comments,
        dateTime: dateTime,
        orderStatus: orderStatus,
        menuItemsNamesAndCounts: menuItemsNamesAndCounts);
  }
}
