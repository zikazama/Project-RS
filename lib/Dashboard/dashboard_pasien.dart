import 'package:aplikasi_rs/Dashboard/daftar_online.dart';
import 'package:aplikasi_rs/Dashboard/detail_informasi.dart';
import 'package:aplikasi_rs/Dashboard/emergency.dart';
import 'package:aplikasi_rs/helpers/shared_preferences.dart';
import 'package:aplikasi_rs/Dashboard/konsultasi_online/konsultasi_online.dart';
import 'package:aplikasi_rs/Dashboard/profile/profile_screen.dart';
import 'package:aplikasi_rs/controllers/controllers.dart';
import 'package:aplikasi_rs/services/postingan_service.dart';
import 'package:aplikasi_rs/models/model_postingan.dart';
import 'package:aplikasi_rs/data/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:aplikasi_rs/Dashboard/home_care/homecare.dart';
import 'package:html/parser.dart';
import 'dart:developer' as developer;

class DashboardPasien extends StatefulWidget {
  @override
  _DashboardPasien createState() => _DashboardPasien();
}

class _DashboardPasien extends State<DashboardPasien>
    with WidgetsBindingObserver {
  final ControllerPasien controllerPasien = Get.find<ControllerPasien>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online");
    super.initState();
  }

  void setStatus(String status) async {
    print("setStatus no ktp dokter : " + controllerPasien.pasien.value.noKtp);
    var data = await _firestore
        .collection("users")
        .doc(controllerPasien.pasien.value.noKtp)
        .update({"status": status});

    print("data : " +
        await _firestore
            .collection("users")
            .doc(controllerPasien.pasien.value.noKtp)
            .get()
            .toString());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      setStatus("Online");
      print("online");
    } else {
      setStatus("Offline");
      print("offline");
    }
  }

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
                                    MediaQuery.of(context).size.height * 0.180),
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
                              Get.to(() => PendaftaranOnline());
                            },
                          ),
                          CategoryCard(
                            srcSvg: "assets/icons/cs.svg",
                            title: "Konsultasi\nOnline",
                            press: () {
                              Get.to(() => KonsultasiOnline());
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
                          CategoryCard(
                              srcSvg: "assets/icons/logout.svg",
                              title: "Keluar",
                              press: () {
                                SharedPreferencesHelper.removeValues('noKtp');
                                SharedPreferencesHelper.removeValues('pass');
                                SharedPreferencesHelper.removeValues('role');
                                Get.to(() => DashboardPasien());
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
                            child: FutureBuilder<List<Postingan>>(
                      future: PostinganService.fetchPostingan(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Postingan> data = snapshot.data;
                          return _postingListView(data);
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return CircularProgressIndicator();
                      },
                    )
                            // ListView(
                            //   shrinkWrap: true,
                            //   children: [
                            //     Column(
                            //       mainAxisSize: MainAxisSize.min,
                            //       children: [

                            //         // InformasiCard(
                            //         //   modelInformasi: dummyContent[0],
                            //         //   onTap: () {
                            //         //     Navigator.push(
                            //         //         context,
                            //         //         MaterialPageRoute(
                            //         //             builder: (context) => DetailInformasi(
                            //         //                 informasi: dummyContent[0])));
                            //         //   },
                            //         // ),
                            //         // InformasiCard(
                            //         //   modelInformasi: dummyContent[1],
                            //         //   onTap: () {
                            //         //     Navigator.push(
                            //         //         context,
                            //         //         MaterialPageRoute(
                            //         //             builder: (context) => DetailInformasi(
                            //         //                 informasi: dummyContent[1])));
                            //         //   },
                            //         // ),
                            //       ],
                            //     ),
                            //   ],
                            // ),
                            ))
                  ],
                ),
              ),
            )
          ]),
        ]));
  }
}

ListView _postingListView(data) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        print(data[index]);
        return InformasiCard(
          modelInformasi: data[index],
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DetailInformasi(informasi: data[index])));
          },
        );
      });
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
  final dynamic modelInformasi;
  final Function onTap;

  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;
    return parsedString;
  }

  InformasiCard({@required this.modelInformasi, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: ClipRRect(
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
              Image.network(
                'https://cdn0-production-images-kly.akamaized.net/5EKWfqGHzQUmkLpqgaAMUDZ6ayo=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/3287731/original/003422800_1604554853-Banner_tips_jaga_kesehatan_mental_saat_covid-19.jpg',
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
                          modelInformasi.judul,
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Text(modelInformasi.plainKonten,
                          overflow: TextOverflow.ellipsis))
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
