import 'dart:convert';
import 'dart:developer';

import 'package:time4taqwa/exportall.dart';
import 'package:http/http.dart' as http;
// import 'package:time4taqwa/models/all_masjid_model.dart';
import 'package:time4taqwa/models/get_donation_model.dart';
import 'package:time4taqwa/models/view_donation_history_model.dart';

class DonationController extends GetxController {
  RxBool isloading = false.obs;
  Rx<GetDonationModel> getalldonationmodel = GetDonationModel().obs;
  Rx<GetDonationModel> getdonationmodel = GetDonationModel().obs;
  Rx<ViewDonationHistoryModel> viewdonationhistorymodel =
      ViewDonationHistoryModel().obs;
  Future<void> getAllDonations() async {
    try {
      isloading(true);
      var response = await http.get(
        Uri.parse(AppUrls.getalldonationurl),
      );
      final jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // Get.close(1);
        // tabController.animateTo(0);
        log('Response data: $jsonData');
        isloading(false);
        getalldonationmodel.value = GetDonationModel.fromJson(jsonData);
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

  Future<void> getDonationsbyEmail(
      {required String email, required bool loading}) async {
    try {
      isloading(loading);
      var response = await http.get(
        Uri.parse('${AppUrls.getdonationurl}$email'),
      );
      final jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // Get.close(1);
        // tabController.animateTo(0);
        log('Response data: $jsonData');
        isloading(false);
        getdonationmodel.value = GetDonationModel.fromJson(jsonData);
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

  Future<void> getdonationHistory() async {
    try {
      isloading(true);
      var response = await http.get(
        Uri.parse(AppUrls.viewdonationurl("testuser1")),
      );
      final jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // Get.close(1);
        // tabController.animateTo(0);
        log('Response data: $jsonData');
        isloading(false);
        viewdonationhistorymodel.value =
            ViewDonationHistoryModel.fromJson(jsonData);
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
