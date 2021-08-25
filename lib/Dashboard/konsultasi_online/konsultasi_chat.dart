import 'dart:async';

import 'package:aplikasi_rs/config/theme.dart';
import 'package:aplikasi_rs/controllers/controller_chat.dart';
import 'package:aplikasi_rs/controllers/controller_chat_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class KonsultasiChat extends StatefulWidget {
  @override
  _KonsultasiChatState createState() => _KonsultasiChatState();
}

class _KonsultasiChatState extends State<KonsultasiChat> {
  ControllerChat controllerChat = Get.find<ControllerChat>();
  ControllerChatRoom controllerChatRoom = Get.find<ControllerChatRoom>();
  final String chatId = (Get.arguments as Map<String, dynamic>)["chat_id"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        leadingWidth: 100,
        leading: InkWell(
          onTap: () => Get.back(),
          borderRadius: BorderRadius.circular(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 5),
              Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              SizedBox(width: 5),
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                // child: StreamBuilder<DocumentSnapshot>(
                //   stream: controllerChatRoom.streamFriendData(
                //       (Get.arguments as Map<String, dynamic>)["friendEmail"]),
                //   builder: (context, snapFriendUser) {
                //     if (snapFriendUser.connectionState ==
                //         ConnectionState.active) {
                //       var dataFriend =
                //       snapFriendUser.data.data() as Map<String, dynamic>;
                //
                //       if (dataFriend["photoUrl"] == "noimage") {
                //         return ClipRRect(
                //           borderRadius: BorderRadius.circular(50),
                //           child: Image.asset(
                //             "assets/logo/noimage.png",
                //             fit: BoxFit.cover,
                //           ),
                //         );
                //       } else {
                //         return ClipRRect(
                //           borderRadius: BorderRadius.circular(50),
                //           child: Image.network(
                //             dataFriend["photoUrl"],
                //             fit: BoxFit.cover,
                //           ),
                //         );
                //       }
                //     }
                //     return ClipRRect(
                //       borderRadius: BorderRadius.circular(50),
                //       child: Image.asset(
                //         "assets/logo/noimage.png",
                //         fit: BoxFit.cover,
                //       ),
                //     );
                //   },
                // ),
              ),
            ],
          ),
        ),
        title: StreamBuilder<DocumentSnapshot>(
          stream: controllerChatRoom.streamFriendData(
              (Get.arguments as Map<String, dynamic>)["friendNik"]),
          builder: (context, snapFriendUser) {
            if (snapFriendUser.connectionState == ConnectionState.active) {
              var dataFriend =
              snapFriendUser.data.data() as Map<String, dynamic>;
              print("data friend : " + dataFriend.toString());
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dataFriend["name"],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  // Text(
                  //   dataFriend["status"],
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     color: Colors.white,
                  //   ),
                  // ),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            );
          },
        ),
        centerTitle: false,
      ),
      body: WillPopScope(
        onWillPop: () {
          if (controllerChatRoom.isShowEmoji.isTrue) {
            controllerChatRoom.isShowEmoji.value = false;
          } else {
            Navigator.pop(context);
          }
          return Future.value(false);
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: controllerChatRoom.streamChats(chatId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      var alldata = snapshot.data.docs;
                      Timer(
                        Duration.zero,
                            () => controllerChatRoom.scrollController.jumpTo(
                            controllerChatRoom.scrollController.position.maxScrollExtent),
                      );
                      return ListView.builder(
                        controller: controllerChatRoom.scrollController,
                        itemCount: alldata.length,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Column(
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  "${alldata[index]["groupTime"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ItemChat(
                                  msg: "${alldata[index]["msg"]}",
                                  isSender: alldata[index]["pengirim"] ==
                                      controllerChat.user.value.nik
                                      ? true
                                      : false,
                                  time: "${alldata[index]["time"]}",
                                ),
                              ],
                            );
                          } else {
                            if (alldata[index]["groupTime"] ==
                                alldata[index - 1]["groupTime"]) {
                              return ItemChat(
                                msg: "${alldata[index]["msg"]}",
                                isSender: alldata[index]["pengirim"] ==
                                    controllerChat.user.value.nik
                                    ? true
                                    : false,
                                time: "${alldata[index]["time"]}",
                              );
                            } else {
                              return Column(
                                children: [
                                  Text(
                                    "${alldata[index]["groupTime"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  ItemChat(
                                    msg: "${alldata[index]["msg"]}",
                                    isSender: alldata[index]["pengirim"] ==
                                        controllerChat.user.value.nik
                                        ? true
                                        : false,
                                    time: "${alldata[index]["time"]}",
                                  ),
                                ],
                              );
                            }
                          }
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: controllerChatRoom.isShowEmoji.isTrue
                    ? 5
                    : context.mediaQueryPadding.bottom,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      child: TextField(
                        autocorrect: false,
                        controller: controllerChatRoom.chatC,
                        focusNode: controllerChatRoom.focusNode,
                        onEditingComplete: () => controllerChatRoom.newChat(
                          controllerChat.user.value.nik,
                          Get.arguments as Map<String, dynamic>,
                          controllerChatRoom.chatC.text,
                        ),
                        decoration: InputDecoration(
                          // prefixIcon: IconButton(
                          //   onPressed: () {
                          //     controllerChatRoom.focusNode.unfocus();
                          //     controllerChatRoom.isShowEmoji.toggle();
                          //   },
                          //   icon: Icon(Icons.emoji_emotions_outlined),
                          // ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Material(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () => controllerChatRoom.newChat(
                        controllerChat.user.value.nik,
                        Get.arguments as Map<String, dynamic>,
                        controllerChatRoom.chatC.text,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemChat extends StatelessWidget {
  const ItemChat({
    Key key,
    @required this.isSender,
    @required this.msg,
    @required this.time,
  }) : super(key: key);

  final bool isSender;
  final String msg;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment:
        isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isSender? AppColor.primaryColor : Colors.white,
              borderRadius: !isSender
                  ? BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              )
                  : BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            padding: EdgeInsets.all(15),
            child: Text(
              "$msg",
              style: TextStyle(
                color: isSender?Colors.white : Colors.black,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(DateFormat.jm().format(DateTime.parse(time))),
        ],
      ),
      alignment: isSender ? Alignment.centerLeft : Alignment.centerRight,
    );
  }
}