import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:time4taqwa/controllers/donation_controller.dart';

class StripeController extends GetxController {
  RxBool isloading = false.obs;
  var paymentIntent;
  var stripe = Stripe.instance;
  final donationcontroller = Get.put(DonationController());
  var secretkey =
      "sk_test_51Og9eBJqpCXg0W6pf4k1s5uBSF4fvsPTEycXcWoU8laeJPoIq6FcdY2mErxWKUL8Q6Kr6ZcoTUQt9bEGzr1aEsjb00xKX1TRoy";
  Future<void> makePayment(
      {required BuildContext context,
      required String price,
      required String mosqueName,
      required String title,
      required String description}) async {
    try {
      isloading(true);
      paymentIntent = await createPaymentIntent(price, "pkr");
      await stripe
          .initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent!['client_secret'],
            style: ThemeMode.light,
            merchantDisplayName: 'Random_Merchant_Name'),
      )
          .then((value) {
        isloading(false);
        if (kDebugMode) {
          print(paymentIntent.toString());
          print("Succeed");
        }
        displayPaymentSheet(
          context: context,
          description: description,
          mosqueName: mosqueName,
          title: title,
          price: price,
        );
      });
    } on StripeConfigException {
      isloading(false);
      Get.snackbar("ERROR", "Configuration Exception Here",
          colorText: Colors.white,
          backgroundColor: const Color.fromARGB(255, 81, 77, 67),
          isDismissible: true,
          dismissDirection: DismissDirection.up,
          snackPosition: SnackPosition.BOTTOM);
      if (kDebugMode) {
        print(
            "==================Configuration EXCEPTION HERE ================");
      }
    } on $StripeExceptionCopyWith {
      isloading(false);

      if (kDebugMode) {
        print("==================StripeExceptionCopyWith HERE================");
      }
      Get.snackbar("ERROR", "StripeExceptionCopyWith Exception Here",
          colorText: Colors.white);
    } on StripeException {
      if (kDebugMode) {
        print("==================Stripe EXCEPTION HERE================");
      }
    } catch (err) {
      isloading(false);

      throw Exception(err);
    }
  }

  calculateAmount(String amount) {
    int parsedAmount = int.parse(amount);
    String amountInCents = (parsedAmount * 100).toString();
    if (kDebugMode) {
      print(amountInCents);
    }
    return amountInCents;
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        "automatic_payment_methods[enabled]": "true"
      };
      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {'Authorization': 'Bearer $secretkey'},
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  displayPaymentSheet(
      {required BuildContext context,
      required String price,
      required String mosqueName,
      required String title,
      required String description}) async {
    if (kDebugMode) {
      print("00");
    }
    try {
      if (kDebugMode) {
        print("11");
      }
      await Stripe.instance.presentPaymentSheet().then((value) {
        if (kDebugMode) {
          print("SUCCESS HERE $value");
        }
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100.0,
                      ),
                      SizedBox(height: 10.0),
                      Text("Payment Successful!"),
                    ],
                  ),
                ));

        paymentIntent = null;
      }).then((value) {
        donationcontroller.pushDonation(
            mosqueName: mosqueName,
            title: title,
            amount: price,
            description: description);
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      if (kDebugMode) {
        print('Error is:---> $e');
      }
      const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print('$e');
      }
    }
  }
}
