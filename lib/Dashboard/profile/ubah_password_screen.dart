import 'package:aplikasi_rs/config/theme.dart';
import 'package:aplikasi_rs/controllers/controllers.dart';
import 'package:aplikasi_rs/services/pasien_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

class UbahPasswordScreen extends StatefulWidget {
  @override
  _UbahPasswordScreenState createState() => _UbahPasswordScreenState();
}

class _UbahPasswordScreenState extends State<UbahPasswordScreen> {
  ControllerPasien controllerPasien = Get.find<ControllerPasien>();
  TextEditingController lamaController = TextEditingController();
  TextEditingController baruController = TextEditingController();
  TextEditingController konfirmasiController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  bool loading = false;
  bool isHiddenNewPassword = true;
  bool isHiddenOldPassword = true;
  bool isHiddenConfPassword = true;

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

  _ubahPass() async {
    onLoading();
    await PasienServices()
        .ubahPassword(
            idPasien: controllerPasien.pasien.value.idPasien,
            oldPass: lamaController.text,
            newPass: konfirmasiController.text)
        .then((value) async {
      print("value ui " + value.toString());
      if (value == null) {
        offLoading();
        Get.snackbar("error", "Failed", backgroundColor: Colors.red);
      } else {
        if (value['status'] == true) {
          await _auth.currentUser.updatePassword(konfirmasiController.text).then((hsl) {
            print("berhasil");
            offLoading();
            Get.defaultDialog(
                barrierDismissible: false,
                title: '',
                backgroundColor: AppColor.primaryColor,
                content: Column(
                  children: [
                    SvgPicture.asset(
                        "assets/icons/akar-icons_circle-check-fill.svg"),
                    Text(value['message'].toString(),
                        textAlign: TextAlign.center),
                  ],
                ));
            Future.delayed(Duration(seconds: 2), () {
              Get.back();
              Get.back();
            });
          }).catchError((e){
            offLoading();
            Get.snackbar("error", e.toString(), backgroundColor: Colors.red);
          });

        } else {
          offLoading();
          Get.defaultDialog(
              radius: 3,
              title: '',
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(value['message'].toString(),
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 22,
                  ),
                  Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 50,
                  )
                ],
              ));
        }
      }
      offLoading();
    }).catchError((e) {
      offLoading();
      Get.snackbar("error", e.toString(), backgroundColor: Colors.red);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: loading,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: Get.height * 0.3,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/wave_dashboard.png',
                      fit: BoxFit.fill,
                      width: Get.width,
                      height: Get.height * 0.3,
                    ),
                    Positioned(
                      top: Get.height * 0.1,
                      child: Container(
                        width: Get.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              Expanded(
                                  child: Center(
                                      child: Text("Ubah Password",
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ))))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextField(
                      controller: lamaController,
                      obscureText: isHiddenOldPassword,
                      decoration: InputDecoration(
                          hintText: "Password Lama",
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                isHiddenOldPassword = !isHiddenOldPassword;
                              });
                            },
                            child: Icon(isHiddenOldPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20)),
                      onChanged: (val) {
                        return val.isEmpty || val.length < 6
                            ? 'Cek Password anda'
                            : null;
                      },
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    TextField(
                      controller: baruController,
                      obscureText: isHiddenNewPassword,
                      decoration: InputDecoration(
                          hintText: "Password Baru",
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                isHiddenNewPassword = !isHiddenNewPassword;
                              });
                            },
                            child: Icon(isHiddenNewPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20)),
                      onChanged: (val) {
                        return val.isEmpty || val.length < 6
                            ? 'Cek Password anda'
                            : null;
                      },
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    TextField(
                      controller: konfirmasiController,
                      obscureText: isHiddenConfPassword,
                      decoration: InputDecoration(
                          hintText: "Konfirmasi Password Baru",
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                isHiddenConfPassword = !isHiddenConfPassword;
                              });
                            },
                            child: Icon(isHiddenConfPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          )),
                      onChanged: (val) {
                        return val.isEmpty || val.length < 6
                            ? 'Cek Password anda'
                            : null;
                      },
                    ),
                    SizedBox(
                      height: 19,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: Get.width,
                height: 45,
                margin: EdgeInsets.symmetric(horizontal: 35),
                child: ElevatedButton(
                  onPressed: () {
                    if (lamaController.text == '') {
                      Get.snackbar("Info", "Password lama kosong",
                          backgroundColor: Colors.yellow);
                    } else if (baruController.text == '') {
                      Get.snackbar("Info", "Password baru kosong",
                          backgroundColor: Colors.yellow);
                    } else if (konfirmasiController.text == '') {
                      Get.snackbar("Info", "Konfirmasi Password kosong",
                          backgroundColor: Colors.yellow);
                    } else if (baruController.text !=
                        konfirmasiController.text) {
                      Get.snackbar("Info", "Konfirmasi Password tidak cocok",
                          backgroundColor: Colors.yellow);
                    } else {
                      _ubahPass();
                    }
                  },
                  child: Text(
                    "Ubah Password",
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              SizedBox(
                height: 19,
              ),
              Container(
                width: Get.width,
                height: 45,
                margin: EdgeInsets.symmetric(horizontal: 35),
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Kembali",
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DataRow extends StatelessWidget {
  final String title;
  final String value;
  DataRow({this.title, this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
          Text(":"),
          Expanded(
            flex: 3,
            child: Text(
              value,
              maxLines: 2,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
