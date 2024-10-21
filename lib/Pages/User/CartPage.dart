import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/Services/Navigation_services.dart';
import 'package:profixer/Services/auth_services.dart';

import '../../Services/database_services.dart';
import '../../models/tecnician_model.dart';
import '../../widgets/technician_card.dart';

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CartPageState();
  }
}

class CartPageState extends State<CartPage> {
  final GetIt _getIt = GetIt.instance;
  late DatabaseServices _databaseServices;
  late NavigationService _navigationService;
  late AuthServices _authServices;

  List<TechnicianProfile> technicians = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _databaseServices = _getIt.get<DatabaseServices>();
    _navigationService=_getIt.get<NavigationService>();
    _authServices = _getIt.get<AuthServices>();
    fetchTechniciansCart();
  }

  void fetchTechniciansCart() async {
    try {
      final userId = _authServices.user?.uid;

      if (userId != null) {
        final fetchedTechnicians = await _databaseServices.getCartTechnicians(userId);

        // Update the state after fetching the technicians
        setState(() {
          technicians = fetchedTechnicians;
          isLoading = false; // Set loading to false after data is fetched
        });
      } else {
        setState(() {
          isLoading = false; // Even if there's no user, stop the loading indicator
        });
      }
    } catch (e) {
      // Handle error and stop loading
      setState(() {
        isLoading = false;
      });
      print('Error fetching technicians: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show a loader while fetching data
          : technicians.isEmpty
          ? Center(child: Text('Cart is Empty, Explore Services!',style: TextStyle(fontSize: 20),))
          : ListView.builder(
        itemCount: technicians.length,
        itemBuilder: (context, index) {
          final technician = technicians[index];
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () {
                _navigationService.pushnamed("/technicianinfo", arguments: technician);
              },
                child: TechnicianCard(technicianProfile: technician)),
          );
        },
      ),
    );
  }
}
