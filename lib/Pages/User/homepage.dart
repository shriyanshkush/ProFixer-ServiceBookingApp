import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/Pages/User/technicianlistskillbased.dart';
import 'package:profixer/Services/Navigation_services.dart';
import 'package:profixer/Services/auth_services.dart';
import 'package:profixer/Services/database_services.dart';
import 'package:profixer/widgets/service_card.dart';

import '../../models/tecnician_model.dart';

class Homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomepageState();
  }
}

class HomepageState extends State<Homepage> {
  final GetIt _getIt = GetIt.instance;
  late final AuthServices _authServices;
  late final NavigationService _navigationService;
  late DatabaseServices _databaseServices;
  List<TechnicianProfile> technicians = [];
  @override
  void initState() {
    super.initState();
    _authServices = _getIt.get<AuthServices>();
    _navigationService = _getIt.get<NavigationService>();
    _databaseServices=_getIt.get<DatabaseServices>();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Options'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text("logout"),
              trailing: const Icon(Icons.logout, color: Colors.red),
              onTap: () async {
                  bool result = await _authServices.logout();
                  if (result) {
                       _navigationService.pushReplacementnamed("/login");
                  }
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('Option 2'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenSize.height * 0.037),
              _aboveSearchfield(),
              SizedBox(height: screenSize.height * 0.025),
              _categaries(),
              SizedBox(height: screenSize.height * 0.025),
              _recommended(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar(Size screenSize) {
    return Center(
      child: SizedBox(
        width: screenSize.width * 0.9,
        child: Container(
          color: Colors.white,
          child: TextField(
            onSubmitted: (value) {
              // Handle search submission logic here
            },
            decoration: const InputDecoration(
              hintText: "Search for Services......",
              prefixIcon: Icon(
                Icons.search,
                color: Color(0xFF0000FF),
              ),
              border: OutlineInputBorder(),
            ),
          ),
        )
      ),
    );
  }

  Widget _aboveSearchfield() {
    return  Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.blue.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children:[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hey Shriyansh,",style: TextStyle(fontSize: 21),),
                    SizedBox(height: 8,),
                    Row(
                      children: [
                        Text("What Services Do You",style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),),
                      ],
                    ),
                    Text("Need?",style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),),
                  ],
                ),
                SizedBox(width: 21,),
                CircleAvatar(
                    radius: 30,
                    child: IconButton(onPressed: (){}, icon: Icon(Icons.notifications,size: 38,color: Colors.blue,))),
            ]
            ),
            SizedBox(height: 10,),
            _searchBar(MediaQuery.of(context).size),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavigationBar() {
    return Container(
      height: 70,
      color: Colors.blue,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // Space out the items evenly
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically within the column
              crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally within the column
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.home,
                    size: 33,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Home",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.015),
            Column(
              children: [
                Builder(
                  builder: (context) => Center(
                    child: IconButton(
                      icon: const Icon(Icons.person,size: 33,color: Colors.white,),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                ),
                Text("Profile",style: TextStyle(color: Colors.white),)
              ],
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.015),
            Column(
              children: [
                IconButton(onPressed: (){
                  _navigationService.pushnamed("/cartpage");
                }, icon: Icon(Icons.shopping_cart_rounded,size: 33,color: Colors.white,)),
                Text("Cart",style: TextStyle(color: Colors.white),)
              ],
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.015),
            Column(
              children: [
                IconButton(onPressed: (){
                  _navigationService.pushnamed("/showbooking");
                }, icon: Icon(Icons.calendar_month,size: 33,color: Colors.white,),),
                Text("Booking",style: TextStyle(color: Colors.white),),
              ],
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.015),
            Column(
              children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.chat,size: 33,color: Colors.white,)),
                Text("Chat",style: TextStyle(color: Colors.white),)
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _categaries() {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("All Categories",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            GestureDetector(
              onTap: (){
                _navigationService.pushnamed('/allservicecardpage');
              },
                child: Text("view all",style: TextStyle(fontSize: 21,color: Colors.blue),)),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.035),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ServiceCard(onTap: () {
                _navigationService.pushnamed(
                  '/technicianlistskillbased',
                  arguments: 'Electrics', // Or any other service
                );
              },
                  imagepath: 'assets/images/electrician.jpeg', service: "Electrics"),
              SizedBox(width: MediaQuery.of(context).size.width * 0.065),
              ServiceCard(onTap: () {
                _navigationService.pushnamed(
                    '/technicianlistskillbased',
                    arguments: 'HVAC Services',);
              },
                  imagepath: 'assets/images/Hvac.jpeg', service: "HVAC Services"),
              SizedBox(width: MediaQuery.of(context).size.width * 0.065),
              ServiceCard(onTap: () {
                _navigationService.pushnamed(
                  '/technicianlistskillbased',
                  arguments: 'Painting', // Or any other service
                );
              },
                  imagepath: 'assets/images/painting.jpeg', service: "Painting"),
              SizedBox(width: MediaQuery.of(context).size.width * 0.065),
              ServiceCard(onTap: () {
                _navigationService.pushnamed(
                  '/technicianlistskillbased',
                  arguments: 'Plumbing', // Or any other service
                );
              },
                  imagepath: 'assets/images/plumber.jpg', service: "Plumbing"),
              SizedBox(width: MediaQuery.of(context).size.width * 0.065),
              ServiceCard(onTap: () {
                _navigationService.pushnamed(
                  '/technicianlistskillbased',
                  arguments: 'Carpentry', // Or any other service
                );
              },
                  imagepath: 'assets/images/carpentar.jpg', service: "Carpentry"),
              SizedBox(width: MediaQuery.of(context).size.width * 0.065),
              ServiceCard(onTap: () {
                _navigationService.pushnamed(
                  '/technicianlistskillbased',
                  arguments: 'Pest Control', // Or any other service
                );
              },
                  imagepath: 'assets/images/pestcontrol.jpeg', service: "Pest Control"),
              SizedBox(width: MediaQuery.of(context).size.width * 0.065),
              ServiceCard(onTap: () {
                _navigationService.pushnamed(
                  '/technicianlistskillbased',
                  arguments: 'Cleaning', // Or any other service
                );
              },
                  imagepath: 'assets/images/cleaning.jpg', service: "Cleaning"),
              SizedBox(width: MediaQuery.of(context).size.width * 0.065),
              ServiceCard(onTap: () {
                _navigationService.pushnamed(
                  '/technicianlistskillbased',
                  arguments: 'Repair', // Or any other service
                );
              },
                  imagepath: 'assets/images/repair.jpeg', service: "Repair"),
              SizedBox(width: MediaQuery.of(context).size.width * 0.065),
            ],
          ),
        ),
      ],
    );
  }

  Widget _recommended() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Recommended",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            GestureDetector(
                onTap: (){
                  _navigationService.pushnamed('/allservicecardpage');
                },
                child: Text("view all",style: TextStyle(fontSize: 21,color: Colors.blue),)),
          ],
        ),
      ],
    );
  }

}
