import 'package:aplikasi_rs/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UbahPasswordScreen extends StatefulWidget {
  @override
  _UbahPasswordScreenState createState() => _UbahPasswordScreenState();
}

class _UbahPasswordScreenState extends State<UbahPasswordScreen> {
  TextEditingController lamaController = TextEditingController();
  TextEditingController baruController = TextEditingController();
  TextEditingController konfirmasiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    decoration: InputDecoration(
                        hintText: "Password Lama",
                        contentPadding: EdgeInsets.symmetric(horizontal: 20)),
                  ),
                  SizedBox(
                    height: 19,
                  ),
                  TextField(
                    controller: baruController,
                    decoration: InputDecoration(
                        hintText: "Password Baru",
                        contentPadding: EdgeInsets.symmetric(horizontal: 20)),
                  ),
                  SizedBox(
                    height: 19,
                  ),
                  TextField(
                    controller: konfirmasiController,
                    decoration: InputDecoration(
                        hintText: "Konfirmasi Password Baru",
                        contentPadding: EdgeInsets.symmetric(horizontal: 20)),
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
                onPressed: () {},
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
