import 'dart:convert';
import 'package:aplikasi_rs/Dashboard/dashboard_dokter.dart';
import 'package:aplikasi_rs/controllers/controllers.dart';
import 'package:aplikasi_rs/helpers/shared_preferences.dart';
import 'package:aplikasi_rs/models/model_dokter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:loading_overlay/loading_overlay.dart';

class LoginDokter extends StatefulWidget {
  @override
  _LoginDokterState createState() => _LoginDokterState();
}

class _LoginDokterState extends State<LoginDokter> {
  ControllerDokter controllerDokter = Get.find<ControllerDokter>();
  final ControllerChat controllerChat = Get.find<ControllerChat>();

  bool isHiddenPassword = true;
  TextEditingController ktp = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool loading = false;

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

  _login() async {
    onLoading();
    return await controllerDokter
        .loginDokterController(no_ktp: ktp.text, password: pass.text)
        .then((value) async {
      print("value ui " + value.toString());

      if (value['status'] == true) {
        controllerDokter.dokter.value =
            modelDokterFromJson(jsonEncode(value['user']));
        controllerChat.user.update((val) {
          val.uid = controllerDokter.dokter.value.idDokter;
          val.name = controllerDokter.dokter.value.namaDokter;
          val.nik = controllerDokter.dokter.value.noKtp;
          val.creationTime = "0000-00-00 00:00:00";
        });
        controllerChat.user.refresh();
        print("nama_lengkap" + controllerDokter.dokter.value.namaDokter);
        //TODO : LETAKAN DI REGISTER DOKTER ATAUPUN PASIEN
        //CEK DOC USER DI FIREBASE
        CollectionReference users =
            FirebaseFirestore.instance.collection("users");
        final checkUser = await users.doc(controllerChat.user.value.nik).get();
        if (checkUser.data() == null) {
          await users.doc(controllerChat.user.value.nik).set({
            "uid": controllerChat.user.value.uid,
            "name": controllerChat.user.value.name,
            "nik": controllerChat.user.value.nik,
            "creationTime": "0000-00-00 00:00:00",
            "status": "Offline"
          });
        }
        SharedPreferencesHelper.addStringToSF('noKtp', ktp.text);
        SharedPreferencesHelper.addStringToSF('pass', pass.text);
        SharedPreferencesHelper.addStringToSF('role', 'dokter');
        offLoading();
        Get.to(() => DashboardDokter());
      } else {
        offLoading();

        Get.defaultDialog(title: "Info", content: Text(value['message']));
      }
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
