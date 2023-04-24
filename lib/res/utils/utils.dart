import 'package:get/get.dart';


class Utils{
  static void snackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
    );
  }
}