import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/Services/Navigation_services.dart';

class TechinicianFrontpage extends StatefulWidget {
  @override
  State<TechinicianFrontpage> createState() => _TechinicianFrontpageState();
}

class _TechinicianFrontpageState extends State<TechinicianFrontpage> {
  final GetIt _getIt=GetIt.instance;
  late NavigationService _navigationService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigationService=_getIt.get<NavigationService>();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.lightBlue[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // ProFixer Logo
              //Image.asset('assets/images/logo.png', height: 100),
              SizedBox(height: 30,),
              Text(
                "Connecting Skilled Technicians with Trusted Opportunities",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30,),
              CircleAvatar(
                  radius: MediaQuery.sizeOf(context).height*0.15,
                  child: Image.asset('assets/images/technician.png', height: 200)),
              // Description Text
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Join ProFixer to connect with customers in need of your expertise. "
                      "Reliable jobs, secure payments, and flexible scheduling.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey[600],
                  ),
                ),
              ),
              // Login and Register Buttons
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){
                  _navigationService.pushnamed("/login");
                },
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 131, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Color(0xFF0000FF),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: (){
                  _navigationService.pushnamed("/technician_registration");
                },
                child: Center(
                  child: Text(
                    "Register",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Color(0xFF0000FF),
                ),
              ),
              // Footer
              Spacer(),
              Text(
                "Terms of Service | Privacy Policy",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
