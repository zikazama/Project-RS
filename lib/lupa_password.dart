import 'package:aplikasi_rs/config/theme.dart';
import 'package:aplikasi_rs/reset_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'login_pasien.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailC = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;

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

  _resetPassword() async {
    _onLoading();
    try {
      final user =
          _auth.sendPasswordResetEmail(email: emailC.text).then((value) {
        _offLoading();
        Get.defaultDialog(
            title: "Lupa Password",
            middleText: "Silahkan reset password melalui email terlebih dahulu",
            textConfirm: "Mengerti",
            onConfirm: () {
              _offLoading();
              Get.to(() => ResetPassword(email: emailC.text));
            });
      }).catchError((e) {
        _offLoading();
        print("error : " + e.runtimeType.toString());
        print("error : " + e.code.toString());
        Get.snackbar("error", e.code, backgroundColor: Colors.red);
      });
    } catch (e) {
      print("gagal");
      _offLoading();

      Get.snackbar("error", e.toString(), backgroundColor: Colors.red);
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
                    "Lupa Password",
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
                              "Silahkahkan masukan email anda. Kami akan\nengirimkan reset password baru di email anda",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(height: 50),
                            Container(
                              width: 300.0,
                              child: TextField(
                                controller: emailC,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.mail),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    filled: true,
                                    hintStyle:
                                        TextStyle(color: Colors.grey[800]),
                                    hintText: "Email Anda",
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
                                  if (emailC.text == null ||
                                      GetUtils.isEmail(emailC.text)) {
                                    _resetPassword();
                                  } else {
                                    Get.snackbar("Info", "Format email salah",
                                        backgroundColor: Colors.yellow);
                                  }
                                },
                                child: Text('Kirim'),
                              ),
                            ),
                            SizedBox(height: 50),
                            Container(
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
