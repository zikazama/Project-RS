import 'dart:convert';
import 'dart:developer';

import 'package:aplikasi_rs/lupa_password.dart';
import 'package:aplikasi_rs/services/services.dart';
import 'package:flutter/material.dart';
import 'lupa_password.dart';
import 'registrasi_pasien.dart';
import 'package:http/http.dart' as http;
import 'package:aplikasi_rs/Dashboard/dashboard_pasien.dart';

class LoginPasien extends StatefulWidget {
  @override
  _LoginPasienState createState() => _LoginPasienState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginPasienState extends State<LoginPasien> {
  bool isHiddenPassword = true;

  bool _secureText = true;
  TextEditingController noKtp1 = new TextEditingController();
  TextEditingController pass1 = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  var dataPasien;
  Future<List> _login() async {
    final response = await http.post(
        'https://rsbmgeriatri.com/bhayangkara_geriatri/flutter/login.php',
        body: {"no_ktp": noKtp1.text, "password": pass1.text});
    // print(response.body);

    dataPasien = json.decode(response.body);
    if (dataPasien.length == 0) {
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
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DashboardPasien()));
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
                        return val.isEmpty || val.length == 16
                            ? 'Cek kembali NIK anda'
                            : null;
                      },
                      controller: noKtp1,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.card_membership),
                        hintText: 'Nomor KTP',
                      ),
                    ),
                    TextFormField(
                      controller: pass1,
                      validator: (val) {
                        return val.isEmpty || val.length < 6
                            ? 'Cek Password anda'
                            : null;
                      },
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
                                borderRadius: new BorderRadius.circular(5.0))),
                        onPressed: () {
                          if (formKey.currentState.validate()) {}
                          _login();
                        },
                        child: Text('Masuk'),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      child: Container(
                          child: Center(
                              child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()));
                        },
                        child: Text('Lupa Password'),
                      ))),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      height: 50,
                      width: 300,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            primary: const Color(0xFF000000),
                            backgroundColor: const Color(0xFFE7EEFE)),
                        // color:
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => RegistrasiPasien()));
                        },
                        child: Text('Buat Akun'),
                      ),
                    )
                  ],
                ),
              ),
            )
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
