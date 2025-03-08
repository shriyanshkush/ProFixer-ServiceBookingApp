
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/models/message_model.dart';
import 'package:profixer/models/tecnician_model.dart';

import '../../Services/auth_services.dart';
import '../../Services/database_services.dart';
import '../../models/message.dart';

class ChatPageTechnician extends StatefulWidget {
  final Map<String,String> chatUser;

  const ChatPageTechnician({super.key,required this.chatUser});
  @override
  State<StatefulWidget> createState() {
    return _ChatPagestate();
  }
}

class _ChatPagestate extends State<ChatPageTechnician > {
  ChatUser? currentuser,otheruser;
  final GetIt _getIt=GetIt.instance;
  late AuthServices _authservice;
  late DatabaseServices _databaseService;
  @override
  void initState() {
    super.initState();
    _authservice=_getIt.get<AuthServices>();
    _databaseService=_getIt.get<DatabaseServices>();

    currentuser=ChatUser(id: _authservice.user!.uid,
        firstName: _authservice.user!.displayName);

    otheruser=ChatUser(id: widget.chatUser["id"]!,
      firstName: widget.chatUser["name"]!,
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatUser["name"]!),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return StreamBuilder(stream: _databaseService.getChatData(
        currentuser!.id, otheruser!.id), builder: (context,snapshot) {
      MessageModel? chat= snapshot.data?.data();
      List<ChatMessage> messages=[];

      if(chat!=null && chat.messages!=null) {
        messages=_generateMessage(chat.messages!);
      }
      return DashChat(
          messageOptions: const MessageOptions(
            showOtherUsersAvatar: true,
            showTime: true,
          ),
          inputOptions: InputOptions(
            alwaysShowSend: true,
          ),
          currentUser: currentuser!,
          onSend: _sendMessage,
          messages: messages
      );

    });
  }

  Future<void> _sendMessage (ChatMessage chatMessage) async {
    if(chatMessage.medias?.isNotEmpty ?? false) {
      if(chatMessage.medias!.first.type==MediaType.image) {
        Message message=Message(senderID: chatMessage.user.id, content: chatMessage.medias!.first.url, messageType: MessageType.Image,
          sentAt:Timestamp.fromDate(chatMessage.createdAt),  );
        await _databaseService.sentChatMessage(currentuser!.id, otheruser!.id, message);
      }

    } else {
      Message message=Message(
          senderID: currentuser!.id,
          content: chatMessage.text,
          messageType: MessageType.Text,
          sentAt:Timestamp.fromDate(chatMessage.createdAt));
      await _databaseService.sentChatMessage(
          currentuser!.id, otheruser!.id, message);

    }

  }

  List <ChatMessage> _generateMessage(List<Message> messages) {
    List<ChatMessage> chatmessages=messages.map((m) {
      if(m.messageType==MessageType.Image) {
        return ChatMessage(user: m.senderID==currentuser!.id?currentuser! :otheruser!,
            createdAt: m.sentAt!.toDate(),
            medias: [ChatMedia(url: m.content! , fileName: "", type:MediaType.image)]);
      }
      else{
        return ChatMessage(user: m.senderID==currentuser!.id?currentuser! :otheruser!,
            text: m.content!,
            createdAt: m.sentAt!.toDate());
      }
    }).toList();
    chatmessages.sort((a,b) {
      return b.createdAt.compareTo(a.createdAt);
    });
    return chatmessages;
  }

}