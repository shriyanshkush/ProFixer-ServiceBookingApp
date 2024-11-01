import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../Services/Navigation_services.dart';

class AdminDashboard extends StatefulWidget {
  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final GetIt _getIt=GetIt.instance;
  late NavigationService _navigationService;
  @override
  void initState() {
    // TODO: implement initState
    _navigationService=_getIt.get<NavigationService>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildStatisticsSection(),
              SizedBox(height: 20),
              _buildManageProfilesSection(),
              SizedBox(height: 20),
              // _buildMonitorJobsSection(),
              // SizedBox(height: 20),
              _buildComplaintsFeedbackSection(),
              SizedBox(height: 20),
              _buildEarningsSection(),
            ],
          ),
        ),
      ),
    );
  }

  // Statistics Section
  Widget _buildStatisticsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Overall Statistics',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            _buildStaticInfo(
              icon: Icons.pie_chart,
              label: 'Total Users',
              value: '1', // Static value for Total Users
            ),
            _buildStaticInfo(
              icon: Icons.people,
              label: 'Total Technicians',
              value: '3', // Static value for Total Technicians
            ),
            _buildStaticInfo(
              icon: Icons.book,
              label: 'Total Bookings',
              value: '4', // Static value for Total Bookings
            ),
            _buildStaticInfo(
              icon: Icons.attach_money,
              label: 'Total Earnings',
              value: '\$45,000', // Static value for Total Earnings
            ),
          ],
        ),
      ),
    );
  }

// Widget for static info display without button functionality
  Widget _buildStaticInfo({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Manage Profiles Section
  Widget _buildManageProfilesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Manage Profiles',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            _buildProfileOption(
              icon: Icons.people,
              label: 'Manage Users',
              onTap: () {
                // Navigate to Manage Users Screen
              },
            ),
            _buildProfileOption(
              icon: Icons.build,
              label: 'Manage Technicians',
              onTap: () {
                // Navigate to Manage Technicians Screen
              },
            ),
            _buildProfileOption(
              icon: Icons.verified_user,
              label: 'Technician Review & Approval',
              onTap: () {
               _navigationService.pushnamed("/technicianverification");
              },
            ),
          ],
        ),
      ),
    );
  }

  // Monitor Jobs Section
  Widget _buildMonitorJobsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Monitor Jobs & Transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            _buildProfileOption(
              icon: Icons.work,
              label: 'View Ongoing Jobs',
              onTap: () {
                // Navigate to Ongoing Jobs Screen
              },
            ),
            _buildProfileOption(
              icon: Icons.attach_money,
              label: 'View Transactions',
              onTap: () {
                // Navigate to Transactions Screen
              },
            ),
          ],
        ),
      ),
    );
  }

  // Complaints & Feedback Section
  Widget _buildComplaintsFeedbackSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Complaints',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            _buildProfileOption(
              icon: Icons.feedback,
              label: 'View Complaints',
              onTap: () {
                // Navigate to Complaints Screen
              },
            ),
          ],
        ),
      ),
    );
  }

  // Earnings Section
  Widget _buildEarningsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Earnings Overview',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            _buildProfileOption(
              icon: Icons.attach_money,
              label: 'Total Earnings',
              onTap: () {
                // Navigate to Earnings Screen
              },
            ),
            _buildProfileOption(
              icon: Icons.pie_chart,
              label: 'Admin Commission (40%)',
              onTap: () {
                // Navigate to Admin Commission Details
              },
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Widget for Buttons with Icons
  Widget _buildProfileOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(label),
      trailing: Icon(Icons.arrow_forward),
      onTap: onTap,
    );
  }
}
