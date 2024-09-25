import 'package:profixer/models/tecnician_model.dart';

import 'booking_model.dart';
class UserProfile {
  String uid;
  String name;
  List<TechnicianProfile> cartTechnicians;
  List<Booking>bookings;

  UserProfile({
    required this.uid,
    required this.name,
    this.cartTechnicians = const [],
    this.bookings=const [],
  });

  // Factory method to create a UserProfile from a JSON object
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    var techniciansList = (json['cartTechnicians'] as List<dynamic>?)?.map((item) {
      return TechnicianProfile.fromJson(item as Map<String, dynamic>);
    }).toList() ?? [];

    var bookingList=(json['bookings'] as List<dynamic>?)?.map((item){
      return Booking.fromJson(item as Map<String,dynamic>);
    }).toList()?? [];

    return UserProfile(
      uid: json['uid'] ?? '', // Default to empty string if null
      name: json['name'] ?? '', // Default to empty string if null
      cartTechnicians: techniciansList,
      bookings: bookingList,
    );
  }

  // Method to convert a UserProfile to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'cartTechnicians': cartTechnicians.map((t) => t.toJson()).toList(),
      'bookings':bookings,
    };
  }

}
