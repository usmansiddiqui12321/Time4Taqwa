import 'package:time4taqwa/exportall.dart';

class RoutingController extends GetxController {
  int currentDrawer = 0;

  void setCurrentDrawer(int drawer) {
    currentDrawer = drawer;
    update();
  }

  int currentbottom = 0;
  void setCurrentBottom(int bottomindex) {
    currentbottom = bottomindex;
    update();
  }
}
