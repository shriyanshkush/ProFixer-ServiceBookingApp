import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profixer/Pages/beforeLogin.dart';
import 'package:profixer/Pages/User/login_page.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/Services/Navigation_services.dart';
import 'package:profixer/Services/register_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profixer/consts.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await registerServices();
  Stripe.publishableKey=stripePublishableKey;
  runApp(ProviderScope(child: profixer()));
}

class profixer extends StatelessWidget {
  GetIt _getIt=GetIt.instance;
  late NavigationService _navigationService;
  profixer({super.key}) {
    _navigationService= _getIt.get<NavigationService>();

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigationService.navigatorkey,
      title: "ProFixer",
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoSansTextTheme(
          Theme.of(context).textTheme,
        ),
        primaryColor: Color(0xFF1E88E5),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade400),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: Color(0xFF1E88E5),
          foregroundColor: Colors.white
        ),
      ),
      initialRoute: "/splashscreen",
      routes: _navigationService.routes,
      onGenerateRoute: _navigationService.generateRoute,
      home: Beforelogin(),
    );
  }
}