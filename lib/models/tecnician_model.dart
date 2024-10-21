import '../../models/review_model.dart';
import 'booking_model.dart';

class TechnicianProfile {
  String tid;
  String name;
  String phoneNumber;
  String skill;
  double rating;
  String? pfpURL;
  String? govtID;
  String? proofOfWork;
  final Map<String, List<Map<String, bool>>> availability;
  List<Review> reviews; // Changed to a non-nullable list with a default value
  List<Booking> bookings;
  String verificationStatus;

  TechnicianProfile({
    required this.tid,
    required this.name,
    required this.phoneNumber,
    required this.skill,
    required this.rating,
    this.pfpURL,
    this.govtID,
    this.proofOfWork,
    required this.availability,
    this.reviews = const [], // Default to an empty list
    this.bookings=const [],
    this.verificationStatus= "Pending",
  });

  // Factory method to create a TechnicianProfile from a JSON object
  factory TechnicianProfile.fromJson(Map<String, dynamic> json) {
    // Handling availability parsing
    final availabilityMap = (json['availability'] as Map<String, dynamic>? ?? {}).map(
          (day, value) {
        return MapEntry(
          day,
          (value as List<dynamic>).map((timeSlot) {
            // Assuming timeSlot is a Map<String, bool>
            return (timeSlot as Map<String, dynamic>).map(
                  (key, val) => MapEntry(key, val as bool),
            );
          }).toList(),
        );
      },
    );
    var bookingList=(json['bookings'] as List<dynamic>?)?.map((item){
      return Booking.fromJson(item as Map<String,dynamic>);
    }).toList()?? [];

    // Parse other fields with null checks and default values where necessary
    return TechnicianProfile(
      tid: json['tid'] ?? '', // Default to empty string if null
      name: json['name'] ?? '', // Default to empty string if null
      phoneNumber: json['phoneNumber'] ?? '', // Default to empty string if null
      skill: json['skill'] ?? '', // Default to empty string if null
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0, // Default rating to 0.0 if null
      pfpURL: json['pfpURL'], // Nullable
      govtID: json['govtID'], // Nullable
      proofOfWork: json['proofOfWork'], // Nullable
      availability: availabilityMap, // Parsed from above
      reviews: (json['reviews'] as List<dynamic>? ?? [])
          .map((review) => Review.fromJson(review))
          .toList(), // Default to empty list if null
      bookings: bookingList,
      verificationStatus: json['verificationStatus'],
    );
  }

  // Method to convert a TechnicianProfile to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'tid': tid,
      'name': name,
      'phoneNumber': phoneNumber,
      'skill': skill,
      'rating': rating,
      'pfpURL': pfpURL,
      'govtID': govtID,
      'proofOfWork': proofOfWork,
      'availability': availability.map(
            (key, value) {
          return MapEntry(key, value);
        },
      ),
      'reviews': reviews.map((review) {
        return {
          'reviewerName': review.reviewerName,
          'reviewText': review.reviewText,
          'timestamp': review.timestamp.toIso8601String(), // Convert timestamp to string
        };
      }).toList(), // Convert reviews to JSON if not null
      'bookings':bookings.map((booking) => booking.toJson()).toList(),
    'verificationStatus':verificationStatus,
    };
  }
}
