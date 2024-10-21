import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:profixer/models/tecnician_model.dart';
import 'package:profixer/models/booking_model.dart'; // Ensure this import points to the correct path

class BookingCard extends StatelessWidget {
  final Booking booking;
  final int serialNo;

  const BookingCard({
    super.key,
    required this.booking,
    required this.serialNo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display serial number and booking ID at the top
            Center(child: _buildSerialAndID(serialNo, booking.BookingId)),
            SizedBox(height: 16),
            _buildTechnicianInfo(booking.technician), // Custom implementation
            SizedBox(height: 16),
            // Booking Info section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
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
                  _buildInfoRow(FontAwesomeIcons.circleInfo, 'Status of Work:', booking.workStatus?"Completed":"On going"),
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
        SizedBox(height: 5),
        Text(
          'ID: $bookingID',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // Custom method to display technician info without the "Add to Cart" button
  Widget _buildTechnicianInfo(TechnicianProfile technician) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16.0,left: 16.0,right: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue.shade100),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Center(child: _buildSectionTitle('Technician Info')),
          Row(
            children: [
              // Technician Image
              Container(
                padding: EdgeInsets.all(1.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    booking.technician.pfpURL!,
                    width: 80,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16.0),
              // Technician Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking.technician.name,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              booking.technician.skill,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12.0),
                    // Charges, Rating, and Reviews with Vertical Line
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Charge',
                                style: TextStyle(fontSize: 12.0, color: Colors.grey, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Rs. 100', // Dynamic value
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1.0, // Width of the vertical line
                          height: 40.0, // Adjust height as needed
                          color: Colors.grey[300], // Color of the line
                          margin: EdgeInsets.symmetric(horizontal: 16.0), // Spacing around the line
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rating',
                                style: TextStyle(fontSize: 12.0, color: Colors.grey, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.solidStar,
                                    color: Colors.yellow[500],
                                    size: 12.0,
                                  ),
                                  SizedBox(width: 4.0),
                                  Text(
                                    '${booking.technician.rating}', // Dynamic value
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1.0, // Width of the vertical line
                          height: 40.0, // Adjust height as needed
                          color: Colors.grey[300], // Color of the line
                          margin: EdgeInsets.symmetric(horizontal: 16.0), // Spacing around the line
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Reviews',
                                style: TextStyle(fontSize: 12.0, color: Colors.grey, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '100', // Dynamic value
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
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
