import 'package:get/get.dart';

class ThemeController extends GetxController {
  bool isDarkMode = false;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    update();
  }
}
