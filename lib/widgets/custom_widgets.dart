import 'package:time4taqwa/exportall.dart';

class CustomWidgets {
  // SnackbarController loadingwidget(){}
 static SnackbarController loadingWidget(
          {required String message, required bool isError}) =>
      Get.snackbar(isError ? "Error" : "Success", message,
          backgroundColor: isError ? Colors.red[400] : Colors.green[400]);
}
