import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String imagepath;
  final String service;
  final VoidCallback onTap; // Corrected the function parameter type

  const ServiceCard({
    super.key,
    required this.imagepath,
    required this.service,
    required this.onTap, // Mark it as required so that an onTap function is passed
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Calls the passed onTap function when tapped
      child: Column(
        children: [
          Container(
            height: 73,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.black12,
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0), // Match the Container's borderRadius
                child: Image.asset(
                  imagepath,
                  fit: BoxFit.cover, // Ensures the image covers the entire area of the container
                ),
              ),
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            service,
            style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
