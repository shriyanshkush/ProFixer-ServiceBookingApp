import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class StorageServices {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String?> uploadUserpfp({
    required File file,
    required String uid,
  }) async {
    try {
      Reference fileRef = _firebaseStorage.ref().child("user/pfps/$uid${p.extension(file.path)}");
      UploadTask task = fileRef.putFile(file);
      TaskSnapshot snapshot = await task;
      if (snapshot.state == TaskState.success) {
        return await fileRef.getDownloadURL();
      }
    } catch (e) {
      print('Error uploading user profile picture: $e');
      return null;
    }
  }

  Future<String?> uploadTechnicainpfp({
    required File file,
    required String tid,
  }) async {
    try {
      Reference fileRef = _firebaseStorage.ref().child("technician/pfps/$tid${p.extension(file.path)}");
      UploadTask task = fileRef.putFile(file);
      TaskSnapshot snapshot = await task;
      if (snapshot.state == TaskState.success) {
        return await fileRef.getDownloadURL();
      }
    } catch (e) {
      print('Error uploading technician profile picture: $e');
      return null;
    }
  }

  Future<String?> uploadGovtId({
    required File file,
    required String tid,
  }) async {
    try {
      Reference fileRef = _firebaseStorage.ref().child("technician/docs/GovtIds/${tid}_${DateTime.now().millisecondsSinceEpoch}${p.extension(file.path)}");
      UploadTask task = fileRef.putFile(file);
      TaskSnapshot snapshot = await task;
      if (snapshot.state == TaskState.success) {
        return await fileRef.getDownloadURL();
      }
    } catch (e) {
      print('Error uploading government ID: $e');
      return null;
    }
  }

  Future<String?> uploadProofOfwork({
    required File file,
    required String tid,
  }) async {
    try {
      Reference fileRef = _firebaseStorage.ref().child("technician/docs/ProofOfwork/${tid}_${DateTime.now().millisecondsSinceEpoch}${p.extension(file.path)}");
      UploadTask task = fileRef.putFile(file);
      TaskSnapshot snapshot = await task;
      if (snapshot.state == TaskState.success) {
        return await fileRef.getDownloadURL();
      }
    } catch (e) {
      print('Error uploading proof of work: $e');
      return null;
    }
  }
}
