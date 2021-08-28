import 'package:aplikasi_rs/Dashboard/controller_home_dokter.dart';
import 'package:aplikasi_rs/controllers/controller_dokter.dart';
import 'package:aplikasi_rs/controllers/controllers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'mainscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(ControllerChat());
  Get.put(ControllerPasien());
  Get.put(ControllerDokter());
  Get.put(ControllerChatRoom());
  Get.put(ControllerHomeDoctor());
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainScreen(),
  ));
}
