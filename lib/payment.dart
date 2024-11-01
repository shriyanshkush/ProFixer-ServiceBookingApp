import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'Services/stripe_services.dart';
import 'models/payment_model.dart';

class Paymentwindow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PaymentState();
  }

}
class PaymentState extends State<Paymentwindow> {
  final GetIt getIt=GetIt.instance;
  late StripeServices stripeServices;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stripeServices=getIt.get<StripeServices>();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Stripe Payment Demo",
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () async{
                Payment? payment=await stripeServices.makePayments(100);
                print(payment);
              },
              color: Colors.green,
              child: const Text(
                "Purchase",style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }

}