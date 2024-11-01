import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/Pages/Admin/pdfView.dart';
import 'package:profixer/Services/Alert_services.dart';
import 'package:profixer/Services/Navigation_services.dart';
import 'package:profixer/Services/database_services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/tecnician_model.dart'; // for icons

class TechnicianVerificationPage extends StatefulWidget {
  @override
  _TechnicianVerificationPageState createState() => _TechnicianVerificationPageState();
}

class _TechnicianVerificationPageState extends State<TechnicianVerificationPage> {
  late List<TechnicianProfile> pendingTechnicians = [];
  bool isLoading = true;
  final GetIt _getIt = GetIt.instance;
  late DatabaseServices _databaseServices;
  late AlertServices _alertServices;
  late NavigationService _navigationService;

  @override
  void initState() {
    super.initState();
    _databaseServices = _getIt.get<DatabaseServices>();
    _alertServices=_getIt.get<AlertServices>();
    _navigationService=_getIt.get<NavigationService>();
    fetchPendingTechnicians();
  }

  Future<void> fetchPendingTechnicians() async {
    pendingTechnicians = await _databaseServices.fetchPendingTechnicians();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> openPDF(String pdfUrl) async {
    try {
      final response = await http.get(Uri.parse(pdfUrl));
      if (response.statusCode == 200) {
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/temp.pdf');
        await file.writeAsBytes(response.bodyBytes);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PDFScreen(path: file.path),
          ),
        );
      } else {
        print('Failed to load PDF from URL');
      }
    } catch (e) {
      print('Error downloading PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Technician Verification'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : pendingTechnicians.isEmpty?Center(
        child: Text("No pending technicians for verification",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
      ):ListView.builder(
        itemCount: pendingTechnicians.length,
        itemBuilder: (context, index) {
          final technician = pendingTechnicians[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.only(left: 3.0,right: 3.0,bottom: 3.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  border: Border.all(
                    color: Colors.blue.shade300, // Border color
                    width: 2.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(10.0), // Rounded corners (optional)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0,right: 10.0,bottom: 5.0,top: 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Technician #${index+1}",style: TextStyle(fontSize: 20),),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          // Technician Image
                          Container(
                            padding: EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                technician.pfpURL!,
                                width: 120,
                                height: 185,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 14.0),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Name with Icon
                              Row(
                                children: [
                                  Icon(Icons.person, color: Colors.blue),
                                  SizedBox(width: 5),
                                  Text(
                                    'Name: ${technician.name}',
                                    style: TextStyle( fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              // Phone with Icon
                              Row(
                                children: [
                                  Icon(Icons.phone, color: Colors.blue),
                                  SizedBox(width: 5),
                                  Text('Phone: ${technician.phoneNumber}'),
                                ],
                              ),
                              SizedBox(height: 5),
                              // Skill with Icon
                              Row(
                                children: [
                                  Icon(Icons.build, color: Colors.blue),
                                  SizedBox(width: 5),
                                  Text('Skill: ${technician.skill}'),
                                ],
                              ),
                              SizedBox(height: 5),
                              // Rating with Icon
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.yellow),
                                  SizedBox(width: 5),
                                  Text('Rating: ${technician.rating.toString()}'),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text('Documents:', style: TextStyle(fontWeight: FontWeight.bold)),
                              // Government ID with Icon
                              if (technician.govtID != null)
                                GestureDetector(
                                  onTap: () => openPDF(technician.govtID!),
                                  child: Row(
                                    children: [
                                      Icon(FontAwesomeIcons.idCard, color: Colors.blue), // Blue icon
                                      SizedBox(width: 15),
                                      Text('Government ID', style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                                    ],
                                  ),
                                ),
                              SizedBox(height: 5,),
                              // Proof of Work with Icon
                              if (technician.proofOfWork != null)
                                GestureDetector(
                                  onTap: () => openPDF(technician.proofOfWork!),
                                  child: Row(
                                    children: [
                                      Icon(FontAwesomeIcons.briefcase, color: Colors.blue), // Blue icon
                                      SizedBox(width: 15),
                                      Text('Proof of Work', style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Approve/Reject Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Approve action
                              setState(() {
                                _databaseServices.approveTechnician(technician.tid);
                                _alertServices.showToast(text: "Technician Approved Succesfully",icon: Icons.check,);
                                _navigationService.pushnamed("/admindashboard");
                              });
                            },
                            child: Text('Approve',style: TextStyle(color: Colors.white),),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          ),
                          SizedBox(width: 30),
                          ElevatedButton(
                            onPressed: () {
                              // Reject action
                              setState(() {
                                _databaseServices.rejectTechnician(technician.tid);
                                _alertServices.showToast(text: "Technician Rejected Succesfully",icon: Icons.check,);

                              });
                            },
                            child: Text('Reject',style: TextStyle(color: Colors.white),),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
