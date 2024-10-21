import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/Services/Navigation_services.dart';
import '../../models/tecnician_model.dart';

class TechnicianInfoPage extends StatefulWidget {
  final TechnicianProfile technician;

  TechnicianInfoPage({required this.technician});

  @override
  _TechnicianInfoPageState createState() => _TechnicianInfoPageState();
}

class _TechnicianInfoPageState extends State<TechnicianInfoPage> {
  String selectedView = 'availability'; // Toggle between 'availability' and 'reviews'
  int selectedIndex = 0; // 0 for availability, 1 for reviews
  final GetIt _getIt=GetIt.instance;
  late NavigationService _navigationService;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigationService=_getIt.get<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.grey.shade300),
          child: Column(
            children: [
              Center(
                child: ClipRRect(
                  child: Align(
                    alignment: Alignment.topCenter,
                    heightFactor: 0.57,
                    child: Image.network(
                      widget.technician.pfpURL ?? 'https://via.placeholder.com/150',
                      height: 380,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Technician Profile Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30), // Top-left corner radius
                    topRight: Radius.circular(30), // Top-right corner radius
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(height: 3),
                      Row(
                        children: [
                          // Name, Skill, Rating, and Price
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${widget.technician.skill} Services",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.share,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  widget.technician.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.grey[700],
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      width: 325,
                                      child: Text(
                                        "5678 Mango Avenue, Mumbai, Maharashtra, 400001, India",
                                        style: TextStyle(color: Colors.grey[700]),
                                        softWrap: true,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "₹",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text('100/hour',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey[600])),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.solidStar,
                                          color: Colors.yellow[700],
                                          size: 18,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          '${widget.technician.rating} Rating',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey[600]),
                                        ),
                                        SizedBox(width: 10),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedView = 'availability';
                                selectedIndex = 0; // Set selected index for availability
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  "Availability",
                                  style: TextStyle(
                                    color: selectedIndex == 0
                                        ? Colors.blue
                                        : Colors.black, // Change color based on selection
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (selectedIndex == 0) // Show underline when selected
                                  Container(
                                    width: 80,
                                    height: 2,
                                    color: Colors.blue,
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(width: 30),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedView = 'reviews';
                                selectedIndex = 1; // Set selected index for reviews
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  "Reviews",
                                  style: TextStyle(
                                    color: selectedIndex == 1
                                        ? Colors.blue
                                        : Colors.black, // Change color based on selection
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (selectedIndex == 1) // Show underline when selected
                                  Container(
                                    width: 80,
                                    height: 2,
                                    color: Colors.blue,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 2,
                        width: 400,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Show either availability or reviews based on toggle selection
                      selectedView == 'availability'
                          ? _buildAvailabilitySection()
                          : _buildReviewsSection(),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 11),
                      ElevatedButton(
                        onPressed: () {
                          // Handle booking action
                         _navigationService.pushnamed("/bookingpage",arguments: widget.technician);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 60, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text('Book Now',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Build Availability Section
  Widget _buildAvailabilitySection() {
    final now = DateTime.now();
    String currentDay = '';

    switch (now.weekday) {
      case 1:
        currentDay = 'Monday';
        break;
      case 2:
        currentDay = 'Tuesday';
        break;
      case 3:
        currentDay = 'Wednesday';
        break;
      case 4:
        currentDay = 'Thursday';
        break;
      case 5:
        currentDay = 'Friday';
        break;
      case 6:
        currentDay = 'Saturday';
        break;
      case 7:
        currentDay = 'Sunday';
        break;
    }

    if (widget.technician.availability.containsKey(currentDay)) {
      final availableSlots = widget.technician.availability[currentDay]!;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Availability for Today ($currentDay)',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          ...availableSlots.map((slot) {
            String timeSlot = slot.keys.first; // Extract the time slot
            bool isAvailable = slot.values.first; // Extract availability status

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(timeSlot,
                      style: TextStyle(fontSize: 16.0, color: Colors.grey[600])),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: isAvailable ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      isAvailable ? 'Available' : 'Not Available',
                      style: TextStyle(fontSize: 12.0, color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ],
      );
    } else {
      return Text(
        'No Availability for Today ($currentDay)',
        style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.red),
      );
    }
  }

  // Build Reviews Section
  Widget _buildReviewsSection() {
    if (widget.technician.reviews == null || widget.technician.reviews!.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text('No reviews yet.', style: TextStyle(color: Colors.grey,fontSize: 18)),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Customer Reviews',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        ...widget.technician.reviews!.map((review) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(review.reviewerName,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(review.reviewText),
                      SizedBox(height: 4.0),
                      Text(
                        _formatTimestamp(review.timestamp),
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    // Format the timestamp as needed, e.g., "Jan 1, 2023"
    return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }


  void _bookSlot(String slot) {
    // Handle the booking logic
    print("Booking slot: $slot");
  }
}
