import 'package:flutter/material.dart';

class Emergency extends StatefulWidget {
  const Emergency({Key key}) : super(key: key);

  @override
  _EmergencyState createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF7380F3),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: Colors.white)),
                Expanded(
                  child: Text(
                    "Emergency",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(14),
            height: MediaQuery.of(context).size.height * 0.8 -
                MediaQuery.of(context).padding.top,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  "GPS Aktif",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Color(0XFF99DD8E)),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Lokasi : jakarta barat",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                Text(
                  "Tekan Tombol Emergency Dibawah Ini, Agar Terhubung Langsung Ke Bagian IGD Rumah Sakit Dan Mengirimkan Titik Lokasi Anda Saat Ini.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0XFFA1A1A1)),
                ),
                Spacer(),
                Spacer(),
                Container(
                  height: 144,
                  width: 144,
                  decoration: BoxDecoration(
                      border: Border.all(width: 7, color: Color(0XFFFF6F6F)),
                      color: Color(0xffFF6F6F),
                      shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      "Emergency",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Color(0XFFFFFFFF)),
                    ),
                  ),
                ),
                Spacer(),
                Spacer(),
                SizedBox(
                  width: 241,
                  child: Text(
                    "Jika Mengalami Kesulitan, Anda Dapat Menghubungi Nomor Ponsel Beriku",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFFA1A1A1)),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Container(
                  height: 45,
                  width: 241,
                  decoration: BoxDecoration(
                      color: Color(0XFF4E4E4E),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "088-888-888-888",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Color(0XFFFFFFFF)),
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Kembali",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFFA1A1A1)),
                  ),
                ),
                Spacer(),
              ],
            ),
          )
        ],
      )),
    );
  }
}
