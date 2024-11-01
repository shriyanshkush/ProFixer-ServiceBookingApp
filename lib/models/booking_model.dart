import 'package:profixer/models/tecnician_model.dart';
import 'package:profixer/models/payment_model.dart';

class Booking {
  final String BookingId;
  final String userId;
  final String name;
  final TechnicianProfile technician;
  final String timeSlot;
  final DateTime bookingDate;
  final bool isConfirmed;
  final String homeAddress;
  final String phoneNumber;
  final String specialInstructions;
  final bool workStatus;
  final Payment? payment;


  Booking({
    required this.BookingId,
    required this.userId,
    required this.name,
    required this.technician,
    required this.timeSlot,
    required this.bookingDate,
    required this.isConfirmed,
    required this.homeAddress,
    required this.phoneNumber,
    required this.specialInstructions,
    this.workStatus=false,
    required this.payment,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      userId: json['userId'],
      BookingId: json['BookingId'],
      name: json['name'],
      technician: TechnicianProfile.fromJson(json['technician']),
      timeSlot: json['timeSlot'],
      bookingDate: DateTime.parse(json['bookingDate']),
      isConfirmed: json['isConfirmed'],
      homeAddress: json['homeAddress'],
      phoneNumber: json['phoneNumber'],
      specialInstructions: json['specialInstructions'],
      workStatus: json['workStatus'],
      payment: json['payment'] !=null ?Payment.fromJson(json['payment']):null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId':userId,
      'BookingId':BookingId,
      'name':name,
      'technician': technician.toJson(),
      'timeSlot': timeSlot,
      'bookingDate': bookingDate.toIso8601String(),
      'isConfirmed': isConfirmed,
      'homeAddress': homeAddress,
      'phoneNumber': phoneNumber,
      'specialInstructions': specialInstructions,
      'workStatus':workStatus,
      'payment':payment?.toJson(),
    };
  }
}