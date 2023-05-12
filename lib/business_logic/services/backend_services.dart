import 'package:mysql1/mysql1.dart';

class DatabaseServices {
  static final _settings = ConnectionSettings(
      host: 'sql7.freemysqlhosting.net',
      port: 3306,
      user: 'sql7615587',
      password: 'R3ApeAvzTA',
      db: 'sql7615587');
  static late final MySqlConnection connection;

//must be called at app laucnh
  static Future<bool> initializeDatabase() async {
    connection = await MySqlConnection.connect(_settings);
<<<<<<< HEAD

=======
>>>>>>> e4e465ea762845fc50a3a19f2f4b1b9c9d91d2be
    return true;
  }

//called to send a query to database
  static Future<Results> queryDatabase(query) async {
    Results results = await connection.query(query);
    return results;
  }
}
