import 'dart:io';

import 'package:time4taqwa/exportall.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:time4taqwa/models/all_masjid_model.dart';

class AllMasjidController extends GetxController {
  final searchController = TextEditingController();
  Rx<GetAllMasjidModel> getallmasjidmodel = GetAllMasjidModel().obs;
  final storage = GetStorage();
  RxBool isloading = false.obs;
  // setloading({required RxBool value
  //isloading(false);}) {
  //   loading.value = value.value;
  //   update();
  // }

  Future<GetAllMasjidModel?> getall() async {
    try {
      // setloading(value: true);
      isloading(true);
      var headers = {
        'Content-Type': 'application/json',
      };
      var response = await http.get(
        Uri.parse(AppUrls.allmasjids),
        headers: headers,
      );

      final Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        Get.to(() => const NavigatorPage());
        log('Response data: $responseData');
        // setloading(value: false);
        isloading(false);
        getallmasjidmodel.value = GetAllMasjidModel.fromJson(responseData);
        return GetAllMasjidModel.fromJson(responseData);
      } else {
        // setloading(value: false);
        isloading(false);

        CustomWidgets.customsnackbar(
            isError: true, message: responseData['message']);
        log('Error: ${response.statusCode}, Message: ${responseData['message']}');
        throw Exception();
      }
    } on SocketException {
      CustomWidgets.customsnackbar(
          message: "No internet connection", isError: true);
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

  String searchresult = "";
  updatesearchresult(String value) {
    searchresult = value;
    update();
  }

  @override
  void onInit() {
    searchController;
    super.onInit();
  }

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }
}
