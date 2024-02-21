import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:time4taqwa/models/caretaker_login_model.dart';
import 'package:time4taqwa/models/user_login_model.dart';
import 'package:time4taqwa/views/admin/admin_homepage.dart';
import '../exportall.dart';

class AuthController extends GetxController {
  final storage = GetStorage();
  bool loading = false;
  Rx<UserLoginModel> userloginmodel = UserLoginModel().obs;
  Rx<CareTakerLoginModel> caretakerloginmodel = CareTakerLoginModel().obs;
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
        Uri.parse(AppUrls.userloginurl),
        headers: headers,
        body: jsonEncode(body), // Convert the map to a JSON string
      );

      final jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        userloginmodel.value = UserLoginModel.fromJson(jsonData);
        Get.to(() => const NavigatorPage());
        log('Response data: $jsonData');
        setloading(value: false);
        CustomWidgets.customsnackbar(
            isError: false, message: 'Logged In Successfully');
        //  UserLoginModel.fromJson(jsonData);
      } else {
        setloading(value: false);

        // Handle authentication error
        CustomWidgets.customsnackbar(
            isError: true, message: jsonData['message']);
        log('Authentication error: ${response.statusCode}, Message: ${jsonData['message']}');
        throw jsonData['message'];
      }
    }on SocketException {
      CustomWidgets.customsnackbar(message: "No internet connection", isError: true);
    } catch (error) {
      setloading(value: false);
      CustomWidgets.customsnackbar(isError: true, message: 'Network error');
      log('Error during authentication: $error');
    } finally {
      setloading(value: false);
    }
    return;
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
        "passwordConfirm": cpassword,
      };
      var response = await http.post(
        Uri.parse(AppUrls.signupurl),
        headers: headers,
        body: jsonEncode(body), // Convert the map to a JSON string
      );

      final jsonData = jsonDecode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        setloading(value: false);
        userloginmodel.value = UserLoginModel.fromJson(jsonData);

        // Successfully authenticated and received data
        // Do something with responseData
        Get.to(() => const NavigatorPage());
        log('Response data: $jsonData');
        CustomWidgets.customsnackbar(
            isError: false, message: 'Signed Up Successfully');
      } else {
        setloading(value: false);

        // Handle authentication error
        CustomWidgets.customsnackbar(
          isError: true,
          message: "Error : ${response.statusCode}",
        );
        log('Authentication error: ${response.statusCode}, Message: ${jsonData['status']}');
      }
    }on SocketException {
      CustomWidgets.customsnackbar(message: "No internet connection", isError: true);
    } catch (error) {
      setloading(value: false);

      // Handle general error, e.g., network error
      CustomWidgets.customsnackbar(isError: true, message: 'Network error');
      log('Error during authentication: $error');
    } finally {
      setloading(value: false);
    }
  }

  Future<void> adminlogin(
      {required String email, required String password}) async {
    try {
      setloading(value: true);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = {
        "email": email,
        "password": password,
      };
      var response = await http.post(
        Uri.parse(AppUrls.adminloginurl),
        headers: headers,
        body: json.encode(body), // Convert the map to a JSON string
      );

      final jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        caretakerloginmodel.value = CareTakerLoginModel.fromJson(jsonData);
        Get.to(() => const AdminHomePage());
        log('Response data: $jsonData');
        setloading(value: false);
        CustomWidgets.customsnackbar(
            isError: false, message: 'Logged In Successfully');
      } else {
        setloading(value: false);
        CustomWidgets.customsnackbar(
            isError: true, message: jsonData['message']);
        log('Authentication error: ${response.statusCode}, Message: ${jsonData['message']}');
      }
    }on SocketException {
      CustomWidgets.customsnackbar(message: "No internet connection", isError: true);
    } catch (error) {
      setloading(value: false);
      CustomWidgets.customsnackbar(isError: true, message: 'Network error');
      log('Error during authentication: $error');
    } finally {
      setloading(value: false);
    }
  }
}
