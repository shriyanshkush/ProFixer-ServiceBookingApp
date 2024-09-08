
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:profixer/Pages/Technician/techinician_frontpage.dart';
import 'package:profixer/Pages/User/allServicescardpage.dart';
import 'package:profixer/Pages/User/homepage.dart';
import 'package:profixer/Pages/User/technicianlistskillbased.dart';
import 'package:profixer/Pages/beforeLogin.dart';
import 'package:profixer/Pages/User/login_page.dart';
import 'package:profixer/Pages/User/registration_page.dart';

import '../Pages/Technician/technician_registration.dart';


class NavigationService {
  late GlobalKey<NavigatorState> _navigatorkey;

  final Map<String, Widget Function(BuildContext)> _routes = {
    "/beforelogin":(context)=>Beforelogin(),
    "/login" : (context) => LoginPage(),
    "/registration" :(context)=> RegistrationPage(),
    "/technician_front":(context)=>TechinicianFrontpage(),
    "/technician_registration":(context)=>TechnicianRegistration(),
    "/userhome":(context)=>Homepage(),
    "/allservicecardpage":(context)=>AllServicesPage(),
  };

  GlobalKey<NavigatorState>? get navigatorkey{
    return _navigatorkey;
  }
  Map<String, Widget Function(BuildContext)> get routes {
    return _routes;
  }
  NavigationService() {
    _navigatorkey=GlobalKey<NavigatorState>();
  }

  void push(MaterialPageRoute route) {
    _navigatorkey.currentState?.push(route);
  }

  void pushnamed(String routeName, {Object? arguments}) {
    _navigatorkey.currentState?.pushNamed(
      routeName,
      arguments: arguments, // Pass arguments to the named route
    );
  }

  void pushReplacementnamed(String routname) {
    _navigatorkey.currentState?.pushReplacementNamed(routname);
  }

  void goback() {
    _navigatorkey.currentState?.pop();
  }

  // Dynamic route handling, for routes that need arguments
  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/technicianlistskillbased':
        final service = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => TechnicianListSkillBased(service: service),
        );
      default:
        return null; // Handle undefined routes
    }
  }
}