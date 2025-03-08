import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profixer/Services/Navigation_services.dart';

class Beforelogin extends StatefulWidget {
  @override
  State<Beforelogin> createState() => _BeforeloginState();
}

class _BeforeloginState extends State<Beforelogin> {
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
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.all(10)),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: MediaQuery.of(context).size.height * 0.45, // Adjust height as needed
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/images/login.jpeg',
              fit: BoxFit.fitWidth,),
            ),
            SizedBox(height: 3,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/images/logo1.png', height: 40),
                SizedBox(width: 15),
                Text(
                  "Pro",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Fixer",
                  style: TextStyle(fontSize: 30,),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Get Your Services Done Right!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 10),
            Text(
              "Say goodbye to the hassle of finding reliable technicians. ProFixer connects you with trusted professionals for all your service needs—appliance, plumbing, electrical, and HVAC.",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.normal,
                color: Colors.grey[600],
                height: 1.5,
                letterSpacing: 0.1,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  _navigationService.pushnamed("/userroleselection");
                },
                child: RichText(
                  text: TextSpan(
                    text: "Proceed as Technician or Admin",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                      decoration: TextDecoration.underline, // Underline the text
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                 _navigationService.pushnamed("/login");
                //_navigationService.pushnamed("/registration");
              },
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 130, vertical: 15), // Adjust the padding for a longer button
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                backgroundColor: Color(0xFF0000FF), // Dark blue color
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _navigationService.pushnamed("/registration");
              },
              child: Text(
                "Register",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15), // Adjust the padding for a longer button
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                backgroundColor: Color(0xFF0000FF), // Dark blue color
              ),
            ),
            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}
