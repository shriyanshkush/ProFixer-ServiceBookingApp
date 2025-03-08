
String GenerateChatID ({required String uid1, required String uid2}) {
  List<String> uids = [uid1, uid2];
  uids.sort();
  String chatID = uids.fold("", (id, uid) => "$id$uid");
  return chatID;
}