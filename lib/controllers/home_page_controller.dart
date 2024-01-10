import 'dart:async';
import 'dart:developer';

import 'package:time4taqwa/exportall.dart';

class HomePageController extends GetxController {
  List<String> hadithList = [
    "The believer's shade on the Day of Resurrection will be his charity.",
    "A kind word and forgiveness are better than charity followed by injury. Allah is Self-Sufficient, Forbearing.",
    "Charity does not decrease wealth;"
  ];
  int currentIndex = 0;
  Timer? timer;

  String changeHadith() {
    // Clear the existing timer
    timer?.cancel();

    // Create a new timer
    timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      currentIndex = (currentIndex + 1) % hadithList.length;
      log("$currentIndex===========================");
      update();
    });

    return hadithList[currentIndex];
  }
}
