import 'dart:convert';

import 'package:aplikasi_rs/controllers/controllers.dart';
import 'package:aplikasi_rs/helpers/shared_preferences.dart';
import 'package:aplikasi_rs/lupa_password.dart';
import 'package:aplikasi_rs/models/model_pasien.dart';
import 'package:aplikasi_rs/registrasi_pasien.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'lupa_password.dart';
import 'package:aplikasi_rs/Dashboard/dashboard_pasien.dart';

class LoginPasien extends StatefulWidget {
  @override
  _LoginPasienState createState() => _LoginPasienState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginPasienState extends State<LoginPasien> {
  final ControllerPasien controllerPasien = Get.find<ControllerPasien>();
  final ControllerChat controllerChat = Get.find<ControllerChat>();
  bool isHiddenPassword = true;

  bool _secureText = true;
  TextEditingController noKtp = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  bool logged = false;

  _getPrefs() async {
    final check = await SharedPreferencesHelper.getStringValuesSF('noKtp');
    if (check != '') {
      noKtp.text = await SharedPreferencesHelper.getStringValuesSF('noKtp');
      pass.text = await SharedPreferencesHelper.getStringValuesSF('pass');
      setState(() {
        logged = true;
      });
    }
  }

  _autoLogin() async {
    await _getPrefs();
    if (logged) {
      _login();
    }
  }

  @override
  void initState() {
    super.initState();
    // _autoLogin();
  }

  onLoading() {
    setState(() {
      loading = true;
    });
  }

  offLoading() {
    setState(() {
      loading = false;
    });
  }

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  var dataPasien;
  Future<List> _login() async {
    onLoading();
    return await controllerPasien
        .loginPasienController(no_ktp: noKtp.text, password: pass.text)
        .then((value) async {
      print("value ui " + value.toString());
      if (value != null) {
        if (value['status'] == true) {
          controllerPasien.pasien.value =
              modelPasienFromJson(jsonEncode(value['user']));
          controllerChat.user.update((val) {
            val.uid = controllerPasien.pasien.value.idPasien;
            val.name = controllerPasien.pasien.value.namaLengkap;
            val.nik = controllerPasien.pasien.value.noKtp;
            val.creationTime = controllerPasien.pasien.value.createdAt;
          });
          controllerChat.user.refresh();
          print("nama_lengkap" + controllerPasien.pasien.value.namaLengkap);
          print("nama user : " + controllerChat.user.value.name);
          //CEK DOC USER DI FIREBASE
          CollectionReference users =
              FirebaseFirestore.instance.collection("users");
          final checkUser =
              await users.doc(controllerChat.user.value.nik).get();
          if (checkUser.data() == null) {
            await users.doc(controllerChat.user.value.nik).set({
              "uid": controllerChat.user.value.uid,
              "name": controllerChat.user.value.name,
              "nik": controllerChat.user.value.nik,
              "creationTime": controllerChat.user.value.creationTime,
              "status": "Offline"
            });
          }
          SharedPreferencesHelper.addStringToSF('noKtp', noKtp.text);
          SharedPreferencesHelper.addStringToSF('pass', pass.text);
          SharedPreferencesHelper.addStringToSF('role', 'pasien');
          offLoading();

          Get.to(() => DashboardPasien());
        } else {
          offLoading();

          Get.defaultDialog(title: "Info", content: Text(value['message']));
        }
      }

      offLoading();
    }).catchError((e) {
      offLoading();
      print("error ui " + e.toString());
      Get.snackbar("error", e.toString(), backgroundColor: Colors.red);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: loading,
      child: Scaffold(
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
                        controller: noKtp,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.card_membership),
                          hintText: 'Nomor KTP',
                        ),
                      ),
                      TextFormField(
                        controller: pass,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegistrasiPasien()));
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
