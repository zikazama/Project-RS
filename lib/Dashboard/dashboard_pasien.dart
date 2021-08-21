import 'package:aplikasi_rs/Dashboard/chat/inbox.dart';
import 'package:aplikasi_rs/Dashboard/emergency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'homecare.dart';

class DashboardPasien extends StatefulWidget {
  @override
  _DashboardPasien createState() => _DashboardPasien();
}

class _DashboardPasien extends State<DashboardPasien> {
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
                                child: Text(
                              "Selamat datang User",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
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
                            press: () {},
                          ),
                          CategoryCard(
                            srcSvg: "assets/icons/cs.svg",
                            title: "Konsultasi\nOnline",
                            press: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatRoom()));
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
                            press: () {},
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        child: Container(
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.270),
                            child: Container(
                                child: Text(
                              "INFORMASI GERIATRI",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )))),
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
