import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/Services/auth_services.dart';
import 'package:profixer/Services/database_services.dart';
import '../../models/booking_model.dart';
import '../../widgets/booking_card.dart'; // Ensure this import points to the correct path of your BookingCard widget

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
    final bookings = await _databaseServices.getBookingList(_authServices.user!.uid);
    //print(jsonDecode(bookings));
    setState(() {
      bookingList = bookings;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Bookings '),
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
          return BookingCard(
            booking: booking,
            serialNo: index + 1, // Pass the serial number (index + 1)
          );
        },
      ),
    );
  }
}
