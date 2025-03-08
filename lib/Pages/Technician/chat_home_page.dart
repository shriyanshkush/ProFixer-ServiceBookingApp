import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/Pages/Technician/ChatTile.dart';
import 'package:profixer/Services/auth_services.dart';
import 'package:profixer/Services/Alert_services.dart';
import 'package:profixer/Services/Navigation_services.dart';
import 'package:profixer/Services/database_services.dart';
import 'package:profixer/models/tecnician_model.dart';
import 'chat_page.dart';

class ChatHomepageTechnician extends StatefulWidget {
  const ChatHomepageTechnician({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomepageState();
  }
}

class _HomepageState extends State<ChatHomepageTechnician> {
  final GetIt _getIt = GetIt.instance;
  late NavigationService _navigationService;
  late AuthServices _authService;
  late DatabaseServices _databaseService;

  List<Map<String,String>> users = [];
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
      final fetchedUsers = await _databaseService.getBookingListTechnicianUser(_authService.user!.uid);
      setState(() {
        users = fetchedUsers;
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
            : users.isEmpty
            ? const Center(child: Text("No technicians found."))
            : _chatList(),
      ),
    );
  }

  Widget _chatList() {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        Map<String,String> user = users[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ChatTile(
            user: user, // TechnicianProfile passed here
            Ontap: () async {
              final chatExists = await _databaseService.checkChatexists(
                _authService.user!.uid,
                user["id"]!,
              );

              if (!chatExists) {
                await _databaseService.createNewChat(
                  _authService.user!.uid,
                  user["id"]!,
                );
              }

              _navigationService.push(
                MaterialPageRoute(
                  builder: (context) {
                    return ChatPageTechnician(chatUser: user);
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
