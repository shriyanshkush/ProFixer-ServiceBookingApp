import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/Services/auth_services.dart';
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

  Future<List<TechnicianProfile>> getTechniciansBySkill(String skill) async {
    try {
      print('Searching for technicians with skill: $skill');
      final querySnapshot = await _techniciancollection
          ?.where('skill', isEqualTo: skill)
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

      // Check if the document exists
      if (userDoc==null) {
        // Handle the case where the user document does not exist
        return [];
      }

      final userProfile = userDoc.data() as UserProfile?;

      // Ensure userProfile is not null and has a cartTechnicians list
      final List<TechnicianProfile> cartTechnicians = userProfile?.cartTechnicians ?? [];

      return cartTechnicians;
    } catch (e) {
      // Handle any errors that might occur during the fetch
      print('Error fetching cart technicians: $e');
      return [];
    }
  }





}