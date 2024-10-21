import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/Services/auth_services.dart';
import 'package:profixer/models/booking_model.dart';
import 'package:profixer/models/tecnician_model.dart';
import 'package:profixer/models/user_model.dart';


class DatabaseServices{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  CollectionReference? _usercollection;
  CollectionReference? _techniciancollection;

  DatabaseServices(){
    setupCollectionReference();
  }

  void setupCollectionReference() {
    _usercollection=_firestore.collection("users").withConverter<UserProfile>(
        fromFirestore: (snapshots,_) => UserProfile.fromJson(snapshots.data()!),
        toFirestore: (userProfile,_)=>userProfile.toJson());

    _techniciancollection=_firestore.collection("technicians").withConverter<TechnicianProfile>
      (fromFirestore: (snapshots,_)=>TechnicianProfile.fromJson(snapshots.data()!),
        toFirestore: (technicianprofile,_)=>technicianprofile.toJson());

  }

  Future <void> createUserProfile({required UserProfile userProfile}) async{
    await _usercollection?.doc(userProfile.uid).set(userProfile);
  }

  Future<void> createTechnicianProfile({required TechnicianProfile technician}) async{
    await _techniciancollection?.doc(technician.tid).set(technician);
  }

  Future<bool> decideUser(String userId) async{
    final techniciandoc =await _techniciancollection?.doc(userId).get();
    if(techniciandoc!=null && techniciandoc.exists) {
      return true;
    } else{
      return false;
    }
  }

