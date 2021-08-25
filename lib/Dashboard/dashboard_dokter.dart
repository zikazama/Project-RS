import 'package:aplikasi_rs/Dashboard/controller_home_dokter.dart';
import 'package:aplikasi_rs/controllers/controller_chat.dart';
import 'package:aplikasi_rs/controllers/controller_dokter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

class DashboardDokter extends StatefulWidget {
  @override
  _DashboardDokterState createState() => _DashboardDokterState();
}

class _DashboardDokterState extends State<DashboardDokter> {
  ControllerChat controllerChat = Get.find<ControllerChat>();
  ControllerDokter controllerDokter = Get.find<ControllerDokter>();
  ControllerHomeDoctor controllerHomeDoctor = Get.find<ControllerHomeDoctor>();


  bool loading = false;

  _onLoading() => setState(() => loading = true);
  _offLoading() => setState(() => loading = false);

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: loading,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Container(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Positioned(
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image:
                            AssetImage('assets/images/wave_Dashboard_Dokter.png'),
                        fit: BoxFit.fill,
                      )),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 30.0),
                                  margin: EdgeInsets.only(
                                      bottom: MediaQuery.of(context).size.height *
                                          0.120),
                                  child: Text(
                                    "Selamat Datang Dokter",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ))),
                          Positioned(
                              child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.only(right: 20.0),
                              margin: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.100),
                              child: Icon(
                                Icons.notifications,
                                color: Colors.white,
                                size: 33,
                              ),
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Text("Riwayat Konsultasi Dengan Pasien",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
              SizedBox(height: 24),
              Container(
                margin: const EdgeInsets.only(left: 24.0, right: 24.0),
                padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: -1,
                      blurRadius: 21,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.search_rounded,
                      color: const Color(0xFF8F8F8F),
                      size: 30,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: TextField(
                            style: TextStyle(fontSize: 17),
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              hintText: 'Cari Pasien',
                              hintStyle: TextStyle(fontSize: 17),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ))),
                  ],
                ),
              ),
              // Expanded(
              //   child: Container(
              //     margin: const EdgeInsets.only(top: 25),
              //     // child: InboxDokter(),
              //     child: InkWell(
              //       onTap: (){
              //         controllerChat.addNewConnection(controllerDokter.dokter.value.noKtp, "1234567891234567");
              //       },
              //       child: Container(
              //         color: Colors.red,
              //         height: 50,
              //         width: Get.width,
              //         child: Center(child: Text("Pasien"),),
              //       ),
              //     ),
              //   ),
              // )
              SizedBox(height: 20,),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: controllerHomeDoctor.chatsStream(controllerChat.user.value.nik),
                  builder: (context, snapshot1) {
                    if (snapshot1.connectionState == ConnectionState.active) {
                      var listDocsChats = snapshot1.data.docs;
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: listDocsChats.length,
                        itemBuilder: (context, index) {
                          return StreamBuilder<
                              DocumentSnapshot>(
                            stream: controllerHomeDoctor
                                .friendStream(listDocsChats[index]["connection"]),
                            builder: (context, snapshot2) {
                              if (snapshot2.connectionState ==
                                  ConnectionState.active) {
                                var data = snapshot2.data.data();
                                return Container(
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      index==0?Divider():SizedBox(),
                                      ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 5,
                                        ),
                                        onTap: ()async {
                                          _onLoading();
                                          await controllerHomeDoctor.goToChatRoom(
                              "${listDocsChats[index].id}",
                              controllerChat.user.value.nik,
                              listDocsChats[index]["connection"],
                              ).then((value) => _offLoading()).catchError((e){
                                _offLoading();
                                Get.snackbar("error", e.toString(), backgroundColor: Colors.yellow);
                                          });
                              },
                                        leading: CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.black26,
                                        ),
                                        title: Text(
                                          "${data["name"]}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        trailing: listDocsChats[index]
                                        ["total_unread"] ==
                                            0
                                            ? SizedBox()
                                            : Chip(
                                          backgroundColor: Colors.greenAccent,
                                          label: Text(
                                            "${listDocsChats[index]["total_unread"]}",
                                            style: TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                );

                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                        },
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InboxDokter extends StatefulWidget {
  @override
  _InboxDokterState createState() => _InboxDokterState();
}

class _InboxDokterState extends State<InboxDokter> {
  //data dabbing
  List userDokter = [
    {
      'name': 'Susanto',
      'Status': 'Dokter spesialis THT',
    },
    {
      'name': 'Susanti',
      'Status': 'Dokter spesialis penyakit dalam',
    },
    {
      'name': 'Ginting',
      'Status': 'Dokter spesialis HTH',
    },
    {
      'name': 'Tes',
      'Status': 'Dokter spesialis beda',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //physics: NeverScrollableScrollPhysics(),
      itemCount: userDokter.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.only(left: 15, bottom: 15, top: 15),
          // margin: const EdgeInsets.only(bottom: 40, left: 24, right: 24),
          height: 90,
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(width: 1.0, color: Color(0xFF000000)),
          )),
          child: Row(
            children: <Widget>[
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(50)),
              ),
              SizedBox(
                width: 14,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Dr. ${userDokter[index]['name']}',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    userDokter[index]['Status'],
                    style: TextStyle(fontSize: 14),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
