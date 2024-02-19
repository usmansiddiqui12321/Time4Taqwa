import 'dart:convert';
import 'dart:developer';

import 'package:time4taqwa/exportall.dart';
import 'package:http/http.dart' as http;
import 'package:time4taqwa/models/caretaker_login_model.dart';

class MasjidTimeController extends GetxController {
  RxBool isloading = false.obs;
  Rx<SetMosque> timemodel = SetMosque().obs;
  final logincontroller = Get.put(AuthController());
  Future<void> updatetimings(
      {required String fajar,
      required String zuhar,
      required String asar,
      required TabController tabController,
      required String maghrib,
      required String isha,
      required String jummah,
      required String mosqueid}) async {
    try {
      isloading(true);

      var body = {
        "Fajar": fajar,
        "Zuhr": zuhar,
        "Asar": asar,
        "Maghrib": maghrib,
        "Esha": isha,
        "Jummah": jummah
      };
      var response = await http.patch(
        Uri.parse('${AppUrls.updateNamazTime}$mosqueid'),
        body: body,
      );

      final jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.close(1);
        tabController.animateTo(0);

        log('Response data: $jsonData');
        isloading(false);
        timemodel.value = SetMosque.fromJson(jsonData['data']['mosque']);
        logincontroller.caretakerloginmodel.value.data!.mosque =
            timemodel.value;
      } else {
        isloading(false);

        CustomWidgets.customsnackbar(
            isError: true, message: jsonData['message']);
        log('Authentication error: ${response.statusCode}, Message: ${jsonData['message']}');
        throw Exception();
      }
    } catch (error) {
      // setloading(value: false);
      isloading(false);

      // Handle general error, e.g., network error
      CustomWidgets.customsnackbar(isError: true, message: 'Network error');
      log('Error during authentication: $error');
      throw Exception();
    } finally {
      // setloading(value: false);
      isloading(false);
    }
  }
}
