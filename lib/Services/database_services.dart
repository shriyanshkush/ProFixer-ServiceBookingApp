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


}