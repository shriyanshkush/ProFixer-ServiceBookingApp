import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/Services/Alert_services.dart';
import 'package:profixer/Services/Navigation_services.dart';
import 'package:profixer/Services/auth_services.dart';
import '../../widgets/text_formField.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final GetIt _getIt=GetIt.instance;
  late NavigationService _navigationService;
  late AuthServices _authServices;
  late AlertServices _alertServices;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailcontroller;
  late TextEditingController passwordcontroller;
  bool isLoading=false;
  String? email,password;

  @override
  void initState() {
    super.initState();
    emailcontroller = TextEditingController();
    passwordcontroller = TextEditingController();
    _navigationService=_getIt.get<NavigationService>();
    _authServices=_getIt.get<AuthServices>();
    _alertServices=_getIt.get<AlertServices>();
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                //Image.asset('assets/images/logo.png', height: 60),
                SizedBox(height: 20),
                Text(
                  "Hi, Welcome Back!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  "Hello again, you’ve been missed!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[800],
                    height: 1.5,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Login to continue using the app",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[800],
                    height: 1.5,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                RoundedTextFormField(
                  hintText: "Email",
                  textEditingController: emailcontroller,
                  prefixIcon: Icons.email_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onChanged: (value){
                    email=value;
                  },
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Password",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                RoundedTextFormField(
                  textEditingController: passwordcontroller,
                  hintText: "Password",
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                  onChanged: (value){
                    password=value;
                  },
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => {},
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[800],
                        height: 1.5,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,
                  child: isLoading?CircularProgressIndicator():Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
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
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "or login with",
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Image.asset("assets/images/google.png"),
                      iconSize: 40,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Image.asset("assets/images/facebook.png"),
                      iconSize: 40,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Image.asset("assets/images/apple.png"),
                      iconSize: 40,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? "),
                    GestureDetector(
                      onTap: _navigateToregister,
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Color(0xFF0000FF),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _navigateToregister() {
    _navigationService.pushnamed("/registration");
  }
  void _login() async{

    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      setState(() {
        isLoading = true;
      });
      bool result= await _authServices.logIn(email!, password!);
      print(result);
      if(result) {
        _navigationService.pushReplacementnamed("/userhome");
      } else{
        _alertServices.showToast(text: "Failed to login, Please try again!",
            icon: Icons.error);
      }
      setState(() {
        isLoading = false;
      });
    }
  }
}
