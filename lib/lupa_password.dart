import 'package:flutter/material.dart';
import 'login_pasien.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0068F7),
      body: Container(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 50),
                child: Text(
                  "Lupa Password",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              child: Center(
                child: Card(
                  color: const Color(0xFFFFFFFF),
                  child: Container(
                      height: 500,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                          Text(
                            "Silahkahkan masukan email anda. Kami akan\nengirimkan password baru di email anda",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(height: 50),
                          Container(
                            width: 300.0,
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[800]),
                                  hintText: "Email Anda",
                                  fillColor: Colors.white70),
                            ),
                          ),
                          SizedBox(height: 50),
                          Container(
                            width: 300,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(5.0))),
                              onPressed: () {},
                              child: Text('Kirim'),
                            ),
                          ),
                          SizedBox(height: 50),
                          Container(
                            child: Container(
                                child: Center(
                                    child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPasien()));
                              },
                              child: Text('Kembali'),
                            ))),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
