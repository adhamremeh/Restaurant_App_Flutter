import 'package:mat3ami/business_logic/services/backend_services.dart';
import 'package:mat3ami/business_logic/services/table_services.dart';
import 'package:mat3ami/business_logic/models/table.dart';
import 'package:mat3ami/style/style.dart';

Future<void> main() async {

  await DatabaseServices.initializeDatabase();

}
