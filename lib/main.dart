import 'package:aplikasi_rs/Dashboard/controller_home_dokter.dart';
import 'package:aplikasi_rs/controllers/controller_dokter.dart';
import 'package:aplikasi_rs/controllers/controllers.dart';
import 'package:aplikasi_rs/reset_password.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
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
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    this.initDynamicLink();
  }

  void initDynamicLink() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLinkData) async {
      final Uri deepLink = dynamicLinkData.link;
      print("dynamiclink ditemukan");
      if (deepLink != null) {
        print(deepLink);

        Get.to(() => ResetPassword());
      }
    }, onError: (OnLinkErrorException e) async {
      print("deeplink error");
      print(e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
