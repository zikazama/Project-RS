import 'package:flutter/material.dart';
import 'dashboard_pasien.dart';

class HomeCare extends StatefulWidget {
  @override
  _HomeCareState createState() => _HomeCareState();
}

class _HomeCareState extends State<HomeCare> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFF7380F3),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      "HOME CARE",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 24.0),
                    ),
                  ),
                  SizedBox(height: 40),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(25.0),
                      margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.120),
                      width: MediaQuery.of(context).size.width * 0.950,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 30),
                          new TextField(
                              decoration: InputDecoration(
                                 prefixIcon: Icon(Icons.card_membership),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[800]),
                                  hintText: "Nama Pasien",
                                  fillColor: Colors.white70),
                            ),
                          SizedBox(height: 20),
                          new TextField(
                              decoration: InputDecoration(
                                 prefixIcon: Icon(Icons.phone_android),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[800]),
                                  hintText: "No.HP",
                                  fillColor: Colors.white70),
                            ),
                          SizedBox(height: 20),
                          new TextField(
                              decoration: InputDecoration(
                                 prefixIcon: Icon(Icons.edit_location),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[800]),
                                  hintText: "Lokasi",
                                  fillColor: Colors.white70),
                            ),
                          SizedBox(height: 20),
                          new TextField(
                              decoration: InputDecoration(
                                 prefixIcon: Icon(Icons.sick),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[800]),
                                  hintText: "Keluhan",
                                  fillColor: Colors.white70),
                            ),
                          SizedBox(height: 20),
                          new TextField(
                              decoration: InputDecoration(
                                 prefixIcon: Icon(Icons.local_hospital),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[800]),
                                  hintText: "Kondisi Saat Ini",
                                  fillColor: Colors.white70),
                            ),
                          SizedBox(height: 60),
                          new Container(
                            height: 50,
                            width: 300,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xFF7380F3),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(5.0))),
                              onPressed: () {},
                              child: Text('Pesan Layanan'),
                            ),
                          ),
                          SizedBox(height: 30),
                          new Container(
                            child: Container(
                                child: Center(
                                    child: TextButton(
                              onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashboardPasien()));
                              },
                              child: Text('Kembali',
                              style: TextStyle(color: const Color(0xFF7380F3), fontSize: 14.0),
                            ),
                            ))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}
