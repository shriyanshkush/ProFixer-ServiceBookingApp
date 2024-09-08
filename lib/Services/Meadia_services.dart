import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class MediaService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<File?> getImageFromGallery() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        return File(pickedFile.path);
      } else {
        // No image selected
        return null;
      }
    } catch (e) {
      // Handle any exceptions here
      print("Error picking image: $e");
      return null;
    }
  }

  Future<File?> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null && result.files.single.path != null) {
        return File(result.files.single.path!);
      } else {
        // No file selected
        return null;
      }
    } catch (e) {
      // Handle any exceptions here
      print("Error picking file: $e");
      return null;
    }
  }
}
