import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/Services/Navigation_services.dart';
import 'package:profixer/Services/auth_services.dart';
import 'package:profixer/Services/database_services.dart';
import 'package:profixer/models/tecnician_model.dart';
import '../../models/booking_model.dart';
import 'booking_card.dart';

class TechnicianHomePage extends StatefulWidget {
  @override
  _TechnicianHomePageState createState() => _TechnicianHomePageState();
}

class _TechnicianHomePageState extends State<TechnicianHomePage> {
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
    _navigationService=_getIt.get<NavigationService>();
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
        technicianProfile = null; // Ensure technicianProfile is null on error
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : technicianProfile == null
          ? Center(child: Text('Failed to load technician profile.'))
          : _buildBodyBasedOnVerification(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

// This method returns different widgets based on verification status
  Widget _buildBodyBasedOnVerification() {
    if (technicianProfile == null) {
      return Center(child: Text('Technician profile is not available.'));
    }
    if (technicianProfile!.verificationStatus == "Pending") {
      return _pendingVerificationView();
    } else if (technicianProfile!.verificationStatus == "rejected") {
      return _rejectedVerificationView();
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.037),
              top(technicianProfile!.name),
              SizedBox(height: 6),
              earningsSummary(),
              SizedBox(height: 10),
              bookingsHeader(),
              SizedBox(height: 6),
              booking.isEmpty ? _noBookingsView() : showTodayBooking(booking),
            ],
          ),
        ),
      );
    }
  }

// Pending verification view
  Widget _pendingVerificationView() {
    return const Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.hourglass_empty, size: 80, color: Colors.orange),
            SizedBox(height: 20),
            Text(
              "Your profile is under review.",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "We will notify you once the verification process is complete.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

// Rejected verification view
  Widget _rejectedVerificationView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 80, color: Colors.red),
            SizedBox(height: 20),
            Text(
              "Your profile verification was rejected.",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Please contact support or reapply with updated details.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget earningsSummary() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          )),
      width: 365,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Earnings Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 5),
            Center(child: Text("Total Earnings Today:₹ 1000.00")),
            Center(
                child: Text(
                    'Total Earnings This Month: ₹${earningsThisMonth.toStringAsFixed(2)}')),
            Center(
              child: TextButton(
                onPressed: () {
                  // Handle view detailed earnings
                },
                child: Text(
                  'View Detailed Earnings',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bookingsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          " Today's Bookings",
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: (){
            _navigationService.pushnamed("/showallbookingstotechnician");
          },
          child: Text(
            "view all",
            style: TextStyle(fontSize: 21, color: Colors.blue),
          ),
        )
      ],
    );
  }

  Widget _bottomNavigationBar() {
    return Container(
      height: 70,
      color: Colors.blue,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.home,
                    size: 33,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Home",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Column(
              children: [
                Builder(
                  builder: (context) => Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.person,
                        size: 33,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _navigationService.pushnamed("/technicianprofilepage",arguments: technicianProfile);
                      },
                    ),
                  ),
                ),
                Text(
                  "Profile",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    _navigationService.pushnamed("/showallbookingstotechnician");
                  },
                  icon: Icon(
                    Icons.calendar_month,
                    size: 33,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Booking",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.chat,
                    size: 33,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Chat",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 33,
                  ),
                  onPressed: () {
                    // Handle notifications
                  },
                ),
                Text(
                  "Notifications",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget top(String technicianName) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue.shade100,
        ),
        height: 160,
        width: 370,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hey $technicianName !",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5),
              Text(
                "Ready for Today's Services?",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              _searchBar(MediaQuery.of(context).size),
            ],
          ),
        ),
      ),
    );
  }

  Widget showTodayBooking(List<Booking>? bookings) {
    // Check if bookings is null or empty
    if (bookings == null || bookings.isEmpty) {
      return Center(
        child: Text(
          'No bookings available for today',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return Container(
      height: 360, // Adjust height according to your design
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 360, // Adjust the height for the ListView.builder
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 380, // Set a fixed width for each booking card
                  child: BookingCardTechnician(
                    serialNo: index + 1,
                    booking: bookings[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget _noBookingsView() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today,
            color: Colors.blue,
            size: 60,
          ),
          SizedBox(height: 16),
          Text(
            "No Bookings Available",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Looks like you don't have any bookings for today.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _searchBar(Size screenSize) {
    return Center(
      child: SizedBox(
        width: screenSize.width * 0.9,
        child: Container(
          color: Colors.white,
          child: TextField(
            onSubmitted: (value) {
              // Handle search submission logic here
            },
            decoration: const InputDecoration(
              hintText: "Search for bookings......",
              prefixIcon: Icon(
                Icons.search,
                color: Color(0xFF0000FF),
              ),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }
}
