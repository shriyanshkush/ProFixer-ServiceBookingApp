import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/Services/auth_services.dart';
import 'package:profixer/Services/Alert_services.dart';
import 'package:profixer/Services/Navigation_services.dart';
import 'package:profixer/Services/database_services.dart';
import 'package:profixer/models/tecnician_model.dart';
import '../../widgets/chat_tile.dart';
import 'chat_page.dart';

class ChatHomepage extends StatefulWidget {
  const ChatHomepage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomepageState();
  }
}

class _HomepageState extends State<ChatHomepage> {
  final GetIt _getIt = GetIt.instance;
  late NavigationService _navigationService;
  late AuthServices _authService;
  late DatabaseServices _databaseService;

  List<TechnicianProfile> technicians = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthServices>();
    _navigationService = _getIt.get<NavigationService>();
    _databaseService = _getIt.get<DatabaseServices>();

    // Fetch technicians when the widget initializes
    fetchBookedTechnicians();
  }

  void fetchBookedTechnicians() async {
    try {
      final fetchedTechnicians = await _databaseService.getBookedTechnicians(_authService.user!.uid);
      setState(() {
        technicians = fetchedTechnicians;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching technicians: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : technicians.isEmpty
            ? const Center(child: Text("No technicians found."))
            : _chatList(),
      ),
    );
  }

  Widget _chatList() {
    return ListView.builder(
      itemCount: technicians.length,
      itemBuilder: (context, index) {
        TechnicianProfile technician = technicians[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ChatTile(
            technicianProfile: technician, // TechnicianProfile passed here
            Ontap: () async {
              final chatExists = await _databaseService.checkChatexists(
                _authService.user!.uid,
                technician.tid!,
              );

              print("chat:$chatExists");

              if (!chatExists) {
                await _databaseService.createNewChat(
                  _authService.user!.uid,
                  technician.tid!,
                );
                print("chat created");
              }

              _navigationService.push(
                MaterialPageRoute(
                  builder: (context) {
                    return ChatPage(chatUser: technician);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
