import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../Services/Navigation_services.dart';
import '../../Services/auth_services.dart';
import '../../Services/database_services.dart';
import '../../models/booking_model.dart';
import '../../models/tecnician_model.dart';
import 'booking_card.dart';

class ShowAllBookingsTechnician extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ShowAllBookingsTechnicianState();
  }
}

class ShowAllBookingsTechnicianState extends State<ShowAllBookingsTechnician> {
  final GetIt _getIt = GetIt.instance;
  late DatabaseServices _databaseServices;
  late AuthServices _authServices;
  TechnicianProfile? technicianProfile;
  late List<Booking> booking = [];
  bool isLoading = true;
  late NavigationService _navigationService;

  final double earningsThisMonth = 10000.0;

  @override
  void initState() {
    super.initState();
    _databaseServices = _getIt.get<DatabaseServices>();
    _authServices = _getIt.get<AuthServices>();
    _navigationService = _getIt.get<NavigationService>();
    getCurrentTechnician(_authServices.user!.uid);
  }

  void getCurrentTechnician(String technicianId) async {
    try {
      TechnicianProfile fetchedProfile =
      await _databaseServices.getCurrentTechnician(technicianId);
      setState(() {
        technicianProfile = fetchedProfile;
        booking = fetchedProfile.bookings;
        isLoading = false;
      });
    } catch (e) {
      // Handle error (e.g., show a message)
      setState(() {
        isLoading = false;
      });
      // Optionally show a snackbar or error widget
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to load bookings. Please try again later.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Bookings'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading spinner
          : booking.isEmpty
          ? Center(child: Text('No bookings found.',style: TextStyle(fontSize: 20),))
          : Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                itemCount: booking.length,
                itemBuilder: (context, index) {
                  return BookingCardTechnician(
                    serialNo: index + 1,
                    booking: booking[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
