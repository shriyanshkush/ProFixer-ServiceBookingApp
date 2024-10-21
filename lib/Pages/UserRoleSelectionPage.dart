import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/Services/Navigation_services.dart';

class UserRoleSelectionPage extends StatefulWidget {
  @override
  State<UserRoleSelectionPage> createState() => _UserRoleSelectionPageState();
}

class _UserRoleSelectionPageState extends State<UserRoleSelectionPage> {
  final GetIt _getIt = GetIt.instance;
  late NavigationService _navigationService;

  @override
  void initState() {
    super.initState();
    _navigationService = _getIt.get<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Your Role",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildRoleButton(
              context,
              "Proceed as Technician",
              Colors.blue,
              Icons.build,
                  () {
                // Navigate to Technician Dashboard
                _navigationService.pushnamed("/technician_front");
              },
            ),
            SizedBox(height: 20), // Spacer
            Text(
              "OR",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 20), // Spacer
            _buildRoleButton(
              context,
              "Proceed as Admin",
              Colors.green,
              Icons.admin_panel_settings,
                  () {
                // Navigate to Admin Dashboard
                    _navigationService.pushnamed("/adminlogin");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleButton(
      BuildContext context,
      String title,
      Color color,
      IconData icon,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 10), // Spacer
            Text(
              title,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
