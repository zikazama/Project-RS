import 'package:aplikasi_rs/Dashboard/profile/edit_profile_screen.dart';
import 'package:aplikasi_rs/Dashboard/profile/ubah_password_screen.dart';
import 'package:aplikasi_rs/config/theme.dart';
import 'package:aplikasi_rs/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ControllerPasien controllerPasien = Get.find<ControllerPasien>();

  @override
  Widget build(BuildContext context) {
    print(controllerPasien.pasien.value.namaLengkap);

    return Scaffold(
      body: Column(
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
                                  child: Text("Profile Pasien",
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
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Obx(
                      () => DataRow(
                    title: "Nama Pasien",
                    value: controllerPasien.pasien.value.namaLengkap,
                  ),
                ),
                SizedBox(
                  height: 19,
                ),
                DataRow(
                  title: "Email",
                  value: controllerPasien.pasien.value.email,
                ),
                SizedBox(
                  height: 19,
                ),
                DataRow(
                  title: "Tanggal Lahir",
                  value: controllerPasien.pasien.value.tanggalLahir,
                ),
                SizedBox(
                  height: 19,
                ),
                DataRow(
                  title: "Nomor KTP",
                  value: controllerPasien.pasien.value.noKtp,
                ),
                SizedBox(
                  height: 19,
                ),
                DataRow(
                  title: "Jenis Kelamin",
                  value: controllerPasien.pasien.value.jenisKelamin,
                ),
                SizedBox(
                  height: 19,
                ),
                DataRow(
                  title: "Alamat",
                  value: controllerPasien.pasien.value.alamat,
                ),
                SizedBox(
                  height: 19,
                ),
                DataRow(
                  title: "Agama",
                  value: controllerPasien.pasien.value.agama,
                ),
                SizedBox(
                  height: 19,
                ),
                DataRow(
                  title: "Pendidikan",
                  value: controllerPasien.pasien.value.pendidikan,
                ),
                SizedBox(
                  height: 19,
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            width: Get.width,
            height: 45,
            margin: EdgeInsets.symmetric(horizontal: 35),
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => EditProfileScreen()).then((value) {
                  setState(() {});
                });
              },
              child: Text(
                "Edit Profile",
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
                Get.to(() => UbahPasswordScreen());
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
          Spacer(),
        ],
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
          Text(" : "),
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
