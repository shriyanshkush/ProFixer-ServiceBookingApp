import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import '../../Services/Navigation_services.dart';
import '../../Services/auth_services.dart';
import '../../models/tecnician_model.dart';
import '../Admin/pdfView.dart';

class TechnicianProfilePage extends StatefulWidget {
  final TechnicianProfile technicianProfile;

  TechnicianProfilePage({required this.technicianProfile});

  @override
  State<TechnicianProfilePage> createState() => _TechnicianProfilePageState();
}

class _TechnicianProfilePageState extends State<TechnicianProfilePage> {
  final GetIt _getIt = GetIt.instance;
  late AuthServices _authServices;
  late NavigationService _navigationService;

  @override
  void initState() {
    super.initState();
    _authServices = _getIt.get<AuthServices>();
    _navigationService = _getIt.get<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    // Grouping availability by day and time slot
    Map<String, List<String>> groupedAvailability = {};
    widget.technicianProfile.availability.forEach((day, timeSlots) {
      List<String> availableSlots = timeSlots
          .where((slot) => slot.values.first) // Filtering available slots
          .map((slot) => slot.keys.first) // Extracting time slot
          .toList();
      if (availableSlots.isNotEmpty) groupedAvailability[day] = availableSlots;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Technician Profile"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture with a click-to-enlarge feature
            Card(
              color: Colors.blue.shade100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showProfilePictureDialog();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80), // Match the CircleAvatar radius
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 80,
                          child: Image.network(
                            widget.technicianProfile.pfpURL!,
                             fit: BoxFit.cover, // Ensures the image covers the avatar's circle
                            alignment: Alignment.topCenter, // Aligns the image to the top, cropping from the bottom
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        // Technician's Name and Rating
                        Text(
                          widget.technicianProfile.name,
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Rating:",style: TextStyle(fontSize: 18),),
                            Icon(Icons.star, color: Colors.orange),
                            SizedBox(width: 5),
                            Text(
                              "${widget.technicianProfile.rating}",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Phone Number
                        Text(
                          "Phone: ${widget.technicianProfile.phoneNumber}",
                          style: TextStyle(fontSize: 18,),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            _buildProfileOption(
              icon: Icons.check_circle,
              label: "View Your Availability",
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Your Availability"),
                      content: SizedBox(
                        width: double.maxFinite,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: groupedAvailability.length,
                          itemBuilder: (context, index) {
                            String day = groupedAvailability.keys.elementAt(index);
                            List<String> timeSlots = groupedAvailability[day]!;
                            return ListTile(
                              title: Text(
                                day,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(timeSlots.join(", ")),
                            );
                          },
                        ),
                      ),
                      actions: [
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(Colors.blue),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Close",style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            _buildProfileOption(
              icon: Icons.document_scanner,
              label: 'View Your Documents',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Your Documents"),
                      content: SizedBox(
                        width: double.maxFinite,
                        height: 70,
                        child:Column(
                          children: [
                            if (widget.technicianProfile.govtID != null)
                              GestureDetector(
                                onTap: () => openPDF(widget.technicianProfile.govtID!),
                                child: Row(
                                  children: [
                                    Icon(FontAwesomeIcons.idCard, color: Colors.blue), // Blue icon
                                    SizedBox(width: 20),
                                    Text('Government ID', style: TextStyle(color: Colors.blue,
                                        fontSize:20,decoration: TextDecoration.underline)),
                                  ],
                                ),
                              ),
                            SizedBox(height: 5,),
                            // Proof of Work with Icon
                            if (widget.technicianProfile.proofOfWork != null)
                              GestureDetector(
                                onTap: () => openPDF(widget.technicianProfile.proofOfWork!),
                                child: Row(
                                  children: [
                                    Icon(FontAwesomeIcons.briefcase, color: Colors.blue), // Blue icon
                                    SizedBox(width: 20),
                                    Text('Proof of Work', style: TextStyle(color: Colors.blue,
                                        fontSize: 20,decoration: TextDecoration.underline)),
                                  ],
                                ),
                              ),
                          ],
                        )
                      ),
                      actions: [
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(Colors.blue),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Close",style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            _buildProfileOption(
              icon: Icons.book_online,
              label: 'Go to Bookings',
              onTap: () {
                _navigationService.pushnamed("/showallbookingstotechnician");
              },
            ),
            _buildProfileOption(
              icon: Icons.rate_review, // Or Icons.star, Icons.thumb_up
              label: "Your Reviews",
              onTap: () {
                // Navigate to the reviews page or show reviews
              },
            ),


            _buildProfileOption(
              icon: Icons.logout,
              label: 'Logout',
              onTap: ()  {
                _authServices.logout();
                _navigationService.pushReplacementnamed("/beforelogin");
              },
            ),
            SizedBox(height: 16),
            // Availability Section
          ],
        ),
      ),
    );
  }

  // Show profile picture in a dialog
  void _showProfilePictureDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.network(widget.technicianProfile.pfpURL!),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close",style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileOption({required IconData icon, required String label, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent,size: 25,),
      title: Text(label,style: TextStyle(fontSize: 20),),
      trailing: Icon(Icons.arrow_forward,size: 25),
      onTap: onTap,
    );
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
}
