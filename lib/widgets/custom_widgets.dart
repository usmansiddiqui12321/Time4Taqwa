import 'package:time4taqwa/exportall.dart';

class CustomWidgets {
  // SnackbarController loadingwidget(){}
  static CircularProgressIndicator isloading = const CircularProgressIndicator(color: AppColors.primaryColor,);
  static SnackbarController customsnackbar(
          {required String message, required bool isError}) =>
      Get.snackbar(isError ? "Error" : "Success", message,
          backgroundColor: isError ? Colors.red[400] : Colors.green[400]);
}
