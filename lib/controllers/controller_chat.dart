import 'package:aplikasi_rs/Dashboard/konsultasi_online/konsultasi_chat.dart';
import 'package:aplikasi_rs/models/model_users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ControllerChat extends GetxController {
  var user = ModelUsers().obs;
  var chatId;
  Future<void> addNewConnection(String currentNik, String friendNik) async {
    bool flagNewCoonnection = false;
    String date = DateTime.now().toIso8601String();

    //MEMBUAT COLLECTION USER DAN CHATS
    CollectionReference chats =
        FirebaseFirestore.instance.collection("chats"); //Collection chat
    CollectionReference users =
        FirebaseFirestore.instance.collection("users"); //Collection users

    //AMBIL DOC DARI COLLECTION FIREBASE
    // final docUser = await users.doc(currentNik).get();
    final docChats = await users.doc(currentNik).collection("chats").get();

    if (docChats.docs.length != 0) {
      //USER SUDAH PERNAH CHAT DENGAN SIAPAPUN
      print("USER SUDAH PERNAH CHAT DENGAN SIAPAPUN");
      final checkConnection = await users.doc(currentNik).collection("chats").where("connection", isEqualTo: friendNik).get();

      if(checkConnection.docs.length != 0){
        print("USER SUDAH PERNAH CHAT DENGAN $friendNik");
        //SUDAH PERNAH BUAT KONEKSI DENGAN => friendNik
        flagNewCoonnection = false;
        chatId = checkConnection.docs[0].id;
      }else{
        print("USER BELUM PERNAH CHAT DENGAN $friendNik");
        //BELUM PERNAH BUAT KONEKSI DENGAN => friendNik
        flagNewCoonnection = true;
      }
      // docChats.forEach((elementChat) {
      //   print("elementChat : " +elementChat.toString());
      //   if (elementChat['connection'] == friendNik) {
      //     chatId = elementChat['chat_id'];
      //   }
      // });
      //
      // if (chatId != null) {
      //
      // } else {
      //   print("USER BELUM PERNAH CHAT DENGAN $friendNik");
      //   //BELUM PERNAH BUAT KONEKSI DENGAN => friendNik
      //   flagNewCoonnection = true;
      // }
    } else {
      print("USER BELUM PERNAH CHAT DENGAN SIAPAPUN");
      //USER BELUM PERNAH CHAT DENGAN SIAPAPUN
      //BUAT CONNECTION
      flagNewCoonnection = true;
    }

    if (flagNewCoonnection) {
      print("BELUM PERNAH SALING CHAT");
      //CEK DARI CHATS COLLECTION => connections => mereka berdua
      final chatsDocs = await chats.where("connections", whereIn: [
        [currentNik, friendNik],
        [friendNik, currentNik]
      ]).get();

      if (chatsDocs.docs.length != 0) {
        //TERDAPAT DATA CHAT
        print("TERDAPAT DATA CHAT SEBELUMNYA");
        final chatDataId = chatsDocs.docs[0].id;
        final chatsData = chatsDocs.docs[0].data();

        await users.doc(currentNik).collection("chats").doc(chatDataId).set({
          "connection": friendNik,
          "lastTime": chatsData['lastTime'],
          "total_unread": 0,
        });

        final listChats = await users.doc(currentNik).collection("chats").get();
        print("PANJANG LIST CHAT YANG ADA : " +listChats.docs.length.toString());
        var data = List.of(listChats.docs);

        if(data.length != 0){
          List<ChatUsers> dataListChats = [];
          print("PANJANG LIST CHAT YANG ADA : " +data.length.toString());
          data.forEach((element) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;
            dataListChats.add(ChatUsers(
              chatId: dataDocChatId,
              connection: dataDocChat['connection'],
              lastTime: dataDocChat['lastTime'],
              totalUnread: dataDocChat['total_unread'],
            ));
          });
          user.update((val) {
            val.chats = dataListChats;
          });
        }else{
          user.update((val) {
            val.chats = [];
          });
        }

        // //TAMBAHKAN CHAT
        // docChats.add({
        //   "connection": friendNik,
        //   "chat_id": chatDataId,
        //   "lastTime": chatsData['lastTime']
        // });
        //
        // await users.doc(currentNik).update({"chats": docChats});
        //
        // //UPDATE USERS
        // user.update((valUser) {
        //   valUser.chats = [
        //     ChatUsers(
        //         chatId: chatDataId,
        //         connection: friendNik,
        //         lastTime: chatsData['lastTime'])
        //   ];
        // });

        chatId = chatDataId;
        user.refresh();
      } else {
        //BUAT BARU CHAT
        print("BUAT CHAT BARU");
        final newChatDoc = await chats.add({
          "connections": [currentNik, friendNik],
          // "chat": [],
          // "lastTime": date
        });

        // docChats.add({
        //   "connection": friendNik,
        //   "chat_id": newChatDoc.id,
        //   "lastTime": date
        // });

        await chats.doc(newChatDoc.id).collection("chat");

        await users.doc(currentNik).collection("chats").doc(newChatDoc.id).set({
          "connection":friendNik,
          "lastTime": date,
          "total_unread": 0,
        });

        final listChats = await users.doc(currentNik).collection("chats").get();

        if(listChats.docs.length != 0){
          List<ChatUsers> dataListChats = [];
          var data = List.of(listChats.docs);
          data.forEach((element) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;
            dataListChats.add(ChatUsers(
              chatId: dataDocChatId,
              connection: dataDocChat['connection'],
              lastTime: dataDocChat['lastTime'],
              totalUnread: dataDocChat['total_unread'],
            ));
          });
          user.update((val) {
            val.chats = dataListChats;
          });
        }else{
          user.update((val) {
            val.chats = [];
          });
        }

        // await users.doc(currentNik).update({"chats": docChats});

        // //UPDATE USERS
        // user.update((valUser) {
        //   valUser.chats = [
        //     ChatUsers(
        //         chatId: newChatDoc.id, connection: friendNik, lastTime: date)
        //   ];
        // });

        chatId = newChatDoc.id;
        user.refresh();
      }
    }

    print("chat id : " + chatId.toString());

    final updateStatusChat = await chats
        .doc(chatId)
        .collection("chat")
        .where("isRead", isEqualTo: false)
        .where("penerima", isEqualTo: currentNik)
        .get();

    updateStatusChat.docs.forEach((element) async {
      await chats
          .doc(chatId)
          .collection("chat")
          .doc(element.id)
          .update({"isRead": true});
    });

    await users
        .doc(currentNik)
        .collection("chats")
        .doc(chatId)
        .update({"total_unread": 0});

    Get.to(() => KonsultasiChat(), arguments: {
      "chat_id" : "$chatId",
      "friendNik" : friendNik
    });
  }
}
