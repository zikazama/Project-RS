import 'package:aplikasi_rs/lupa_password.dart';
import 'package:flutter/material.dart';
import 'lupa_password.dart';
import 'registrasi_pasien.dart';
import 'package:aplikasi_rs/Dashboard/dashboard_pasien.dart';

class LoginPasien extends StatefulWidget {
  @override
  _LoginPasienState createState() => _LoginPasienState();
}

class _LoginPasienState extends State<LoginPasien> {
  bool isHiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: new Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/wave.png'),
                fit: BoxFit.cover,
              )),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 100),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/rsbm1.png'))),
                    ),
                  ),
                  Positioned(
                      child: Container(
                          margin: EdgeInsets.only(top: 200),
                          child: Center(
                              child: Text(
                            "SELAMAT DATANG DI APLIKASI\nMOBILE BHAYANGKARA GERIATRI",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ))))
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.card_membership),
                        hintText: 'Nomor KTP',
                      ),
                    ),
                    TextField(
                      obscureText: isHiddenPassword,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key),
                          hintText: 'Password',
                          suffixIcon: InkWell(
                            onTap: _togglePasswordView,
                            child: Icon(Icons.visibility_off),
                          )),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashboardPasien()));
                        },
                        child: Text('Masuk'),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      child: Container(
                          child: Center(
                              child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()));
                        },
                        child: Text('Lupa Password'),
                      ))),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      height: 50,
                      width: 300,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            primary: const Color(0xFF000000),
                            backgroundColor: const Color(0xFFE7EEFE)
                          ),
                        // color: 
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrasiPasien()));
                        },
                        child: Text('Buat Akun'),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void _togglePasswordView() {
    if (isHiddenPassword == true) {
      isHiddenPassword = false;
    } else {
      isHiddenPassword = true;
    }
    setState(() {});
  }
}
