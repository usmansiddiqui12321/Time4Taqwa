import 'package:time4taqwa/exportall.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:time4taqwa/models/all_masjid_model.dart';

class AllMasjidController extends GetxController {
  final storage = GetStorage();
  bool loading = false;
  setloading({required bool value}) {
    loading = value;
    update();
  }

  Future<GetAllMasjid> getall() async {
    try {
      setloading(value: true);
      var headers = {
        'Content-Type': 'application/json',
      };
      var response = await http.get(
        Uri.parse(AppUrls.allmasjids),
        headers: headers,
      );

      final Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        // Successfully authenticated and received data
        // Do something with responseData

        Get.to(() => const NavigatorPage());
        log('Response data: $responseData');
        setloading(value: false);
        return GetAllMasjid.fromJson(responseData);
      } else {
        setloading(value: false);

        // Handle authentication error
        CustomWidgets.customsnackbar(
            isError: true, message: responseData['message']);
        log('Authentication error: ${response.statusCode}, Message: ${responseData['message']}');
        throw Exception();
      }
    } catch (error) {
      setloading(value: false);

      // Handle general error, e.g., network error
      CustomWidgets.customsnackbar(isError: true, message: 'Network error');
      log('Error during authentication: $error');
      throw Exception();
    } finally {
      setloading(value: false);
    }
  }
}
