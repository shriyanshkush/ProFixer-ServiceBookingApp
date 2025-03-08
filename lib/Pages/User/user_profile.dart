import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/Services/Alert_services.dart';
import '../../Services/Navigation_services.dart';
import '../../Services/auth_services.dart';
import '../../models/user_model.dart';

class UserProfilePage extends StatefulWidget {
  final UserProfile userProfile;

  const UserProfilePage({Key? key, required this.userProfile}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final GetIt _getIt = GetIt.instance;
  late final AuthServices _authServices;
  late final NavigationService _navigationService;
  late AlertServices _alertServices;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authServices=_getIt.get<AuthServices>();
    _navigationService=_getIt.get<NavigationService>();
    _alertServices=_getIt<AlertServices>();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display user's name and UID
            _buildUserInfo(widget.userProfile),
            SizedBox(height: 30),
            // Options: Go to Bookings, Go to Cart, and Logout
            _buildProfileOptions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo(UserProfile userProfile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name: ${userProfile.name}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          'Email: ${_authServices.user!.email}',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildProfileOptions(BuildContext context) {
    return Column(
      children: [
        _buildProfileOption(
          icon: Icons.book_online,
          label: 'Go to Bookings',
          onTap: () {
            _navigationService.pushnamed("/showbooking");
          },
        ),
        _buildProfileOption(
          icon: Icons.shopping_cart,
          label: 'Go to Cart',
          onTap: () {
            _navigationService.pushnamed("/cartpage");

          },
        ),
        _buildProfileOption(
          icon: FontAwesomeIcons.wallet,
          label: 'Payment History',
          onTap: ()  {
            _navigationService.pushnamed("/paymenthistory");
          },
        ),
        _buildProfileOption(
          icon: Icons.logout,
          label: 'Logout',
          onTap: () async {
            bool result = await _authServices.logout();
            if (result) {
              _navigationService.handleLoginSuccess("/beforelogin");
              _alertServices.showToast(
                  icon: Icons.check_circle,
                  text: "User logged out Successfully !");
            }
          },
        ),
      ],
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
}
