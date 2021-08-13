import 'package:flutter/material.dart';

class DashboardPasien extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/wave_dashboard.png'),
                fit: BoxFit.cover,
              )),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        "Dashboard",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            )
          ],
        ),
        // Expanded(
        //   child: GridView.count(
        //     crossAxisCount: 3,
        //     children: <Widget>[
        //       Container(
        //         decoration: BoxDecoration(
        //           color: Colors.black,
        //         ),
        //       ),
        //       Container(
        //         decoration: BoxDecoration(
        //           color: Colors.black,
        //         ),
        //       ),
        //       Container(
        //         decoration: BoxDecoration(
        //           color: Colors.black,
        //         ),
        //       )
        //     ],
        //   ),
        // )
      ]),
    );
  }
}
