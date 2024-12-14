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

  void setLoading({required bool value}) {
    loading = value;
    update();
  }

  Future<void> _handleResponse(
      http.Response response, Function(dynamic) onSuccess) async {
    final jsonData = jsonDecode(response.body);

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(jsonData);
        break;
      case 400:
      case 401:
      case 403:
        throw jsonData['message'] ?? 'Authentication error';
      case 404:
        throw 'Resource not found';
      case 500:
        throw 'Server error, please try again later';
      default:
        throw 'Unexpected error occurred (Status: ${response.statusCode})';
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      setLoading(value: true);

      var headers = {'Content-Type': 'application/json'};
      var body = jsonEncode({"email": email, "password": password});
      var response = await http.post(Uri.parse(AppUrls.userloginurl),
          headers: headers, body: body);

      await _handleResponse(response, (jsonData) {
        userloginmodel.value = UserLoginModel.fromJson(jsonData);
        Get.to(() => const NavigatorPage());
        log('Response data: $jsonData');
        CustomWidgets.customsnackbar(
            isError: false, message: 'Logged In Successfully');
      });
    } on SocketException {
      CustomWidgets.customsnackbar(
          message: "No internet connection", isError: true);
    } catch (error) {
      CustomWidgets.customsnackbar(isError: true, message: error.toString());
      log('Error during login: $error');
    } finally {
      setLoading(value: false);
    }
  }

  Future<void> signup({
    required String email,
    required String password,
    required String username,
    required String cpassword,
  }) async {
    try {
      setLoading(value: true);

      var headers = {'Content-Type': 'application/json'};
      var body = jsonEncode({
        "username": username,
        "email": email,
        "password": password,
        "passwordConfirm": cpassword,
      });
      var response = await http.post(Uri.parse(AppUrls.signupurl),
          headers: headers, body: body);

      await _handleResponse(response, (jsonData) {
        userloginmodel.value = UserLoginModel.fromJson(jsonData);
        Get.to(() => const NavigatorPage());
        log('Response data: $jsonData');
        CustomWidgets.customsnackbar(
            isError: false, message: 'Signed Up Successfully');
      });
    } on SocketException {
      CustomWidgets.customsnackbar(
          message: "No internet connection", isError: true);
    } catch (error) {
      CustomWidgets.customsnackbar(isError: true, message: error.toString());
      log('Error during signup: $error');
    } finally {
      setLoading(value: false);
    }
  }

  Future<void> adminlogin(
      {required String email, required String password}) async {
    try {
      setLoading(value: true);

      var headers = {'Content-Type': 'application/json'};
      var body = jsonEncode({"email": email, "password": password});
      var response = await http.post(Uri.parse(AppUrls.adminloginurl),
          headers: headers, body: body);

      await _handleResponse(response, (jsonData) {
        caretakerloginmodel.value = CareTakerLoginModel.fromJson(jsonData);
        Get.to(() => const AdminHomePage());
        log('Response data: $jsonData');
        CustomWidgets.customsnackbar(
            isError: false, message: 'Logged In Successfully');
      });
    } on SocketException {
      CustomWidgets.customsnackbar(
          message: "No internet connection", isError: true);
    } catch (error) {
      CustomWidgets.customsnackbar(isError: true, message: error.toString());
      log('Error during admin login: $error');
    } finally {
      setLoading(value: false);
    }
  }
}
