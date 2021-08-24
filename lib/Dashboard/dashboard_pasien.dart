import 'package:aplikasi_rs/Dashboard/chat/inbox.dart';
import 'package:aplikasi_rs/Dashboard/daftar_online.dart';
import 'package:aplikasi_rs/Dashboard/detail_informasi.dart';
import 'package:aplikasi_rs/Dashboard/emergency.dart';
import 'package:aplikasi_rs/Dashboard/profile/profile_screen.dart';
import 'package:aplikasi_rs/controllers/controllers.dart';
import 'package:aplikasi_rs/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'homecare.dart';

class DashboardPasien extends StatefulWidget {
  @override
  _DashboardPasien createState() => _DashboardPasien();
}

class _DashboardPasien extends State<DashboardPasien> {
  final ControllerPasien controllerPasien = Get.find<ControllerPasien>();

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Stack(children: <Widget>[
          Stack(children: <Widget>[
            Positioned(
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/wave_dashboard.png'),
                      fit: BoxFit.cover,
                    )),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        child: Container(
                            margin: EdgeInsets.only(
                                bottom:
                                MediaQuery.of(context).size.height * 0.120),
                            child: Center(
                                child: Text(
                                  "Dashboard",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )))),
                    Positioned(
                        child: Container(
                            padding: EdgeInsets.only(left: 30.0),
                            margin: EdgeInsets.only(
                                top:
                                MediaQuery.of(context).size.height * 0.100),
                            child: SafeArea(
                                child: Obx(
                                      () => Text(
                                    "Selamat datang " +
                                        controllerPasien.pasien.value.namaLengkap,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ))))
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.300),
                    ),
                    Expanded(
                      child: GridView.count(
                        // padding: EdgeInsets.all(15),
                        crossAxisCount: 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        children: <Widget>[
                          CategoryCard(
                            srcSvg: "assets/icons/registration.svg",
                            title: "Daftar\nonline",
                            press: () {
                              Get.to(()=>PendaftaranOnline());
                            },
                          ),
                          CategoryCard(
                            srcSvg: "assets/icons/cs.svg",
                            title: "Konsultasi\nOnline",
                            press: () {
                              Get.to(()=>ChatRoom());
                            },
                          ),
                          CategoryCard(
                            srcSvg: "assets/icons/homecare.svg",
                            title: "Home Care",
                            press: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeCare()));
                            },
                          ),
                          CategoryCard(
                            srcSvg: "assets/icons/emergency.svg",
                            title: "Emergency",
                            press: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Emergency()));
                            },
                          ),
                          CategoryCard(
                              srcSvg: "assets/icons/profile.svg",
                              title: "Profile Anda",
                              press: () {
                                Get.to(() => ProfileScreen());
                              }),
                        ],
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.only(
                      //     bottom: MediaQuery.of(context).size.height * 0.270),
                        child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "INFORMASI GERIATRI",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ))),

                    //INFORMASI GERIATRI
                    Expanded(
                        child: Container(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InformasiCard(
                                    modelInformasi: dummyContent[0],
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailInformasi(
                                                  informasi: dummyContent[0])));
                                    },
                                  ),
                                  InformasiCard(
                                    modelInformasi: dummyContent[1],
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailInformasi(
                                                  informasi: dummyContent[1])));
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            )
          ]),
        ]));
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String srcSvg;
  final Function press;
  const CategoryCard({
    Key key,
    this.title,
    this.srcSvg,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  // SvgPicture.asset("svgSrc"),
                  SvgPicture.asset(
                    srcSvg,
                    height: 30,
                  ),
                  Spacer(),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InformasiCard extends StatelessWidget {
  final Map<String, dynamic> modelInformasi;
  final Function onTap;

  InformasiCard({@required this.modelInformasi, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
              offset: Offset(0, 3))
        ]),
        child: Row(
          children: [
            Image.asset(
              modelInformasi['imageUrl'],
              height: 120,
              width: 130,
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            modelInformasi['title'],
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Text(
                          modelInformasi['subTitle'],
                          maxLines: 4,
                          style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                        ))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
