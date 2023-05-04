import 'package:mysql1/mysql1.dart';

class DatabaseServices {
  var settings = ConnectionSettings(
      host: 'sql7.freemysqlhosting.net',
      port: 3306,
      user: 'sql7615587',
      password: 'R3ApeAvzTA',
      db: 'sql7615587');
  late final MySqlConnection connection;

  DatabaseServices() {
    initializeDatabase();
  }

  initializeDatabase() async {
    connection = await MySqlConnection.connect(settings);
    Results results = await connection.query('select * from emplyee');
    for (ResultRow result in results) {
      print(result[0]);
    }
  }
}
