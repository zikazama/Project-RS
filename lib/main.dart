import 'package:aplikasi_rs/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'mainscreen.dart';

void main() {
  Get.put(ControllerPasien());
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainScreen(),
  ));
}
