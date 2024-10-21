import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/Services/Navigation_services.dart';

import '../../widgets/service_card.dart';

class AllservicesPage extends StatefulWidget {

  @override
  State<AllservicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<AllservicesPage> {
  final GetIt _getIt=GetIt.instance;
  late NavigationService _navigationService;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigationService=_getIt.get<NavigationService>();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose a Service"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Display 3 items in a row
            crossAxisSpacing: 15.0, // Space between columns
            mainAxisSpacing: 20.0, // Space between rows
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            return ServiceCard(
              onTap: () {
                _navigationService.pushnamed(
                  '/technicianlistskillbased',
                  arguments: service['name'],
                );
              },
              imagepath: service['imagepath']!,
              service: service['name']!,
            );
          },
        ),
      ),
    );
  }
}

// data for services
final List<Map<String, String>> services = [
  {'imagepath': 'assets/images/cleaning.png', 'name': 'Cleaning'},
  {'imagepath': 'assets/images/plumbing.png', 'name': 'Plumbing'},
  {'imagepath': 'assets/images/repairing.jpeg', 'name': 'Repair'},
  {'imagepath': 'assets/images/painter.png', 'name': 'Painting'},
  {'imagepath': 'assets/images/electricity.png', 'name': 'Electrics'},
  {'imagepath': 'assets/images/carpenter.png', 'name': 'Carpentry'},
  {'imagepath': 'assets/images/Hvac.png', 'name': 'HVAC Services'},
  {'imagepath': 'assets/images/pest control.png', 'name': 'Pest Control'},
  {'imagepath': 'assets/images/washing.png', 'name': 'Washing'},
];