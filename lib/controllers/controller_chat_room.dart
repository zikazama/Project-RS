import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ControllerChatRoom extends GetxController {
  var isShowEmoji = false.obs;
  int total_unread = 0;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FocusNode focusNode;
  TextEditingController chatC;
  ScrollController scrollController;

  Stream<QuerySnapshot> streamChats(String chatId) {
    CollectionReference chats = firestore.collection("chats");

    return chats.doc(chatId).collection("chat").orderBy("time").snapshots();
  }

  Stream<DocumentSnapshot> streamFriendData(String friendNik) {
    CollectionReference users = firestore.collection("users");

    return users.doc(friendNik).snapshots();
  }
  // void addEmojiToChat(Emoji emoji) {
  //   chatC.text = chatC.text + emoji.emoji;
  // }
  //
  // void deleteEmoji() {
  //   chatC.text = chatC.text.substring(0, chatC.text.length - 2);
  // }

  void newChat(String nik, Map<String, dynamic> argument, String chat) async {
    if (chat != "") {
      CollectionReference chats = firestore.collection("chats");
      CollectionReference users = firestore.collection("users");

      String date = DateTime.now().toIso8601String();

      await chats.doc(argument['chat_id']).collection("chat").add({
        "pengirim": nik,
        "penerima": argument['friendNik'],
        "msg": chat,
        "time": date,
        "isRead": false,
        "groupTime": DateFormat.yMMMMd('en_US').format(DateTime.parse(date))
      });

      Timer(
          Duration.zero,
          () => scrollController
              .jumpTo(scrollController.position.maxScrollExtent));

      chatC.clear();

      await users
          .doc(nik)
          .collection("chats")
          .doc(argument['chat_id'])
          .update({"lastTime": date});

      final checkChatsFriend = await users
          .doc(argument['friendNik'])
          .collection("chats")
          .doc(argument['chat_id'])
          .get();

      if (checkChatsFriend.exists) {
        print("EXIST ON FRIEND DB");
        print("FIRST CHECK TOTAL_UNREAD ");

        final checkTotalUnread = await chats
            .doc(argument['chat_id'])
            .collection("chat")
            .where("isRead", isEqualTo: false)
            .where("pengirim", isEqualTo: nik)
            .get();

        print("TOTAL UNREAD FOR FRIEND");
        total_unread = checkTotalUnread.docs.length;

        await users.doc(argument['friendNik']).collection("chats").doc(argument['chat_id']).update({
          "lastTime" : date, "total_unread" : total_unread
        });
      }else{
        print("NOT EXIST ON FRIEND DB");
        await users.doc(argument['friendNik']).collection("chats").doc(argument['chat_id']).set({
          "connection" : nik,
          "lastTime" : date,
          "total_unread" : 1
        });
      }
    }
  }

  @override
  void onInit() {
    chatC = TextEditingController();
    scrollController = ScrollController();
    focusNode = FocusNode();
    focusNode.addListener(() {
      if(focusNode.hasFocus){
        isShowEmoji.value = false;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    chatC.dispose();
    scrollController.dispose();
    focusNode.dispose();
    super.onClose();
  }

}
