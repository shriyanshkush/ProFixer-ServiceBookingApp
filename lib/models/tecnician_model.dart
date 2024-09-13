
class TechnicianProfile {
  String tid;
  String name;
  String phoneNumber;
  String skill;
  double rating;
  String? pfpURL;
  String? govtID;
  String? proofOfWork;
  final Map<String, List<String>> availability;

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
  });

  // Factory method to create a TechnicianProfile from a JSON object
  factory TechnicianProfile.fromJson(Map<String, dynamic> json) {
    // Convert the dynamic map to a typed map
    final availabilityMap = (json['availability'] as Map<String, dynamic>).map(
          (key, value) {
        return MapEntry(
          key,
          (value as List<dynamic>).map((e) => e as String).toList(),
        );
      },
    );

    return TechnicianProfile(
      tid: json['tid'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      skill: json['skill'],
      rating: (json['rating'] as num).toDouble(),
      pfpURL: json['pfpURL'],
      govtID: json['govtID'],
      proofOfWork: json['proofOfWork'],
      availability: availabilityMap,
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
    };
  }
}
