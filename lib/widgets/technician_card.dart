import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/Services/auth_services.dart';
import 'package:profixer/Services/database_services.dart';
import '../models/tecnician_model.dart';

class TechnicianCard extends StatefulWidget {
  final TechnicianProfile technicianProfile;

  const TechnicianCard({
    super.key,
    required this.technicianProfile,
  });

  @override
  _TechnicianCardState createState() => _TechnicianCardState();
}

class _TechnicianCardState extends State<TechnicianCard> {
  bool _isBookmarked = false; // Track the bookmark state
  final GetIt _getIt = GetIt.instance;
  late AuthServices _authServices;
  late DatabaseServices _databaseServices;

  @override
  void initState() {
    super.initState();
    _authServices = _getIt.get<AuthServices>();
    _databaseServices = _getIt.get<DatabaseServices>();

    _updateBookmarkStatus();
  }

  void _updateBookmarkStatus() async {
    final isBookmarked = await _databaseServices.isTechnicianInCart(
        _authServices.user!.uid, widget.technicianProfile.tid);
    setState(() {
      _isBookmarked = isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      child: Row(
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
                widget.technicianProfile.pfpURL!,
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
                          widget.technicianProfile.name,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.technicianProfile.skill,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        if (_isBookmarked) {
                          _databaseServices.remooveTechniciansfromtCart(
                              _authServices.user!.uid, widget.technicianProfile.tid);
                        } else {
                          _databaseServices.addTechnicianstoCart(
                              _authServices.user!.uid, widget.technicianProfile.tid);
                        }
                        setState(() {
                          _isBookmarked = !_isBookmarked; // Toggle the bookmark state
                        });
                      },
                      icon: Icon(
                        _isBookmarked ? FontAwesomeIcons.solidBookmark : FontAwesomeIcons.bookmark,
                        color: Colors.blue,
                      ),
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
                                '${widget.technicianProfile.rating}', // Dynamic value
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
    );
  }
}
