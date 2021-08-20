import 'package:aplikasi_rs/Dashboard/dashboard_pasien.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      image: AssetImage('assets/images/wave_chat.png'),
                      fit: BoxFit.fill,
                    )),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                            child: Container(
                                margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.120),
                                child: Center(
                                    child: Text(
                                  "Konsultasi Online",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                )))),
                        Positioned(
                            child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashboardPasien()));
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 20.0),
                            margin: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).size.height * 0.100),
                            child: Icon(
                              Icons.arrow_back_rounded,
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
                            hintText: 'Cari Dokter',
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
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 25),
                child: Inbox(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
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
          padding: const EdgeInsets.only(left: 15),
          margin: const EdgeInsets.only(bottom: 40, left: 24, right: 24),
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: -1,
                blurRadius: 20,
                offset: Offset(0, 0),
              ),
            ],
          ),
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
