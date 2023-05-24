import 'package:mysql1/mysql1.dart';

enum TableStates { Available, Occupied }

class OrdersList {
  int tableNum;
  String state;

  OrdersList({
    required this.tableNum,
    required this.state,
  });
  OrdersList.fromDatabase(ResultRow result)
      : tableNum = result['tableNumber'] as int,
        state = result['tableStatus'];

  @override
  String toString() {
    return '$tableNum , $state';
  }
}
