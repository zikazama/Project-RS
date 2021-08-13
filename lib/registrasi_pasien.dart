import 'package:flutter/material.dart';
import 'login_pasien.dart';

class RegistrasiPasien extends StatefulWidget {
  @override
  _RegistrasiPasienState createState() => _RegistrasiPasienState();
}

class _RegistrasiPasienState extends State<RegistrasiPasien> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFF0068F7),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      "PENDAFTARAN\nPASIEN BARU",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 24.0),
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(25.0),
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.140),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          new TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Nama Lengkap',
                            ),
                          ),
                          SizedBox(height: 10),
                          new TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone),
                              hintText: 'Nomor HP',
                            ),
                          ),
                          SizedBox(height: 10),
                          new TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.date_range),
                              hintText: 'Tanggal Lahir',
                            ),
                          ),
                          SizedBox(height: 10),
                          new TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.card_membership),
                              hintText: 'Nomor KTP',
                            ),
                          ),
                          SizedBox(height: 10),
                          new TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.mail),
                              hintText: 'Email',
                            ),
                          ),
                          SizedBox(height: 10),
                          new TextField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.vpn_key),
                                hintText: 'Password',
                                suffixIcon: InkWell(
                                  child: Icon(Icons.visibility_off),
                                )),
                          ),
                          SizedBox(height: 10),
                          new TextField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.vpn_key),
                                hintText: 'Konfirmasi Password',
                                suffixIcon: InkWell(
                                  child: Icon(Icons.visibility_off),
                                )),
                          ),
                          SizedBox(height: 25),
                          new Container(
                            height: 50,
                            width: 300,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(5.0))),
                              onPressed: () {},
                              child: Text('Daftar'),
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
                                        builder: (context) => LoginPasien()));
                              },
                              child: Text('Kembali'),
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
