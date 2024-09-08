class UserProfile {
  String uid;
  String name;
  //String email;
  //String phoneNumber;
  //String? pfpURL;

  UserProfile({
    required this.uid,
    required this.name,
    //required this.email,
    //required this.phoneNumber,
    //required this.pfpURL,
  });

  // Factory method to create a User from a JSON object
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      uid: json['uid'],
      name: json['name'],
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
      //'email': email,
      //'phoneNumber': phoneNumber,
      //'pfpURL':pfpURL,
    };
  }
}
