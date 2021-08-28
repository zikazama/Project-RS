import 'package:aplikasi_rs/Dashboard/home_care/map.dart';
import 'package:aplikasi_rs/controllers/controllers.dart';
import 'package:aplikasi_rs/services/pasien_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../dashboard_pasien.dart';

class HomeCare extends StatefulWidget {
  @override
  _HomeCareState createState() => _HomeCareState();
}

bool isLoading = false;

double latitudeMap, longitudeMap, longitudeMap1, latitudeMap1;
Map<String, dynamic> location1 = {};
List<String> datalayanan = [];
String datanama, datanohp, datakeluhan, datakondisipasien;

class _HomeCareState extends State<HomeCare> {
  TextEditingController namapasien =
      new TextEditingController(text: (datanama != null) ? datanama : "");
  TextEditingController nohp =
      new TextEditingController(text: (datanohp != null) ? datanohp : "");
  TextEditingController keluhan =
      new TextEditingController(text: (datakeluhan != null) ? datakeluhan : "");
  TextEditingController kondisipasien = new TextEditingController(
      text: (datakondisipasien != null) ? datakondisipasien : "");
  TextEditingController lokasi = new TextEditingController(
      text: (latitudeMap1 != null)
          ? "${location1["subLocality"] + " " + location1["locality"] + " " + location1["administrativeArea"]}"
          : "");
  final ControllerPasien controllerPasien = Get.find<ControllerPasien>();
  final formKey = GlobalKey<FormState>();

  _onLoading() => setState(() => isLoading = true);
  _offLoading() => setState(() => isLoading = false);

  Future getCurrentLocation() async {
    _onLoading();
    var position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best)
        .then((value) {
      print(value.toString());
      print(value.latitude.toString());
      print(value.longitude.toString());
      print(value.runtimeType.toString());
      latitudeMap = value.latitude.toDouble();
      longitudeMap = value.longitude;
    }).catchError((e) {
      print("error get current : " + e.toString());
    });
    _offLoading();
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFF7380F3),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Text(
                      "HOME CARE",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 24.0),
                    ),
                  ),
                  SizedBox(height: 40),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(25.0),
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.120),
                      width: MediaQuery.of(context).size.width * 0.950,
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 30),
                            new TextFormField(
                              controller: namapasien,
                              validator: (val) {
                                return (val.length == 0 || val.length < 3)
                                    ? 'Periksa kemblai nama pasien'
                                    : null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.card_membership),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[800]),
                                  hintText: "Nama Pasien",
                                  fillColor: Colors.white70),
                            ),
                            SizedBox(height: 20),
                            new TextFormField(
                              controller: nohp,
                              validator: (val) {
                                return (val.length < 10)
                                    ? 'No telpon pasien salah'
                                    : null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.phone_android),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[800]),
                                  hintText: "No.HP",
                                  fillColor: Colors.white70),
                            ),
                            SizedBox(height: 20),
                            new TextFormField(
                              controller: lokasi,
                              readOnly: true,
                              validator: (val) {
                                return (val.length == 0) ? null : null;
                              },
                              onTap: () {
                                print("datamasuk ");
                                datanama = namapasien.text;
                                print("nama " + datanama);
                                datanohp = nohp.text;
                                print("nohp " + datanohp);
                                datakeluhan = keluhan.text;
                                print("keluhan " + datakeluhan);
                                datakondisipasien = kondisipasien.text;
                                print("kondisi pasien " + datakondisipasien);
                                Get.to(() => Maps());
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.edit_location),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[800]),
                                  hintText: "Lokasi",
                                  fillColor: Colors.white70),
                            ),
                            SizedBox(height: 20),
                            new TextFormField(
                              controller: keluhan,
                              validator: (val) {
                                return (val.length == 0)
                                    ? 'Keluhan pasien belum di isi'
                                    : null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.sick),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[800]),
                                  hintText: "Keluhan",
                                  fillColor: Colors.white70),
                            ),
                            SizedBox(height: 20),
                            new TextFormField(
                              controller: kondisipasien,
                              validator: (val) {
                                return (val.length == 0)
                                    ? 'Isi kondisi pasien'
                                    : null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.local_hospital),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[800]),
                                  hintText: "Kondisi Saat Ini",
                                  fillColor: Colors.white70),
                            ),
                            SizedBox(height: 60),
                            new Container(
                              height: 50,
                              width: 300,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFF7380F3),
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(5.0))),
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    PasienServices()
                                        .sendHomeCare(
                                            idPasien: controllerPasien
                                                .pasien.value.idPasien,
                                            namaPasien: namapasien.text,
                                            noHp: nohp.text,
                                            tanggal_pelayanan: DateTime.now()
                                                .toString()
                                                .split(' ')[0],
                                            latitude: latitudeMap1.toString(),
                                            longitude: longitudeMap1.toString(),
                                            keluhan: keluhan.text,
                                            kondisiPasien: kondisipasien.text)
                                        .then((value) {
                                      _offLoading();
                                      print("value ui homeCare " +
                                          value.toString());
                                      if (value != null) {
                                        if (value['status'] == true) {
                                          Get.defaultDialog(
                                              radius: 3,
                                              title: '',
                                              content: Container(
                                                width: Get.width * 0.8,
                                                height: Get.height * 0.5,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        "Layanan Berhasil Di Dikirim "),
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
                                        } else {
                                          Get.defaultDialog(
                                              radius: 3,
                                              title: '',
                                              content: Container(
                                                width: Get.width * 0.8,
                                                height: Get.height * 0.3,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        "Emergency Gagal Di Dikirim"),
                                                    SizedBox(
                                                      height: 22,
                                                    ),
                                                    Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                      size: 50,
                                                    )
                                                  ],
                                                ),
                                              ));
                                        }
                                      } else {
                                        Get.defaultDialog(
                                            radius: 3,
                                            title: '',
                                            content: Container(
                                              width: Get.width * 0.8,
                                              height: Get.height * 0.3,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      "Layanan Gagal Di Dikirim"),
                                                  SizedBox(
                                                    height: 22,
                                                  ),
                                                  Icon(
                                                    Icons.close,
                                                    color: Colors.red,
                                                    size: 50,
                                                  )
                                                ],
                                              ),
                                            ));
                                      }
                                    });
                                  }
                                },
                                child: Text('Pesan Layanan'),
                              ),
                            ),
                            SizedBox(height: 30),
                            new Container(
                              child: Container(
                                  child: Center(
                                      child: TextButton(
                                onPressed: () {
                                  datanama = null;
                                  datakeluhan = null;
                                  datanohp = null;
                                  datakondisipasien = null;
                                  latitudeMap1 = null;
                                  longitudeMap1 = null;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DashboardPasien()));
                                },
                                child: Text(
                                  'Kembali',
                                  style: TextStyle(
                                      color: const Color(0xFF7380F3),
                                      fontSize: 14.0),
                                ),
                              ))),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}
