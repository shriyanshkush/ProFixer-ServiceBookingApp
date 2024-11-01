import 'package:flutter/material.dart';
import 'package:profixer/Services/database_services.dart';
import '../../models/tecnician_model.dart';
import '../../widgets/technician_card.dart';

class AllRecommendedTechniciansPage extends StatefulWidget {
  @override
  _AllRecommendedTechniciansPageState createState() => _AllRecommendedTechniciansPageState();
}

class _AllRecommendedTechniciansPageState extends State<AllRecommendedTechniciansPage> {
  List<TechnicianProfile> allTechnicians = [];
  bool isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    fetchAllTechnicians();
  }

  Future<void> fetchAllTechnicians() async {
    try {
      List<TechnicianProfile> technicians = await DatabaseServices().getTopTechniciansByService();
      setState(() {
        allTechnicians = technicians;
        isLoading = false; // Set loading to false after fetching
      });
    } catch (e) {
      print("Error fetching technicians: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load technicians")),
      );
      setState(() {
        isLoading = false; // Set loading to false on error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recommended Technicians"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : allTechnicians.isEmpty
          ? Center(child: Text("No technicians available")) // No data view
          : RefreshIndicator(
        onRefresh: fetchAllTechnicians, // Pull to refresh
        child: ListView.builder(
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
      ),
    );
  }
}
