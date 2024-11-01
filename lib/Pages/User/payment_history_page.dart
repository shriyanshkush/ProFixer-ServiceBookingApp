import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../Services/Navigation_services.dart';
import '../../Services/auth_services.dart';
import '../../Services/database_services.dart';
import '../../models/booking_model.dart';
import '../../widgets/payment_card.dart';

class PaymentHistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PaymentHistoryPageState();
  }
}

class PaymentHistoryPageState extends State<PaymentHistoryPage> {
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
    setState(() {
      bookingList = bookings;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment History"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : bookingList.isEmpty
          ? Center(child: Text("No Bookings"))
          : ListView.builder(
        itemCount: bookingList.length,
        itemBuilder: (context, index) {
          final booking = bookingList[index];
          return PaymentCard(
            index: index,
            payment: booking.payment!,
            bookingId: booking.BookingId, // Corrected property name
            userId: booking.userId,
            technicianId: booking.technician.tid,
          );
        },
      ),
    );
  }
}
