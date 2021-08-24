import 'dart:convert';

import 'package:aplikasi_rs/models/model_dokter.dart';
import 'package:aplikasi_rs/services/dokter_services.dart';
import 'package:get/get.dart';

class ControllerDokter extends GetxController{
  RxList<ModelDokter> dokterList = <ModelDokter>[].obs;



  Future getListDokterController()async{
    return DokterServices().getDokterList().then((value) {
      this.dokterList.assignAll([]);
      print("value c : " + value.toString());
      if(value == null){
        return;
      }else{
        List v= value;
        v.forEach((element) {
          var md = modelDokterFromJson(jsonEncode(element));
          this.dokterList.add(md);
        });

        return value;
      }
    }).catchError((e){
      print("error c : " + e.toString());
    });
  }
}