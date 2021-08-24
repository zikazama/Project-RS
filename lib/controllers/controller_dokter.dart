import 'dart:convert';

import 'package:aplikasi_rs/models/model_dokter.dart';
import 'package:aplikasi_rs/services/dokter_services.dart';
import 'package:aplikasi_rs/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControllerDokter extends GetxController {
  RxList<ModelDokter> dokterList = <ModelDokter>[].obs;

  var dokter = ModelDokter().obs;

  Future loginDokterController(
      {@required String no_ktp, @required String password}) async {
    return AuthServices()
        .loginDokter(noKtp: no_ktp, password: password)
        .then((value) {
      print("value c : " + value.toString());
      return value;
    }).catchError((e) {
      Get.defaultDialog(title: "Info", content: Text(e.toString()));
    });
  }

  Future getListDokterController() async {
    return DokterServices().getDokterList().then((value) {
      this.dokterList.assignAll([]);
      print("value c : " + value.toString());
      if (value == null) {
        return;
      } else {
        List v = value;
        v.forEach((element) {
          var md = modelDokterFromJson(jsonEncode(element));
          this.dokterList.add(md);
        });

        return value;
      }
    }).catchError((e) {
      print("error c : " + e.toString());
    });
  }
}
