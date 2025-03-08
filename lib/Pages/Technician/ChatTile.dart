import 'package:flutter/material.dart';
import 'package:profixer/models/tecnician_model.dart';

class ChatTile extends StatelessWidget {
  final Map<String,String> user;
  final Function Ontap;
  const ChatTile({super.key,required this.user,
  required this.Ontap,});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Ontap();
      },
      dense:false,
      leading: CircleAvatar(child: Icon(Icons.person_outline),),
      title: Text(user["name"]!),
    );
  }

}