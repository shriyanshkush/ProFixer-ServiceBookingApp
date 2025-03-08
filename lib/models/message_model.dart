import 'message.dart';

class MessageModel {
  final String chatId;
  final String senderId;
  final String recieverId;
  List<Message>? messages;

  MessageModel({
    required this.chatId,
    required this.senderId,
    required this.recieverId,
    required this.messages,
  });

  // Method to convert a message from JSON format to MessageModel
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      chatId: json['chatId'],
      senderId: json['senderId'],
      recieverId: json['recieverId'],
      messages: List.from(json['messages']).map((m) => Message.fromJson(m)).toList(),
    );
  }

  // Method to convert MessageModel to JSON format
  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'senderId': senderId,
      'recieverId':recieverId,
      'messages': messages,
    };
  }
}
