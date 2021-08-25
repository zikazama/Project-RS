// To parse this JSON data, do
//
//     final modelChats = modelChatsFromJson(jsonString);

import 'dart:convert';

ModelChats modelChatsFromJson(String str) => ModelChats.fromJson(json.decode(str));

String modelChatsToJson(ModelChats data) => json.encode(data.toJson());

class ModelChats {
  ModelChats({
    this.connections,
    this.chat,
  });

  List<String> connections;
  List<Chat> chat;

  factory ModelChats.fromJson(Map<String, dynamic> json) => ModelChats(
    connections: json["connections"] == null ? null : List<String>.from(json["connections"].map((x) => x)),
    chat: json["chat"] == null ? null : List<Chat>.from(json["chat"].map((x) => Chat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "connections": connections == null ? null : List<dynamic>.from(connections.map((x) => x)),
    "chat": chat == null ? null : List<dynamic>.from(chat.map((x) => x.toJson())),
  };
}

class Chat {
  Chat({
    this.pengirim,
    this.penerima,
    this.pesan,
    this.time,
    this.isRead,
  });

  String pengirim;
  String penerima;
  String pesan;
  DateTime time;
  bool isRead;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    pengirim: json["pengirim"] == null ? null : json["pengirim"],
    penerima: json["penerima"] == null ? null : json["penerima"],
    pesan: json["pesan"] == null ? null : json["pesan"],
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    isRead: json["isRead"] == null ? null : json["isRead"],
  );

  Map<String, dynamic> toJson() => {
    "pengirim": pengirim == null ? null : pengirim,
    "penerima": penerima == null ? null : penerima,
    "pesan": pesan == null ? null : pesan,
    "time": time == null ? null : time.toIso8601String(),
    "isRead": isRead == null ? null : isRead,
  };
}
