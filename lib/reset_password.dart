import 'package:aplikasi_rs/mainscreen.dart';
import 'package:aplikasi_rs/registrasi_pasien.dart';
import 'package:aplikasi_rs/services/auth_services.dart';
import 'package:aplikasi_rs/services/pasien_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ResetPassword extends StatefulWidget {
  final String email;

  ResetPassword({@required this.email});
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  bool hidePass = true;
  TextEditingController passC = TextEditingController();

  _onLoading() {
    setState(() {
      loading = true;
    });
  }

  _offLoading() {
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // this.initDynamicLink();
    print("woy");
    super.initState();
  }

  // void initDynamicLink() async {
  //   FirebaseDynamicLinks.instance.onLink(
  //       onSuccess: (PendingDynamicLinkData dynamicLinkData) async {
  //     final Uri deepLink = dynamicLinkData.link;
  //     print("dynamiclink ditemukan");
  //     if (deepLink != null) {
  //       print(deepLink);

  //       Get.to(() => RegistrasiPasien());
  //     }
  //   }, onError: (OnLinkErrorException e) async {
  //     print("deeplink error");
  //     print(e.message);
  //   });
  // }

  _resetPassword() async {
    _onLoading();
    try {
      print("email = " + widget.email);
      print("pass = " + passC.text);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: widget.email, password: passC.text);
      print(userCredential.user);
      if (userCredential.user != null) {
        print("lanjut ubah pass db");
        await PasienServices()
            .resetPassword(email: widget.email, newPass: passC.text)
            .then((value) async {
          print("value ui reset pass db : " + value.toString());
          if (value['status'] == true) {
            print("berhasil ubah password db");
            _offLoading();
            Get.defaultDialog(
                barrierDismissible: false,
                title: 'Berhasil',
                middleText: 'Ingat baik baik password anda',
                onConfirm: () {
                  Get.offAll(() => MainScreen());
                });
          } else {
            _offLoading();
            Get.defaultDialog(title: "Error", middleText: value['message']);
          }
        }).catchError((e) {
          _offLoading();
          Get.snackbar("error", e.toString(), backgroundColor: Colors.red);
        });
      } else {
        _offLoading();
        print("gagal login karena user " + userCredential.toString());
      }
      _offLoading();
    } on FirebaseAuthException catch (e) {
      _offLoading();
      print(e);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.defaultDialog(title: "Error", middleText: e.code);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.defaultDialog(title: "Error", middleText: "Password tidak cocok");
      } else {
        Get.defaultDialog(title: "Error", middleText: e.code);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: loading,
      child: Scaffold(
        backgroundColor: const Color(0xFF0068F7),
        body: Container(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Text(
                    "Konfirmasi Reset Password",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                child: Center(
                  child: Card(
                    color: const Color(0xFFFFFFFF),
                    child: Container(
                        height: 500,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            SizedBox(height: 50),
                            Text(
                              "Silahkan konfirmasi password untuk digunakan didalam Aplikasi",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              "Cocokan dengan reset pasword melalui email",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(height: 50),
                            Container(
                              width: 300.0,
                              child: TextField(
                                obscureText: hidePass,
                                controller: passC,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.vpn_key),
                                    suffixIcon: InkWell(
                                        onTap: () {
                                          setState(() {
                                            hidePass = !hidePass;
                                          });
                                        },
                                        child: hidePass
                                            ? Icon(Icons.visibility)
                                            : Icon(Icons.visibility_off)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    filled: true,
                                    labelStyle:
                                        TextStyle(color: Colors.grey[800]),
                                    labelText: "Konfirmasi password Anda",
                                    fillColor: Colors.white70),
                              ),
                            ),
                            SizedBox(height: 50),
                            Container(
                              width: 300,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(5.0))),
                                onPressed: () {
                                  print("reset pass");
                                  if (passC.text != null) {
                                    print("reset pass");
                                    _resetPassword();
                                  } else {
                                    Get.snackbar(
                                        "Info", "Password tidak boleh kosong",
                                        backgroundColor: Colors.yellow);
                                  }
                                },
                                child: Text('KONFIRMASI'),
                              ),
                            ),
                            SizedBox(height: 50),
                          ],
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
