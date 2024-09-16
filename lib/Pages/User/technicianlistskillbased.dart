import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/Services/Navigation_services.dart';
import 'package:profixer/widgets/technician_card.dart';

import '../../Services/database_services.dart';
import '../../models/tecnician_model.dart';

class TechnicianListSkillBased extends StatefulWidget {
  final String service;

  const TechnicianListSkillBased({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  State<TechnicianListSkillBased> createState() => _TechnicianListSkillBasedState();
}

class _TechnicianListSkillBasedState extends State<TechnicianListSkillBased> {
  final GetIt _getIt = GetIt.instance;
  late DatabaseServices _databaseServices;
  late NavigationService _navigationService;

  List<TechnicianProfile> technicians = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _databaseServices = _getIt.get<DatabaseServices>();
    _navigationService=_getIt.get<NavigationService>();
    fetchTechnicians(); // Fetch technicians on initialization
  }

  Future<void> fetchTechnicians() async {
    try {
      technicians = await _databaseServices.getTechniciansBySkill(widget.service);
      setState(() {
        isLoading = false; // Set loading to false once data is fetched
      });
    } catch (e, stackTrace) {
      print('Error fetching technicians: $e');
      print('Stack trace: $stackTrace');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.service} Technicians'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show a loader while fetching data
          : technicians.isEmpty
          ? Center(child: Text('No technicians found for ${widget.service}'))
          : ListView.builder(
           itemCount: technicians.length,
           itemBuilder: (context, index) {
           final technician = technicians[index];
           return Padding(
             padding: const EdgeInsets.all(15.0),
             child: Column(
               children: [
                 GestureDetector(
                   onTap: (){
                     _navigationService.pushnamed("/technicianinfo",arguments: technician);
                   },
                     child: TechnicianCard(technicianProfile: technician)),
               ],
             ),
           );
        },
      ),
    );
  }
}
