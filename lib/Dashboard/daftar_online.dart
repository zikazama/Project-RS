import 'package:aplikasi_rs/Dashboard/dashboard_pasien.dart';
import 'package:flutter/material.dart';

class PendaftaranOnline extends StatefulWidget {
  @override
  PendaftaranOnlineState createState() => PendaftaranOnlineState();
}

class PendaftaranOnlineState extends State<PendaftaranOnline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              bottom:
                                  MediaQuery.of(context).size.height * 0.120),
                          child: Center(
                            child: Text(
                              "Pendaftaran Online",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ))
                      ],
                    ),
                  ))
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 15),
                margin: const EdgeInsets.only(bottom: 40, left: 24, right: 24),
                child: Form(
                    child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.date_range),
                          hintText: "Tanggal Periksa"),
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField(
                      items: [],
                      hint: Text('Pilih Dokter'),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.local_hospital_rounded)),
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField(
                      items: [],
                      hint: Text('Cara Bayar'),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.payment_rounded)),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.camera_alt),
                          hintText: "Upload Foto BPJS"),
                    ),
                    SizedBox(height: 50),
                    new Container(
                      height: 50,
                      width: 300,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0))),
                        onPressed: () {},
                        child: Text('Kirim'),
                      ),
                    ),
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
                            style: TextStyle(color: Colors.grey)),
                      ))),
                    ),
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
