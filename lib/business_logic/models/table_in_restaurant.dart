import 'package:mysql1/mysql1.dart';

enum TableStates { Available, Occupied }

class TableInRestaurant {
  int tableNum;
  String state;

  TableInRestaurant({
    required this.tableNum,
    required this.state,
  });
  TableInRestaurant.fromDatabase(ResultRow result)
      : tableNum = result['tableNumber'] as int,
        state = result['tableStatus'];

  @override
  String toString() {
    return '$tableNum , $state';
  }
}
