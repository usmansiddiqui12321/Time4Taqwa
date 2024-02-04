import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class StripeController extends GetxController {
  var paymentIntent;
  var stripe = Stripe.instance;
  var secretkey = "sk_test_51Og9eBJqpCXg0W6pf4k1s5uBSF4fvsPTEycXcWoU8laeJPoIq6FcdY2mErxWKUL8Q6Kr6ZcoTUQt9bEGzr1aEsjb00xKX1TRoy";
  Future<void> makePayment(BuildContext context ,String price) async {
    try {
      //STEP 1: Create Payment Intent
      paymentIntent = await createPaymentIntent(price, "pkr");

      //STEP 2: Initialize Payment Sheet
      await stripe
          .initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret:
                paymentIntent!['client_secret'], //Gotten from payment intent
            style: ThemeMode.light,
            merchantDisplayName: 'Random_Merchant_Name'),
      )
          .then((value) {
        //! Here
        if (kDebugMode) {
          // print(value.toString());
          print(paymentIntent.toString());
          print("Succeed");
        }

        displayPaymentSheet(context);
      });

      //STEP 3: Display Payment sheet
    } on StripeConfigException {
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
        headers: {
          'Authorization':
              'Bearer $secretkey'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  displayPaymentSheet(BuildContext context) async {
    if (kDebugMode) {
      print("00");
    }
    try {
      if (kDebugMode) {
        print("11");
      }
      await Stripe.instance.presentPaymentSheet().then((value) {
        print("SUCCESS HERE $value");
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
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
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