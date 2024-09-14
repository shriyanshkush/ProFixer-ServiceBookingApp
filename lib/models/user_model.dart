import '../../models/tecnician_model.dart';
class UserProfile {
  String uid;
  String name;
  List<TechnicianProfile>cartTechnicians;
  //String email;
  //String phoneNumber;
  //String? pfpURL;

  UserProfile({
    required this.uid,
    required this.name,
    this.cartTechnicians=const [],
    //required this.email,
    //required this.phoneNumber,
    //required this.pfpURL,
  });

  // Factory method to create a User from a JSON object
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    var techniciansList = (json['cartTechnicians'] as List)
        ?.map((item) => TechnicianProfile.fromJson(item))
        ?.toList() ?? [];

    return UserProfile(
      uid: json['uid'],
      name: json['name'],
      cartTechnicians: techniciansList,
      //email: json['email'],
      //phoneNumber: json['phoneNumber'],
      //pfpURL: json['pfpURL']
    );
  }

  // Method to convert a User to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'cartTechnicians' :cartTechnicians.map((t) => t.toJson()).toList(),
      //'email': email,
      //'phoneNumber': phoneNumber,
      //'pfpURL':pfpURL,
    };
  }

  // Method to add a technician to the cart
  void addTechnicianToCart(TechnicianProfile technician) {
    cartTechnicians.add(technician);
  }

  // Method to remove a technician from the cart
  void removeTechnicianFromCart(String technicianId) {
    cartTechnicians.removeWhere((t) => t.tid == technicianId);
  }
}
