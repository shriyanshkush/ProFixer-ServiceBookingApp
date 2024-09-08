import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/Services/Navigation_services.dart';
import 'package:profixer/widgets/service_card.dart';

class AllServicesPage extends StatefulWidget {
  @override
  State<AllServicesPage> createState() => _AllServicesPageState();
}

class _AllServicesPageState extends State<AllServicesPage> {
  final GetIt _getIt=GetIt.instance;

  late NavigationService _navigationService;
  @override
  void initState() {
    super.initState();
    _navigationService=_getIt.get<NavigationService>();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Services'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2, // Number of cards per row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            ServiceCard(onTap: () {},
                imagepath: 'assets/images/electrician.jpeg', service: "Electrics"),
            ServiceCard(onTap: () {},
                imagepath: 'assets/images/Hvac.jpeg', service: "HVAC Services"),
            ServiceCard(onTap: () {},
                imagepath: 'assets/images/painting.jpeg', service: "Painting"),
            ServiceCard(onTap: () {},
                imagepath: 'assets/images/plumber.jpg', service: "Plumbing"),
            ServiceCard(onTap: () {},
                imagepath: 'assets/images/carpentar.jpg', service: "Carpentry"),
            ServiceCard(onTap: () {},
                imagepath: 'assets/images/repair.jpeg', service: "Repair"),
            ServiceCard(onTap: () {},
                imagepath: 'assets/images/pestcontrol.jpeg', service: "Pest Control"),
            ServiceCard(onTap: () {},
                imagepath: 'assets/images/cleaning.jpg', service: "Cleaning"),
          ],
        ),
      ),
    );
  }
}
