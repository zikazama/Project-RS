import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginDokter extends StatefulWidget {
  @override
  _LoginDokterState createState() => _LoginDokterState();
}

class _LoginDokterState extends State<LoginDokter> {
  bool isHiddenPassword = true;
  TextEditingController ktp = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  var dataDokter;
  Future<List> _login() async {
    final response = await http.post(
        'https://rsbmgeriatri.com/bhayangkara_geriatri/flutter/login_dokter.php',
        body: {"no_ktp": ktp.text, "password": pass.text});
    // print(response.body);

    dataDokter = json.decode(response.body);
    if (dataDokter.length == 0) {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text("NIK atau Kata sandi anda salah"),
                    Text("Mohon untuk diperiksa Kembali")
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Periksa"))
              ],
            );
          });
    } else {
      print("Login Berhasil");
      print("Selamat Datang " + dataDokter[0]['nama_dokter'].toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: new Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/wave.png'),
                fit: BoxFit.cover,
              )),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 100),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/rsbm1.png'))),
                    ),
                  ),
                  Positioned(
                      child: Container(
                          margin: EdgeInsets.only(top: 200),
                          child: Center(
                              child: Text(
                            "SELAMAT DATANG DI APLIKASI\nMOBILE BHAYANGKARA GERIATRI",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ))))
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.all(25.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        validator: (val) {
                          return val.isEmpty || val.length != 16
                              ? 'Cek kembali NIK anda'
                              : null;
                        },
                        controller: ktp,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.card_membership),
                          hintText: 'Nomor KTP',
                        ),
                      ),
                      TextFormField(
                        validator: (val) {
                          return val.isEmpty || val.length < 6
                              ? 'Cek Password anda'
                              : null;
                        },
                        controller: pass,
                        obscureText: isHiddenPassword,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.vpn_key),
                            hintText: 'Password',
                            suffixIcon: InkWell(
                              onTap: _togglePasswordView,
                              child: Icon(Icons.visibility_off),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 25),
                      ),
                      Container(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(5.0))),
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              _login();
                            }
                          },
                          child: Text('Masuk'),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void _togglePasswordView() {
    if (isHiddenPassword == true) {
      isHiddenPassword = false;
    } else {
      isHiddenPassword = true;
    }
    setState(() {});
  }
}
