import 'package:mysql1/mysql1.dart';

class Table {
  int tableNum;
  String state;

  Table({
    required this.tableNum,
    required this.state,
  });
  Table.fromDatabase(ResultRow result)
      : tableNum = result['tableNumber'],
        state = result['tableStatus'];
}
