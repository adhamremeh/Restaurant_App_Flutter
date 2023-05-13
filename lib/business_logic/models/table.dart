import 'package:mysql1/mysql1.dart';

enum TableStates { Available, Occupied }

class Table {
  int tableNum;
  String state;

  Table({
    required this.tableNum,
    required this.state,
  });
  Table.fromDatabase(ResultRow result)
      : tableNum = result['tableNumber'] as int,
        state = result['tableStatus'];

  @override
  String toString() {
    // TODO: implement toString
    return '$tableNum , $state';
  }
}
