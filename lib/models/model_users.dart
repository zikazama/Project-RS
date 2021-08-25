// To parse this JSON data, do
//
//     final modelUsers = modelUsersFromJson(jsonString);

import 'dart:convert';

ModelUsers modelUsersFromJson(String str) => ModelUsers.fromJson(json.decode(str));

String modelUsersToJson(ModelUsers data) => json.encode(data.toJson());

class ModelUsers {
  ModelUsers({
    this.uid,
    this.name,
    this.nik,
    this.creationTime,
    this.chats,
  });

  String uid;
  String name;
  String nik;
  String creationTime;
  List<ChatUsers> chats;

  factory ModelUsers.fromJson(Map<String, dynamic> json) => ModelUsers(
    uid: json["uid"] == null ? null : json["uid"],
    name: json["name"] == null ? null : json["name"],
    nik: json["nik"] == null ? null : json["nik"],
    creationTime: json["creationTime"] == null ? null : json["creationTime"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid == null ? null : uid,
    "name": name == null ? null : name,
    "nik": nik == null ? null : nik,
    "creationTime": creationTime == null ? null : creationTime,
    "chats": chats == null ? null : List<dynamic>.from(chats.map((x) => x.toJson())),
  };
}

class ChatUsers {
  ChatUsers({
    this.connection,
    this.chatId,
    this.lastTime,
    this.totalUnread,
  });

  String connection;
  String chatId;
  String lastTime;
  int totalUnread;

  factory ChatUsers.fromJson(Map<String, dynamic> json) => ChatUsers(
    connection: json["connection"] == null ? null : json["connection"],
    chatId: json["chat_id"] == null ? null : json["chat_id"],
    lastTime: json["lastTime"] == null ? null : json["lastTime"],
    totalUnread: json["total_unread"] == null ? null : json["total_unread"],
  );

  Map<String, dynamic> toJson() => {
    "connection": connection == null ? null : connection,
    "chat_id": chatId == null ? null : chatId,
    "lastTime": lastTime == null ? null : lastTime,
    "total_unread": totalUnread == null ? null : totalUnread,
  };
}
