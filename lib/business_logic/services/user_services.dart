import 'package:mat3ami/business_logic/services/backend_services.dart';
import 'package:mat3ami/business_logic/view_models/active_user_view_model.dart';

class UserServices {
//log in operations
  Future<bool> logInUser(String userId, String password) async {
    String query =
        "select * from employee where ssn = '$userId' and password = '$password';";

    final result = await DatabaseServices.queryDatabase(query);

    if (result.isNotEmpty) {
      ActiveUser().setActiveUser(result.first);
      return true;
    } else {
      return false;
    }
  }
}
