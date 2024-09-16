import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/tecnician_model.dart';

class TechnicianInfoPage extends StatelessWidget {
  final TechnicianProfile technician;

  TechnicianInfoPage({required this.technician});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${technician.name} - ${technician.skill}'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Technician Profile Image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    technician.pfpURL ?? 'https://via.placeholder.com/150',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              // Technician Name and Skill
              Text(
                technician.name,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                technician.skill,
                style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
              ),
              SizedBox(height: 16.0),
              // Rating and Phone Number
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.star,
                    color: Colors.yellow[700],
                    size: 18.0,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    '${technician.rating} Rating',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Spacer(),
                  Icon(
                    FontAwesomeIcons.phone,
                    color: Colors.blue,
                    size: 18.0,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    technician.phoneNumber,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              // Availability
              Text(
                'Availability',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              ...technician.availability.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        entry.key,
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        entry.value.join(', '),
                        style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                );
              }).toList(),
              SizedBox(height: 16.0),
              // Booking Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle booking action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                    textStyle: TextStyle(fontSize: 18.0),
                  ),
                  child: Text('Book Now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
