
import 'package:aplikasi_rs/models/models.dart';
import 'package:aplikasi_rs/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ControllerPasien extends GetxController {
  var pasien = ModelPasien().obs;

  Future loginPasienController(
      {@required String no_ktp, @required String password}) async {
    return AuthServices()
        .loginPasien(noKtp: no_ktp, password: password)
        .then((value) {
      print("value c : " + value.toString());
      return value;
    }).catchError((e) {
      Get.defaultDialog(title: "Info", content: Text(e.toString()));
    });
  }
}
