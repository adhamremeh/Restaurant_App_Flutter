import 'package:mysql1/mysql1.dart';

class Table {
  int tableNum;
  String state;

  Table(
      {
        required this.tableNum,
        required this.state,
      });
  Table.fromDatabase(ResultRow result)
      : tableNum = result['tableNum'],
        state = result['state'];

  static Future<Results> getTables() async {
    Results tablesData = await queryDatabase('SELECT * FROM dinningTable');

    return tablesData;
  }

  static Future<Results> getOneTable() async {
    Results tablesData = await queryDatabase('SELECT * FROM dinningTable');

    return tablesData;
  }



  static Future<Results> queryDatabase(query) async {
    Results results = await connection.query(query);
    return results;
  }


}
