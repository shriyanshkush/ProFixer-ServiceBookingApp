
class TechnicianProfile {
  String tid;
  String name;
  String phoneNumber;
  String skill;
  double rating;
  String? pfpURL;
  String? govtID;
  String? proofOfWork;
  final Map<String,List<String>>availability;

  TechnicianProfile({
    required this.tid,
    required this.name,
    required this.phoneNumber,
    required this.skill,
    required this.rating,
    required this.pfpURL,
    required this.govtID,
    required this.proofOfWork,
    required this.availability,
  });

  // Factory method to create a Technician from a JSON object
  factory TechnicianProfile.fromJson(Map<String, dynamic> json) {
    return TechnicianProfile(
      tid: json['tid'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      skill: json['skill'],
      rating: json['rating'].toDouble(),
      pfpURL: json['pfpURL'],
      govtID: json['govtID'],
        proofOfWork: json['proofOfWork'],
      availability: json['availability'],
    );
  }

  // Method to convert a Technician to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'tid': tid,
      'name': name,
      'phoneNumber': phoneNumber,
      'skill': skill,
      'rating': rating,
      'pfpURL':pfpURL,
      'govtID':govtID,
      'proofOfWork':proofOfWork,
      'availability':availability,
    };
  }
}
