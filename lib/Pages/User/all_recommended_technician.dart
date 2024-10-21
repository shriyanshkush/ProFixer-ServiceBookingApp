import 'package:flutter/material.dart';
import 'package:profixer/Services/database_services.dart'; // Adjust the path as needed
import '../../models/tecnician_model.dart';
import '../../widgets/technician_card.dart'; // Adjust the path as needed

class AllRecommendedTechniciansPage extends StatefulWidget {
  @override
  _AllRecommendedTechniciansPageState createState() => _AllRecommendedTechniciansPageState();
}

class _AllRecommendedTechniciansPageState extends State<AllRecommendedTechniciansPage> {
  List<TechnicianProfile> allTechnicians = [];

  @override
  void initState() {
    super.initState();
    fetchAllTechnicians();
  }

  Future<void> fetchAllTechnicians() async {
    try {
      // Fetch technicians from your database service
      List<TechnicianProfile> technicians = await DatabaseServices().getTopTechniciansByService();
      setState(() {
        allTechnicians = technicians;
      });
    } catch (e) {
      // Handle any errors that occur during data fetching
      print("Error fetching technicians: $e");
      // Optionally show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load technicians")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recommended Technicians"),
      ),
      body: allTechnicians.isEmpty
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: allTechnicians.length,
        itemBuilder: (context, index) {
          final technician = allTechnicians[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/technicianinfo", arguments: technician);
              },
              child: TechnicianCard(technicianProfile: technician),
            ),
          );
        },
      ),
    );
  }
}
