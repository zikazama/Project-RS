import 'package:aplikasi_rs/controllers/controller_pasien.dart';
import 'package:aplikasi_rs/services/pasien_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Emergency extends StatefulWidget {
  const Emergency({Key key}) : super(key: key);

  @override
  _EmergencyState createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  final ControllerPasien controllerPasien = Get.find<ControllerPasien>();
  bool isLoading = false;
  double latitude = 0;
  double longitude = 0;
  Map<String, dynamic> location = {};
  _onLoading() => setState(() => isLoading = true);

  _offLoading() => setState(() => isLoading = false);

  _sendEmergency(String lat, String long) async {
    _onLoading();
    await PasienServices().sendEmergency(
        idPasien: controllerPasien.pasien.value.idPasien,
        latitude: lat,
        longitude: long).then((value) {
      _offLoading();

          print("value ui emergency " + value.toString());
          if(value != null){
            if(value['status'] == true){
              Get.defaultDialog(
                  radius: 3,
                  title: '',
                  content: Container(
                    width: Get.width * 0.8,
                    height: Get.height * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Emergency Berhasil Di Dikirim "),
                        SizedBox(
                          height: 22,
                        ),
                        // Text("latitude : " + latitude.toString()),
                        // Text("langitude : " + longitude.toString()),
                        SvgPicture.asset(
                            "assets/icons/akar-icons_circle-check-fill.svg")
                      ],
                    ),
                  ));
            }else{
              Get.defaultDialog(
                  radius: 3,
                  title: '',
                  content: Container(
                    width: Get.width * 0.8,
                    height: Get.height * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Emergency Gagal Di Dikirim"),
                        SizedBox(
                          height: 22,
                        ),
                        Icon(Icons.close, color: Colors.red,size: 50,)
                      ],
                    ),
                  ));
            }

          }else{
            Get.defaultDialog(
                radius: 3,
                title: '',
                content: Container(
                  width: Get.width * 0.8,
                  height: Get.height * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Emergency Gagal Di Dikirim"),
                      SizedBox(
                        height: 22,
                      ),
                      Icon(Icons.close, color: Colors.red,size: 50,)
                    ],
                  ),
                ));
          }

    }).catchError((e){
      _offLoading();
      Get.defaultDialog(
          radius: 3,
          title: '',
          content: Container(
            width: Get.width * 0.8,
            height: Get.height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Emergency Gagal Di Dikirim \n error: "+e.toString()),
                SizedBox(
                  height: 22,
                ),
                Icon(Icons.close, color: Colors.red,)
              ],
            ),
          ));
    });
  }

  Future getCurrentLocation() async {
    _onLoading();
    var position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best)
        .then((value) {
      print(value.toString());
      print(value.latitude.toString());
      print(value.longitude.toString());
      print(value.runtimeType.toString());
      latitude = value.latitude;
      longitude = value.longitude;
    }).catchError((e) {
      print("error get current : " + e.toString());
    });

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      location = placemarks[0].toJson();
      _offLoading();
      print("lokasi : " + location.toString());
    } catch (e) {
      _offLoading();
      print(" error : " + e.toString());
      Get.snackbar(
          "Gagal", "Tidak dapat menampilkan kota, Periksa jaringan anda",
          colorText: Colors.white, backgroundColor: Colors.red);
    }

    setState(() {});
  }

  @override
  void initState() {
    print("cetak location : " + location.toString());
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
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
                  InkWell(
                    onTap: () {
                      if (latitude != 0) {
                        Get.snackbar("Info", "GPS Sudah Aktif",
                            backgroundColor: Colors.yellow);
                      } else {
                        getCurrentLocation();
                      }
                    },
                    child: latitude == 0
                        ? Text(
                            "GPS Tidak Aktif",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Colors.red),
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            "GPS Aktif",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Color(0XFF99DD8E)),
                            textAlign: TextAlign.center,
                          ),
                  ),
                  InkWell(
                    onTap: () {
                      getCurrentLocation();
                    },
                    child: Text(
                      "Lokasi : " +
                          (location.isEmpty
                              ? "-"
                              : location['administrativeArea']),
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
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
                  InkWell(
                    onTap: () {
                      if (latitude == 0 || longitude == 0) {
                        getCurrentLocation();
                      } else {
          _sendEmergency(latitude.toString(), longitude.toString());
                      }
                    },
                    child: Container(
                      height: 144,
                      width: 144,
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 7, color: Color(0XFFFF6F6F)),
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
      ),
    );
  }
}
