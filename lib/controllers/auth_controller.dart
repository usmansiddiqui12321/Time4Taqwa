import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../exportall.dart';

class AuthController extends GetxController {
  final storage = GetStorage();
  bool loading = false;
  setloading({required bool value}) {
    loading = value;
    update();
  }

  Future<void> login({required String email, required String password}) async {
    try {
      setloading(value: true);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = {"email": email, "password": password};
      var response = await http.post(
        Uri.parse(AppUrls.loginurl),
        headers: headers,
        body: json.encode(body), // Convert the map to a JSON string
      );

      final Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        // Successfully authenticated and received data
        // Do something with responseData
        Get.to(() => const NavigatorPage());
        log('Response data: $responseData');
        setloading(value: false);
      } else {
        setloading(value: false);

        // Handle authentication error
        CustomWidgets.customsnackbar(
            isError: true, message: responseData['message']);
        log('Authentication error: ${response.statusCode}, Message: ${responseData['message']}');
      }
    } catch (error) {
      setloading(value: false);

      // Handle general error, e.g., network error
      CustomWidgets.customsnackbar(isError: true, message: 'Network error');
      log('Error during authentication: $error');
    } finally {
      setloading(value: false);
    }
  }

  Future<void> signup(
      {required String email,
      required String password,
      required String username,
      required String cpassword}) async {
    try {
      setloading(value: true);

      var headers = {
        'Content-Type': 'application/json',
      };
      var body = {
        "username": username,
        "email": email,
        "password": password,
        "passwordConfirm": cpassword
      };
      var response = await http.post(
        Uri.parse(AppUrls.signupurl),
        headers: headers,
        body: json.encode(body), // Convert the map to a JSON string
      );

      final Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 201) {
        setloading(value: false);

        // Successfully authenticated and received data
        // Do something with responseData
        Get.to(() => const NavigatorPage());
        log('Response data: $responseData');
      } else {
        setloading(value: false);

        // Handle authentication error
        CustomWidgets.customsnackbar(
          isError: true,
          message: "Error : ${response.statusCode}",
        );
        log('Authentication error: ${response.statusCode}, Message: ${responseData['status']}');
      }
    } catch (error) {
      setloading(value: false);

      // Handle general error, e.g., network error
      CustomWidgets.customsnackbar(isError: true, message: 'Network error');
      log('Error during authentication: $error');
    } finally {
      setloading(value: false);
    }
  }
}
