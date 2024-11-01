import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../consts.dart';
import '../models/payment_model.dart';

class StripeServices {

  Future<Payment?> makePayments(int amount) async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(amount, "inr");
      print("printing payment intent:$paymentIntentClientSecret");
      if (paymentIntentClientSecret != null) {
        print('Client Secret: $paymentIntentClientSecret'); // Log the client secret
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentClientSecret,
            merchantDisplayName: "Shriyansh Kushwaha",
          ),
        );

        // Present the payment sheet
        await Stripe.instance.presentPaymentSheet();
        print("object");
        final payment = Payment(
          paymentId: paymentIntentClientSecret,
          amount: amount.toString(),
          status: "succeeded",
          timeStamp: DateTime.now().toIso8601String(),
        );

        if(payment!=null) {
          print("Printing Payment instance: ${payment.toJson()}");// Log the payment instance
        }
        return payment;
      }
    } catch (e) {
      print("Error in makePayments: $e");
    }
    return null;
  }


  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency,
      };
      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": 'application/x-www-form-urlencoded',
          },
        ),
      );
      if (response != null) {
        return response.data["client_secret"];
      }
      return null;
    } catch (e) {
      print("Error in _createPaymentIntent: $e");
      return null;
    }
  }

  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}
