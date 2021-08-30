import 'package:flutter/material.dart';
import 'login_pasien.dart';
import 'login_dokter.dart';
import 'package:aplikasi_rs/helpers/shared_preferences.dart';
import 'package:aplikasi_rs/models/model_pasien.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:aplikasi_rs/controllers/controllers.dart';
import 'package:aplikasi_rs/Dashboard/dashboard_pasien.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:aplikasi_rs/Dashboard/dashboard_dokter.dart';
import 'package:aplikasi_rs/models/model_dokter.dart';

import 'dart:convert';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ControllerPasien controllerPasien = Get.find<ControllerPasien>();
  final ControllerChat controllerChat = Get.find<ControllerChat>();
  ControllerDokter controllerDokter = Get.find<ControllerDokter>();
  TextEditingController noKtp = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  bool logged = false;
  String role;

  _getPrefs() async {
    final check = await SharedPreferencesHelper.getStringValuesSF('noKtp');
    if (check != '') {
      noKtp.text = await SharedPreferencesHelper.getStringValuesSF('noKtp');
      pass.text = await SharedPreferencesHelper.getStringValuesSF('pass');
      role = await SharedPreferencesHelper.getStringValuesSF('role');
      setState(() {
        logged = true;
      });
    }
  }

  _autoLogin() async {
    await _getPrefs();
    if (logged) {
      if (role == 'pasien') {
        _loginPasien();
      } else if (role == 'dokter') {
        _loginDokter();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _autoLogin();
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

  Future<List> _loginPasien() async {
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
          // SharedPreferencesHelper.addStringToSF('noKtp', noKtp.text);
          // SharedPreferencesHelper.addStringToSF('pass', pass.text);
          // SharedPreferencesHelper.addStringToSF('role', 'pasien');
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

  _loginDokter() async {
    onLoading();
    return await controllerDokter
        .loginDokterController(no_ktp: noKtp.text, password: pass.text)
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
        backgroundColor: const Color(0xFFE7EEFE),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/rsbm1.png'),
                )),
              ),
              Container(
                child: Text(
                  'SELAMAT DATANG DI APLIKASI \n MOBILE BHAYANGKARA GERIATRI',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50),
              ),
              Container(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFFFFFFF),
                      onPrimary: const Color(0xFF0F0F0F),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPasien()),
                    );
                  },
                  child: Text('Masuk Sebagai Pasien'),
                ),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginDokter()));
                  },
                  child: Text('Masuk Sebagai Dokter'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