  // Fetch all technicians with verificationStatus = "Pending"
  Future<List<TechnicianProfile>> fetchPendingTechnicians() async {
    try {
      final querySnapshot = await _firestore
          .collection('technicians') // Replace with your collection name
          .where('verificationStatus', isEqualTo: 'Pending') // Filter for pending status
          .get();

      if (querySnapshot == null || querySnapshot.docs.isEmpty) {
        print('No pending technicians found');
        return [];
      }

      print('Query snapshot: ${querySnapshot.docs.length} documents');
      final List<TechnicianProfile> pendingTechnicians = querySnapshot.docs
          .map((doc) => TechnicianProfile.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      print('Technicians: $pendingTechnicians');

      return pendingTechnicians;
    } catch (e) {
      print('Error fetching pending technicians: $e');
      return [];
    }
  }

  void approveTechnician(String technicianID) async {
    await _techniciancollection?.doc(technicianID).update({
      'verificationStatus': 'aprooved', // Directly update the field with 'approved' status
    }).then((_) {
      print('Technician approved successfully');
    }).catchError((error) {
      print('Failed to approve technician: $error');
    });
  }

  void rejectTechnician(String technicianID) async {
    await _techniciancollection?.doc(technicianID).update({
      'verificationStatus': 'reject', // Directly update the field with 'approved' status
    }).then((_) {
      print('Technician rejected successfully');
    }).catchError((error) {
      print('Failed to reject technician: $error');
    });
  }

  Future<TechnicianProfile> getCurrentTechnician(String technicianId) async {
    // Fetch the document from Firestore
    final techdocSnapshot = await _techniciancollection?.doc(technicianId).get();

    // Check if the document exists
    if (techdocSnapshot != null && techdocSnapshot.exists) {
      // Extract the data from the snapshot
      final TechnicianProfile technicianProfile = techdocSnapshot.data() as TechnicianProfile;
      return technicianProfile;
    } else {
      throw Exception("Technician data not found");
    }
  }

  Future<UserProfile> getCurrentUser(String userId) async {
    // Fetch the document from Firestore
    final userdocSnapshot = await _usercollection?.doc(userId).get();

    // Check if the document exists
    if (userdocSnapshot != null && userdocSnapshot.exists) {
      // Extract the data from the snapshot
      final UserProfile userProfile = userdocSnapshot.data() as UserProfile;
      return userProfile;
    } else {
      throw Exception("User data not found");
    }
  }



  Future<List<TechnicianProfile>> getTechniciansBySkill(String skill) async {
    try {
      print('Searching for technicians with skill: $skill');
      final querySnapshot = await _techniciancollection
          ?.where('skill', isEqualTo: skill)
      .where('verificationStatus',isEqualTo: "aprooved")
          .get();

      if (querySnapshot == null) {
        print('Query snapshot is null');
        return [];
      }

      print('Query snapshot: ${querySnapshot.docs.length} documents');
      final List<TechnicianProfile> technicians = querySnapshot.docs
          .map((doc) => doc.data() as TechnicianProfile)
          .toList();

      print('Technicians: $technicians');
      return technicians;
    } catch (e) {
      print('Error retrieving technicians: $e');
      return [];
    }
  }

  Future<List<TechnicianProfile>> getTopTechniciansByService() async {
    try {
      // Fetch all approved technicians
      final querySnapshot = await _techniciancollection
          ?.where('verificationStatus', isEqualTo: 'aprooved')
          .get();

      if (querySnapshot == null || querySnapshot.docs.isEmpty) {
        print('No approved technicians found');
        return [];
      }

      // Create a map to store the highest-rated technician for each service
      Map<String, TechnicianProfile> topTechniciansByService = {};

      // Iterate through the technicians
      for (var doc in querySnapshot.docs) {
        final technician = doc.data() as TechnicianProfile;

        // Check if this service already has a technician
        if (topTechniciansByService.containsKey(technician.skill)) {
          // Compare the ratings and replace if the current technician has a higher rating
          if (technician.rating > topTechniciansByService[technician.skill]!.rating) {
            topTechniciansByService[technician.skill] = technician;
          }
        } else {
          // Add the first technician for this service
          topTechniciansByService[technician.skill] = technician;
        }
      }

      // Convert the map to a list of technicians
      List<TechnicianProfile> topTechnicians = topTechniciansByService.values.toList();

      print('Top technicians by service: $topTechnicians');

      return topTechnicians;
    } catch (e) {
      print('Error fetching top technicians by service: $e');
      return [];
    }
  }


  Future<void> addTechnicianstoCart(String userId, TechnicianProfile technician) async {
    try {
      final userDoc = await _usercollection?.doc(userId).get();

      if (userDoc == null) {
        print('User document not found');
        return; // or handle this scenario as needed
      }
      await _usercollection?.doc(userId).update({
        'cartTechnicians': FieldValue.arrayUnion([technician.toJson()])
      });
    } catch (e) {
      print('Error adding technician to cart: $e');
    }
  }

  Future<void> remooveTechniciansfromtCart(String userId, TechnicianProfile technician) async {
    try {
      await _usercollection?.doc(userId).update({
        'cartTechnicians': FieldValue.arrayRemove([technician.toJson()])
      });
    } catch (e) {
      print('Error remooving technician to cart: $e');
    }
  }

  Future<bool> isTechnicianInCart(String userId, String technicianID) async {
    try {
      final userDoc = await _usercollection?.doc(userId).get();

      if (userDoc == null || !userDoc.exists) return false;

      // Retrieve the UserProfile instance from the document
      final userProfile = userDoc.data() as UserProfile?;

      if (userProfile == null) return false;

      // Check if the cartTechnicians list contains the technician ID
      final List<dynamic> cartTechnicians = userProfile.cartTechnicians;

      return cartTechnicians.any((technician)=>technician.tid==technicianID); // Check for technician ID as String
    } catch (e) {
      print('Error checking technician in cart: $e');
      return false;
    }
  }

  Future<List<TechnicianProfile>> getCartTechnicians(String userID) async {
    try {
      final userDoc = await _usercollection?.doc(userID).get();

      if (userDoc == null || !userDoc.exists) {
        return [];
      }

      final userProfile = userDoc.data() as UserProfile?;

      if (userProfile == null) {
        return [];
      }

      final List<TechnicianProfile>? cartTechniciansData = userProfile.cartTechnicians;

      if (cartTechniciansData == null) {
        return [];
      }

      final List<TechnicianProfile> cartTechnicians = cartTechniciansData
          .map((technicianData) => technicianData)
          .toList();

      return cartTechnicians;
    } catch (e) {
      print('Error fetching cart technicians: $e');
      return [];
    }
  }

  //Updating Availability after booking
  Future<void> updateTechnicianAvailability({
    required String technicianId,
    required Map<String, List<Map<String, bool>>> availability,
  }) async {
    // Assuming Firestore or another backend
    await FirebaseFirestore.instance
        .collection('technicians')
        .doc(technicianId)
        .update({'availability': availability});
  }

  //Implement booking backend
  Future<void> addbookingtouser(String userId,String technicianId, Booking booking) async {
    try {
      final userDoc = await _usercollection?.doc(userId).get();
      final technicianDoc = await _techniciancollection?.doc(technicianId).get();

      if (userDoc == null) {
        print('User document not found');
        return; // or handle this scenario as needed
      }
      if (technicianDoc == null) {
        print('Technician document not found');
        return; // or handle this scenario as needed
      }
      await _usercollection?.doc(userId).update({
        'bookings': FieldValue.arrayUnion([booking.toJson()])
      });
      await _techniciancollection?.doc(technicianId).update({
        'bookings': FieldValue.arrayUnion([booking.toJson()])
      });
    } catch (e) {
      print('Error adding booking : $e');
    }
  }

  Future<List<Booking>> getBookingList(String userID) async {
    try {
      final userDoc = await _usercollection?.doc(userID).get();

      if (userDoc == null || !userDoc.exists) {
        return [];
      }

      final userProfile = userDoc.data() as UserProfile?;

      if (userProfile == null) {
        return [];
      }

      final List<Booking>? bookingsData = userProfile.bookings;

      if (bookingsData == null) {
        return [];
      }

      final List<Booking> bookings = bookingsData
          .map((bookingData) => bookingData as Booking) // Explicitly cast each booking to Booking type
          .toList();

      return bookings;
    } catch (e) {
      print('Error fetching bookings: $e');
      return [];
    }
  }

}