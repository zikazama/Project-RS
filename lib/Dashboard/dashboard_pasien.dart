import 'package:flutter/material.dart';

class DashboardPasien extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Stack(children: <Widget>[
          Column(children: <Widget>[
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
                padding: const EdgeInsets.symmetric(horizonal: 20),
                child: Column(
                  children: <Widget>[Container()],
                ),
              ),
            )
          ]),
        ]));
  }
}
