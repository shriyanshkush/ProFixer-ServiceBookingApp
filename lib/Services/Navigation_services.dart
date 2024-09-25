
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:profixer/Pages/Technician/techinician_frontpage.dart';
import 'package:profixer/Pages/User/allServicescardpage.dart';
import 'package:profixer/Pages/User/homepage.dart';
import 'package:profixer/Pages/User/technicianInfo.dart';
import 'package:profixer/Pages/User/technicianlistskillbased.dart';
import 'package:profixer/Pages/beforeLogin.dart';
import 'package:profixer/Pages/User/login_page.dart';
import 'package:profixer/Pages/User/registration_page.dart';
import 'package:profixer/models/tecnician_model.dart';

import '../Pages/Booking/booking_page.dart';
import '../Pages/Technician/technician_registration.dart';
import '../Pages/User/CartPage.dart';
import '../Pages/User/showbooking.dart';


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
    "/cartpage":(context)=>CartPage(),
    "/showbooking":(context)=>ShowBookings(),
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
      case '/technicianinfo':
        final technician = settings.arguments as TechnicianProfile;
        return MaterialPageRoute(
          builder: (context) => TechnicianInfoPage(technician: technician,),
        );
      case '/bookingpage':
        final technician = settings.arguments as TechnicianProfile;
        return MaterialPageRoute(
          builder: (context) => BookingForm(technician: technician,),
        );
      default:
        return null; // Handle undefined routes
    }
  }
}