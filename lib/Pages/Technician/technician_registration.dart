import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/Services/Alert_services.dart';
import 'package:profixer/Services/Navigation_services.dart';
import 'package:profixer/Services/auth_services.dart';
import 'package:profixer/Services/database_services.dart';
import 'package:profixer/Services/storage_services.dart';
import 'package:profixer/models/tecnician_model.dart';
import 'package:profixer/widgets/text_formField.dart';

import '../../Services/Meadia_services.dart';
import '../../widgets/_availabilitySelector.dart';

class TechnicianRegistration extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TechnicianRegistrationPageState();
  }
}

class _TechnicianRegistrationPageState extends State<TechnicianRegistration> {
  final GetIt _getIt = GetIt.instance;
  late NavigationService _navigationService;
  late MediaService _mediaService;
  late AuthServices _authServices;
  late StorageServices _storageServices;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController phoneNumberController;
  late TextEditingController expertiseController;
  late DatabaseServices _databaseServices;
  late AlertServices _alertServices;
  bool isLoading=false;
  final _formKey = GlobalKey<FormState>();
  File? selectedImage;
  final String PLACEHOLDER_PFP =
      "https://t3.ftcdn.net/jpg/05/16/27/58/360_F_516275801_f3Fsp17x6HQK0xQgDQEELoTuERO4SsWV.jpg";
  File? selectedGovtId;
  String? selectedGovtIdName;
  File? selectedprevWork;
  String? selectedprevWorkName;

  String? name,email,password,phonenumber,expertise;
  Map<String, List<String>> _selectedAvailability = {};

