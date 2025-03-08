import 'package:flutter/material.dart';
import 'package:profixer/models/tecnician_model.dart';

class ChatTile extends StatelessWidget {
  final TechnicianProfile technicianProfile;
  final Function Ontap;
  const ChatTile({super.key,required this.technicianProfile,
  required this.Ontap,});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Ontap();
      },
      dense:false,
      leading: CircleAvatar(backgroundImage: NetworkImage(technicianProfile.pfpURL!)),
      title: Text(technicianProfile.name!),
    );
  }

}