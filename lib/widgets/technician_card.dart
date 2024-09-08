import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:profixer/models/tecnician_model.dart';

class TechnicianCard extends StatelessWidget {
  final TechnicianProfile technician;

  TechnicianCard({super.key, required this.technician});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
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
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              color: Colors.blue,
              child: Image.network(
                technician.pfpURL!,
                width: 60,
                height: 80,
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
                Text(
                  technician.name,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  technician.skill,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Text(
                      "Rs. 100",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.solidStar,
                          color: Colors.yellow[600],
                          size: 16.0,
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          '${technician.rating} (100 Reviews)',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Bookmark Icon
          IconButton(onPressed: (){},
            icon: Icon(
            FontAwesomeIcons.solidBookmark,
            color: Colors.blue,
          ),)
        ],
      ),
    );
  }
}