  @override
  void initState() {
    super.initState();
    expertiseController=TextEditingController();
    nameController=TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    phoneNumberController=TextEditingController();
    _navigationService = _getIt.get<NavigationService>();
    _databaseServices=_getIt.get<DatabaseServices>();
    _alertServices=_getIt.get<AlertServices>();
    _storageServices=_getIt.get<StorageServices>();
    _authServices=_getIt.get<AuthServices>();
    _mediaService=_getIt.get<MediaService>();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 25),
                Text(
                  "Let's get going!",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  "Register an account using the form below",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[800],
                    height: 1.5,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 18),
                _pfpselectionfeild (),
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Name",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 8),
                RoundedTextFormField(
                  textEditingController: nameController,
                  hintText: "Name",
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onChanged: (value){
                    name=value;
                  },
                ),
                SizedBox(height: 18),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 8),
                RoundedTextFormField(
                  textEditingController: emailController,
                  hintText: "Email",
                  prefixIcon: Icons.email_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onChanged: (value){
                    email=value;
                  },
                ),
                SizedBox(height: 18),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Password",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 8),
                RoundedTextFormField(
                  textEditingController: passwordController,
                  hintText: "Password",
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                  onChanged: (value){
                    password=value;
                  },
                ),
                SizedBox(height: 18),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Confirm Password",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 8),
                RoundedTextFormField(
                  textEditingController: confirmPasswordController,
                  hintText: "Confirm Password",
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  onChanged: (value){
                    password=value;
                  },
                ),
                SizedBox(height: 18),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Phone Number",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 8),
                RoundedTextFormField(
                  textEditingController: phoneNumberController,
                  hintText: "Phone Number",
                  prefixIcon: Icons.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    phonenumber=value;
                  },
                ),
                SizedBox(height: 18,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Area of Expertise",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 8),
                RoundedTextFormField(
                  textEditingController: expertiseController,
                  hintText: "Area of Expertise",
                  prefixIcon: Icons.build_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Area of Expertise';
                    }
                    return null;
                  },
                  onChanged: (value){
                    expertise=value;
                  },
                ),
                SizedBox(height: 18),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Upload Govt. ID Proof",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 8),
                _documentUploadGovtIDField(),
                SizedBox(height: 18,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Upload Previous Work Proof",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 8),
                _documentUploadprevWorkField(),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Availability",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 8),
                AvailabilitySelector(
                  onAvailabilityChanged: (availability) {
                    _selectedAvailability = availability;
                  },
                ),
                ElevatedButton(
                  onPressed: _register,
                  child:  isLoading
                      ? CircularProgressIndicator()
                      :Text(
                    "Register",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Color(0xFF0000FF),
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    GestureDetector(
                      onTap: _navigateToLogin,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Color(0xFF0000FF),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _register() async {
    if (_formKey.currentState!.validate() &&
        selectedGovtId != null &&
        selectedImage != null &&
        selectedprevWork != null &&
        _selectedAvailability.isNotEmpty) {
      _formKey.currentState?.save();
      setState(() {
        isLoading = true; // Start loading state
      });

      try {
        bool result = await _authServices.signUp(email!, password!);
        if (result) {
          final user = _authServices.user;

          if (user != null) {
            // Upload files and create technician profile
            String? pfpURL = await _storageServices.uploadTechnicainpfp(file: selectedImage!, tid: user.uid);
            String? govtID = await _storageServices.uploadGovtId(file: selectedGovtId!, tid: user.uid);
            String? proofOfWork = await _storageServices.uploadProofOfwork(file: selectedprevWork!, tid: user.uid);

            if (pfpURL != null && govtID != null && proofOfWork != null) {
              await _databaseServices.createTechnicianProfile(
                technician: TechnicianProfile(
                  tid: user.uid,
                  name: name!,
                  phoneNumber: phonenumber!,
                  skill: expertise!,
                  rating: 0.0,
                  pfpURL: pfpURL,
                  govtID: govtID,
                  proofOfWork: proofOfWork,
                  availability: _selectedAvailability,
                ),
              );

              _alertServices.showToast(
                text: "User registered successfully",
                icon: Icons.check,
              );

              _navigationService.goback();
              _navigationService.pushReplacementnamed("/userhome");
            }
          }
        }
      } catch (e) {
        _alertServices.showToast(
          text: "An error occurred Failed to register: ${e.toString()}",
          icon: Icons.error,
        );
      }
      finally {
        setState(() {
          isLoading = false; // Stop loading state in both success and failure cases
        });
      }
    } else {
      _alertServices.showToast(
        text: "Please complete all required fields and uploads",
        icon: Icons.error,
      );
    }

  }


  void _navigateToLogin() {
    _navigationService.pushnamed("/login");
  }
  Widget _pfpselectionfeild () {
    return GestureDetector(
      onTap: () async{
        File? file=await _mediaService.getImageFromGallery();
        if(file!=null) {
          setState(() {
            selectedImage=file;
          });
        }
      },
      child: CircleAvatar(
        radius: MediaQuery.sizeOf(context).width*0.15,
        backgroundImage: selectedImage!=null?FileImage(selectedImage!):NetworkImage(PLACEHOLDER_PFP)
        as ImageProvider,
      ),
    );
  }


  Widget _documentUploadGovtIDField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            File? file = await _mediaService.pickFile();
            if (file != null) {
              int size= await file.length();
              int maxsize=1*1024*1024;
              if(size>maxsize) {
                _alertServices.showToast(text: "File size exceeds 1MB. Please select a smaller file.",
                    icon: Icons.error);
              } else{
                setState(() {
                  selectedGovtId = file;
                  selectedGovtIdName = file.path.split('/').last;
                });
              }
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.blue),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.upload_file, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  "Upload Document",
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        if (selectedGovtIdName != null)
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              "Selected file: $selectedGovtIdName",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
      ],
    );
  }

  Widget _documentUploadprevWorkField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            File? file = await _mediaService.pickFile();
            if (file != null) {
              int size= await file.length();
              int maxsize=1*1024*1024;
              if(size>maxsize) {
                _alertServices.showToast(text: "File is to large,it should be wihtin 1MB",
                icon: Icons.error);
              } else{
                setState(() {
                  selectedprevWork = file;
                  selectedprevWorkName = file.path.split('/').last;
                });
              }
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.blue),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.upload_file, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  "Upload Document",
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        if (selectedprevWorkName != null)
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              "Selected file: $selectedprevWorkName",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
      ],
    );
  }
}
