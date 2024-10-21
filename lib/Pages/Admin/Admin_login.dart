import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/Services/Navigation_services.dart';

class AdminLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdminLoginState();
  }
}

class AdminLoginState extends State<AdminLogin> {
  final TextEditingController _passcodeController = TextEditingController();
  final String _correctPasscode = "8963914867"; // Define the correct passcode

  final GetIt _getIt=GetIt.instance;
  late NavigationService _navigationService;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigationService=_getIt.get<NavigationService>();
  }

  void _validatePasscode() {
    if (_passcodeController.text == _correctPasscode) {
      _navigationService.pushnamed("/admindashboard");
    } else {
      // Show an error message if the passcode is incorrect
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Incorrect passcode. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Login"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _passcodeController,
              obscureText: true, // Hide the passcode input
              decoration: InputDecoration(
                labelText: "Enter Passcode",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _validatePasscode,
              child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 18),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

