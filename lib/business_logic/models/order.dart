import 'package:mysql1/mysql1.dart';

class Order {
  int orderId;
  String orderStatus;
  String dateTime;
  int ammount;
  String comment;
  Order(
      {required this.orderId,
      required this.ammount,
      required this.comment,
      required this.dateTime,
      required this.orderStatus});
  Order.fromDatabase(ResultRow result)
      : orderId = result['orderId'],
        ammount = result['ammount'],
        comment = result['comment'],
        dateTime = result['dateTime'],
        orderStatus = result['orderStatus'];
}
