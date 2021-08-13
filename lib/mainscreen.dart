import 'package:flutter/material.dart';
import 'login_pasien.dart';
import 'login_dokter.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7EEFE),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/rsbm1.png'),
              )),
            ),
            Container(
              child: Text(
                'SELAMAT DATANG DI APLIKASI \n MOBILE BHAYANGKARA GERIATRI',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50),
            ),
            Container(
              height: 50,
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFFFFFFF),
                    onPrimary: const Color(0xFF0F0F0F),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPasien()),
                  );
                },
                child: Text('Masuk Sebagai Pasien'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25),
            ),
            Container(
              height: 50,
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0))),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginDokter()));
                },
                child: Text('Masuk Sebagai Dokter'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
