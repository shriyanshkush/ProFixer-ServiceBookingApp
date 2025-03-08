import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:profixer/Services/auth_services.dart';
import 'package:profixer/Services/database_services.dart';
import 'Services/Navigation_services.dart';


class SplashScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  final GetIt _getIt=GetIt.instance;
  late NavigationService _navigationService;
  late AuthServices _authservice;
  late DatabaseServices _databaseServices;
  @override
  void initState() {
    super.initState();
    _authservice = _getIt.get<AuthServices>();
    _databaseServices = _getIt.get<DatabaseServices>();

    // Navigate after a delay
    Timer(Duration(seconds: 2), () async {
      _navigationService = _getIt.get<NavigationService>();

      // Check if user is logged in
      if (_authservice.user != null) {
        String path = await DecideUserRole(_authservice.user!.uid);
        // Use the correct path to navigate based on user role
        _navigationService.handleLoginSuccess(path);
      } else {
        // Navigate to the login screen if not logged in
        _navigationService.pushReplacementnamed("/beforelogin");
      }
    });
  }

  Future<String> DecideUserRole(String userId) async {
    bool isTechnician = await _databaseServices.decideUser(userId);
    print("printing isTechinician:${isTechnician}");
    return isTechnician ? "/technicianhomepage" : "/userhome";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "ProFixer",
      debugShowCheckedModeBanner: false,
      home: Scaffold(backgroundColor:Colors.white,
        body: Center(child: Container(
          height: 350,
          width: 350,
          decoration: BoxDecoration(
            image: DecorationImage(fit: BoxFit.contain,image:AssetImage("assets/images/logo1.png") ),
          ),

        ),),),
    );
  }

}