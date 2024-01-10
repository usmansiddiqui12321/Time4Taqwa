import 'dart:convert';
import 'dart:developer';
import '../exportall.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final storage = GetStorage();
  bool loading = false;
  setloading({required bool value}) {
    loading = value;
    update();
  }

  Future<void> login() async {
    setloading(value: true);

    var headers = {
      'Authorization': 'Bearer ${storage.read(lsk.token)}',
      'Content-Type': 'application/json',
    };

    try {
      var response =
          await http.get(Uri.parse(AppUrls.loginurl), headers: headers);
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        // Successfully authenticated and received data
        // Do something with responseData
        log('Response data: $responseData');
      } else {
        // Handle authentication error
        // final Map<String, dynamic> responseData = json.decode(response.body);
        CustomWidgets.loadingWidget(
            isError: true, message: responseData['message']);
        log('Authentication error: ${response.statusCode}, Message: ${responseData['message']}');
      }
    } catch (error) {
      // Handle general error, e.g., network error
      CustomWidgets.loadingWidget(isError: true, message: 'Network error');
      log('Error during authentication: $error');
    } finally {
      setloading(value: false);
    }
  }

  Future<void> singup() async {
    setloading(value: true);

    var headers = {
      'Authorization': 'Bearer ${storage.read(lsk.token)}',
      'Content-Type': 'application/json',
    };

    try {
      var response =
          await http.get(Uri.parse(AppUrls.loginurl), headers: headers);

      final Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        // Successfully authenticated and received data
        // Do something with responseData
        log('Response data: $responseData');
      } else {
        // Handle authentication error
        CustomWidgets.loadingWidget(
            isError: true, message: responseData['message']);
        log('Authentication error: ${response.statusCode}, Message: ${responseData['message']}');
      }
    } catch (error) {
      // Handle general error, e.g., network error
      CustomWidgets.loadingWidget(isError: true, message: 'Network error');
      log('Error during authentication: $error');
    } finally {
      setloading(value: false);
    }
  }
}
