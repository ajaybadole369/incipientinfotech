import 'package:get/get.dart';


import '../../repository/user_repository.dart';
import '../../res/utils/utils.dart';
import '../services/database_helper.dart';

class UserController extends GetxController {
  final UserRepository _repository = UserRepository();

  userData() async {
    _repository.userApi().then((val) async {
      for (int i = 0; i < val.length; i++) {
        await DBHelper.dbHelper.insert({
          DBHelper.colId: val[i]['id'],
          DBHelper.colName: val[i]['name'],
          DBHelper.colUsername: val[i]['username'],
          DBHelper.colEmail: val[i]['email'],
          DBHelper.colPhone: val[i]['phone'],
          DBHelper.colWebsite: val[i]['website'],
          DBHelper.colAdd:
              "${val[i]['address']['street']}-${val[i]['address']['suite']}-${val[i]['address']['city']}"
        });
      }
    }).onError((error, stackTrace) {
      Utils.snackBar('Error', error.toString());
    });
  }

  getData() async {
    var response = await DBHelper.dbHelper.read();
    return response;
  }
}
