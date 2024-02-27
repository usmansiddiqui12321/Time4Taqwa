import 'package:time4taqwa/exportall.dart';

class NamazController extends GetxController {
  RxInt fajarCount = 0.obs;
  RxInt zuharCount = 0.obs;
  RxInt asarCount = 0.obs;
  RxInt maghribCount = 0.obs;
  RxInt ishaCount = 0.obs;
  void incrementQazaCount(RxInt value) {
    value.value++;
  }

  void decrementQazaCount(RxInt value) {
    if (value.value > 0) {
      value.value--;
    }
  }
}