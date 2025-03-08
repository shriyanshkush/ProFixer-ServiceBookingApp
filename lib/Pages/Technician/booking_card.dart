import 'package:flutter/material.dart';
import '../../models/booking_model.dart';

class BookingCardTechnician extends StatefulWidget {
  final Booking booking;
  final int serialNo;

  const BookingCardTechnician({
    Key? key,
    required this.booking,
    required this.serialNo,
  }) : super(key: key);

  @override
  _BookingCardState createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCardTechnician> {
  late bool workStatus;

  @override
  void initState() {
    super.initState();
    workStatus = widget.booking.workStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.blue.shade300,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Booking -#${widget.serialNo}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                SizedBox(height: 10),
                _buildRow(Icons.assignment, "Booking ID: ", widget.booking.BookingId),
                SizedBox(height: 5),
                _buildRow(Icons.person_outline, "User: ", widget.booking.name),
                SizedBox(height: 5),
                _buildRow(Icons.schedule, "Time Slot: ", widget.booking.timeSlot),
                SizedBox(height: 5),
                _buildRow(Icons.calendar_month, "Date: ", widget.booking.bookingDate.toString()),
                SizedBox(height: 5),
                _buildRow(Icons.home, "Address: ", widget.booking.homeAddress),
                SizedBox(height: 5),
                _buildRow(Icons.phone, "Phone: ", widget.booking.phoneNumber),
                SizedBox(height: 5),
                _buildRow(Icons.message, "Instructions: ", widget.booking.specialInstructions),
                ListTile(
                  title: Text(
                    widget.booking.workStatus ? "Work Done" : "Work Status",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: workStatus ? Colors.green : Colors.red,
                    ),
                  ),
                  trailing: Transform.scale(
                    scale: 0.6,
                    child: Switch(
                      value: workStatus,
                      onChanged: (value) {
                        setState(() {
                          workStatus = value;
                          // Optionally, update the backend here when the status is changed
                        });
                      },
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue),
        SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold, // Make the label bold
            color: Colors.black,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ),
      ],
    );
  }
}
