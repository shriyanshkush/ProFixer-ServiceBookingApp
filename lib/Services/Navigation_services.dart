
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:profixer/Pages/Technician/techinician_frontpage.dart';
import 'package:profixer/Pages/Technician/technician_profile.dart';
import 'package:profixer/Pages/User/allServicescardpage.dart';
import 'package:profixer/Pages/User/homepage.dart';
import 'package:profixer/Pages/User/technicianInfo.dart';
import 'package:profixer/Pages/User/technicianlistskillbased.dart';
import 'package:profixer/Pages/beforeLogin.dart';
import 'package:profixer/Pages/User/login_page.dart';
import 'package:profixer/Pages/User/registration_page.dart';
import 'package:profixer/Pages/UserRoleSelectionPage.dart';
import 'package:profixer/models/tecnician_model.dart';
import 'package:profixer/models/user_model.dart';

import '../Pages/Admin/Admin_login.dart';
import '../Pages/Admin/adminDashBoard.dart';
import '../Pages/Admin/technicianVerification.dart';
import '../Pages/Booking/booking_page.dart';
import '../Pages/Technician/home_page.dart';
import '../Pages/Technician/show_all_bookings.dart';
import '../Pages/Technician/techinician_login.dart';
import '../Pages/Technician/technician_registration.dart';
import '../Pages/User/CartPage.dart';
import '../Pages/User/all_recommended_technician.dart';
import '../Pages/User/showbooking.dart';
import '../Pages/User/user_profile.dart';
import '../Splash_Screen.dart';
import '../payment.dart';


class NavigationService {
  late GlobalKey<NavigatorState> _navigatorkey;

  final Map<String, Widget Function(BuildContext)> _routes = {
    "/splashscreen":(context)=>SplashScreen(),
    "/beforelogin":(context)=>Beforelogin(),
    "/login" : (context) => LoginPage(),
    "/registration" :(context)=> RegistrationPage(),
    "/technician_front":(context)=>TechinicianFrontpage(),
    "/technician_login":(context)=>TechinicianLogin(),
    "/technician_registration":(context)=>TechnicianRegistration(),
    "/userhome":(context)=>Homepage(),
    "/allservicecardpage":(context)=>AllservicesPage(),
    "/cartpage":(context)=>CartPage(),
    "/showbooking":(context)=>ShowBookings(),
    "/allrecommendedtechinician":(context)=>AllRecommendedTechniciansPage(),
    "/userroleselection":(context)=>UserRoleSelectionPage(),
    "/technicianhomepage":(context)=>TechnicianHomePage(),
    "/adminlogin":(context)=>AdminLogin(),
    "/admindashboard":(context)=>AdminDashboard(),
    "/technicianverification":(context)=>TechnicianVerificationPage(),
    "/showallbookingstotechnician":(context)=>ShowAllBookingsTechnician(),
    "/payment":(context)=>Payment(),
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
      case '/technicianprofilepage':
        final technician = settings.arguments as TechnicianProfile;
        return MaterialPageRoute(
          builder: (context) => TechnicianProfilePage(technicianProfile: technician,),
        );
      case '/userprofilepage':
        final user = settings.arguments as UserProfile;
        return MaterialPageRoute(
          builder: (context) => UserProfilePage(userProfile: user,),
        );
      default:
        return null; // Handle undefined routes
    }
  }
}