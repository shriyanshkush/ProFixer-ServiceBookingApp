import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/Services/auth_services.dart';
import 'package:profixer/Services/database_services.dart';
import '../../models/booking_model.dart';

class ShowBookings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ShowBookingsState();
  }
}

class ShowBookingsState extends State<ShowBookings> {
  List<Booking> bookingList = [];
  final GetIt _getIt = GetIt.instance;
  late AuthServices _authServices;
  late DatabaseServices _databaseServices;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _databaseServices = _getIt.get<DatabaseServices>();
    _authServices = _getIt.get<AuthServices>();
    getBookingList();
  }

  Future<void> getBookingList() async {
    setState(() {
      isLoading = true;
    });
    final booking = await _databaseServices.getBookingList(_authServices.user!.uid);
    setState(() {
      bookingList = booking;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : bookingList.isEmpty
          ? Center(child: Text('No bookings available.'))
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: bookingList.length,
        itemBuilder: (context, index) {
          final booking = bookingList[index];
          return _buildBookingCard(booking, index + 1);  // Pass the serial number (index + 1)
        },
      ),
    );
  }

  Widget _buildBookingCard(Booking booking, int serialNo) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display serial number and booking ID at the top
            _buildSerialAndID(serialNo, booking.BookingId),
            SizedBox(height: 16),
            // Technician Info section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue.shade100),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  _buildSectionTitle('Technician Info'),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(booking.technician.pfpURL!),
                    ),
                    title: Text(booking.technician.name),
                    subtitle: Text('Rating: ${booking.technician.rating.toString()}'),
                    trailing: booking.isConfirmed
                        ? Icon(FontAwesomeIcons.solidCheckCircle, color: Colors.green)
                        : Icon(FontAwesomeIcons.clock, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Booking Info section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue.shade100),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  _buildSectionTitle('Booking Info'),
                  _buildInfoRow(Icons.calendar_today, 'Date:', booking.bookingDate.toLocal().toString().split(' ')[0]),
                  _buildInfoRow(Icons.access_time, 'Time Slot:', booking.timeSlot),
                  _buildInfoRow(Icons.location_on, 'Address:', booking.homeAddress),
                  _buildInfoRow(Icons.phone, 'Phone:', booking.phoneNumber),
                  _buildInfoRow(Icons.notes, 'Special Instructions:', booking.specialInstructions),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build the serial number and booking ID display
  Widget _buildSerialAndID(int serialNo, String bookingID) {
    return Column(
      children: [
        Text(
          'Booking #${serialNo.toString().length > 22 ? serialNo.toString().substring(0, 22) : serialNo}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 5,),
        Text(
          'ID: $bookingID',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          SizedBox(width: 8),
          Text(
            '$label ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value, style: TextStyle(color: Colors.black54)),
          ),
        ],
      ),
    );
  }
}
