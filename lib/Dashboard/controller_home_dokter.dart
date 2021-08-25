import 'package:aplikasi_rs/Dashboard/konsultasi_online/konsultasi_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ControllerHomeDoctor extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> chatsStream(String nik) {
    return firestore
        .collection('users')
        .doc(nik)
        .collection("chats")
        .orderBy("lastTime", descending: true)
        .snapshots();
  }

  Stream<DocumentSnapshot> friendStream(String nik) {
    return firestore.collection('users').doc(nik).snapshots();
  }

 Future <void> goToChatRoom(String chatId, String nik, String friendNik) async {
    CollectionReference chats = firestore.collection('chats');
    CollectionReference users = firestore.collection('users');

    final updateStatusChat = await chats
        .doc(chatId)
        .collection("chat")
        .where("isRead", isEqualTo: false)
        .where("penerima", isEqualTo: nik)
        .get();

    updateStatusChat.docs.forEach((element) async {
      await chats
          .doc(chatId)
          .collection("chat")
          .doc(element.id)
          .update({"isRead": true});
    });

    await users
        .doc(nik)
        .collection("chats")
        .doc(chatId)
        .update({"total_unread": 0});

    Get.to(() => KonsultasiChat(), arguments: {
      "chat_id": "$chatId",
      "friendNik": friendNik
    });
  }
}