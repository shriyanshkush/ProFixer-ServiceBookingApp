
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/Pages/User/technicianInfo.dart';
import 'package:profixer/Services/Alert_services.dart';
import 'package:profixer/Services/Navigation_services.dart';
import 'package:profixer/Services/auth_services.dart';
import 'package:profixer/Services/database_services.dart';
import 'package:profixer/Services/stripe_services.dart';
import 'package:profixer/models/payment_model.dart';
import 'package:profixer/widgets/technician_card.dart';
import 'package:uuid/uuid.dart';
import '../../models/booking_model.dart';
import '../../models/tecnician_model.dart';

class BookingForm extends StatefulWidget {
  final TechnicianProfile technician;

  BookingForm({required this.technician});

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  final DateTime today = DateTime.now();
  final GetIt _getIt=GetIt.instance;
  late DatabaseServices _databaseServices;
  late AlertServices _alertServices;
  late AuthServices _authServices;
  late NavigationService _navigationService;
  late StripeServices _stripeServices;
  String? _selectedTimeSlot;
  DateTime _bookingDate = DateTime.now();
  bool _isConfirmed = false;
  String _homeAddress = '';
  String _phoneNumber = '';
  String _specialInstructions = '';
  String _name ='';
  bool _isLoading=false;


  List<String> availableTimeSlots = [];

  @override
  void initState() {
    super.initState();
    _databaseServices = _getIt.get<DatabaseServices>();
    _alertServices=_getIt.get<AlertServices>();
    _navigationService=_getIt.get<NavigationService>();
    _authServices=_getIt.get<AuthServices>();
    _stripeServices=_getIt.get<StripeServices>();
    _setAvailableTimeSlots();
  }

  void _setAvailableTimeSlots() {
    // Fetch today's weekday name (e.g., "Monday", "Tuesday", etc.)
    String weekdayName = _getDayName(today.weekday);

    // Fetch available time slots for the current day
    if (widget.technician.availability.containsKey(weekdayName)) {
      availableTimeSlots = widget.technician.availability[weekdayName]!
          .where((slot) => slot.values.first == true) // Get only available slots
          .map((slot) => slot.keys.first)
          .toList();
    }
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Technician Description
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade100),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    _technicianDescriptioncard(),
                  ],
                ),
              ),
              SizedBox(height: 20.0),

              // Enter Booking Details
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade100),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'Enter Booking Details',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15.0),

                    // Time Slot Dropdown
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Select Time Slot',
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedTimeSlot,
                      items: availableTimeSlots.map((slot) {
                        return DropdownMenuItem(
                          value: slot,
                          child: Text(slot),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedTimeSlot = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a time slot';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15.0),
                    // Booking Date
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Booking Date',
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                      controller: TextEditingController(
                        text: "${_bookingDate.toLocal()}".split(' ')[0],
                      ),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _bookingDate,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );
                        if (date != null) {
                          setState(() {
                            _bookingDate = date;
                            _setAvailableTimeSlots(); // Update available slots based on the new date
                          });
                        }
                      },
                      validator: (value) {
                        if (_bookingDate == null) {
                          return 'Please select a booking date';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15.0),
                    // User name
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onSaved: (value) => _name = value!,
                    ),
                    SizedBox(height: 15.0),
                    // Home Address
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Home Address',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter home address';
                        }
                        return null;
                      },
                      onSaved: (value) => _homeAddress = value!,
                    ),
                    SizedBox(height: 15.0),

                    // Phone Number
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter phone number';
                        }
                        return null;
                      },
                      onSaved: (value) => _phoneNumber = value!,
                    ),
                    SizedBox(height: 15.0),

                    // Special Instructions
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Special Instructions',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) => _specialInstructions = value!,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),

              // Payment Summary
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade100),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'Payment Summary',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Payment: ₹100/hour',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),

              // Checkout Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Updated from 'backgroundColor' to 'primary'
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                  onPressed: () async {
                    final bookingId = '${DateTime.now().millisecondsSinceEpoch}';
                    Payment? payment= await _stripeServices.makePayments(100);
                    if (_formKey.currentState!.validate() && payment!=null) {
                      _formKey.currentState!.save();

                      setState(() {
                        _isLoading = true; // Show a loading indicator while saving
                      });
                      _isConfirmed = true;
                      final booking = Booking(
                        userId: _authServices.user!.uid,
                        BookingId: bookingId,
                        name: _name,
                        technician: widget.technician,
                        timeSlot: _selectedTimeSlot!,
                        bookingDate: _bookingDate,
                        isConfirmed: _isConfirmed,
                        homeAddress: _homeAddress,
                        phoneNumber: _phoneNumber,
                        specialInstructions: _specialInstructions,
                        payment:payment,
                      );

                      try {
                        // Save the booking to your database or API
                        await _databaseServices.addbookingtouser(_authServices.user!.uid,widget.technician.tid ,booking);

                        // Update the technician's availability
                        _updateTechnicianAvailability();

                        // Show success message
                        _alertServices.showToast(
                          text: "Booking completed successfully!",
                          icon: Icons.check_circle,
                        );

                        _navigationService.pushnamed("/userhome");
                      } catch (e) {
                        // Show an error message if something goes wrong
                        _alertServices.showToast(
                          text: "Failed to complete booking. Please try again.",
                          icon: Icons.error,
                        );
                      } finally {
                        setState(() {
                          _isLoading = false; // Hide the loading indicator
                        });
                      }
                    } else {
                      _alertServices.showToast(
                        text: "Please complete all required fields.",
                        icon: Icons.error,
                      );
                    }
                  },
                child: _isLoading?(CircularProgressIndicator()):Text('Confirm Booking',style: TextStyle(color: Colors.white,fontSize: 18),),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _technicianDescriptioncard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
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
          Text(
            'Technician Description',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
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
                    widget.technician.pfpURL!,
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
                              widget.technician.name,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.technician.skill,
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
                                    '${widget.technician.rating}', // Dynamic value
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

  void _updateTechnicianAvailability() async {
    // Get the day of the week (e.g., "Monday")
    String dayName = _getDayName(_bookingDate.weekday);

    // Find the selected time slot and mark it as unavailable
    if (widget.technician.availability.containsKey(dayName)) {
      widget.technician.availability[dayName] = widget.technician.availability[dayName]!
          .map((slot) => slot.keys.first == _selectedTimeSlot
          ? {slot.keys.first: false}  // Mark as unavailable
          : slot)
          .toList();
    }

    // Update the technician's availability in the database
    await _databaseServices.updateTechnicianAvailability(
      technicianId: widget.technician.tid,
      availability: widget.technician.availability,
    );
  }

}
