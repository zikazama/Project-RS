import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:aplikasi_rs/Dashboard/dashboard_pasien.dart';
import 'package:aplikasi_rs/controllers/controllers.dart';
import 'package:aplikasi_rs/models/model_dokter.dart';
import 'package:aplikasi_rs/services/pendaftaran_online_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PendaftaranOnline extends StatefulWidget {
  @override
  PendaftaranOnlineState createState() => PendaftaranOnlineState();
}

DateTime selectedDate = new DateTime.now();

class PendaftaranOnlineState extends State<PendaftaranOnline> {
  TextEditingController idpasien = new TextEditingController();
  TextEditingController tanggalPeriksa = new TextEditingController();
  TextEditingController dokterID = new TextEditingController();
  TextEditingController jenis_bayar = new TextEditingController();
  TextEditingController foto_bpjs = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  final ControllerPasien controllerPasien = Get.find<ControllerPasien>();
  final ControllerDokter controllerDokter = Get.find<ControllerDokter>();
  bool loading = false;
  bool visible = false;
  List<dynamic> _dataDokter = [];
  final picker = ImagePicker();
  File _image;

  Future _getImagecamera() async {
    final image = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(image.path);
      if (image != null) {
        _image = File(image.path);
        foto_bpjs.text = image.path;
        print(_image);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _getImagegallery() async {
    var image = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image.path);
      if (image != null) {
        _image = File(image.path);
        foto_bpjs.text = image.path;
        print(_image);
      } else {
        print('No image selected.');
      }
    });
  }

  void dialogOptionImage(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Galeri"),
                onTap: () {
                  _getImagegallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Kamera"),
                onTap: () {
                  _getImagecamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
        });
  }

  _onLoading() => setState(() => loading = true);
  _offLoading() => setState(() => loading = false);
  getDataDokter() async {
    _onLoading();
    await controllerDokter.getListDokterController().then((value) {
      print("value ui : " + value.toString());
      _dataDokter = value;
      _offLoading();
    }).catchError((e) {
      _offLoading();
      print("error ui : " + e.toString());
    });
  }

  @override
  void initState() {
    getDataDokter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Positioned(
                      child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/images/wave_chat.png'),
                      fit: BoxFit.fill,
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
                              "Pendaftaran Online \n GERIATRI",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ))
                      ],
                    ),
                  ))
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 15),
                margin: const EdgeInsets.only(bottom: 40, left: 24, right: 24),
                child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: tanggalPeriksa,
                          validator: (val) {
                            return (val.length == 0)
                                ? 'Tenjukan jadwal periksa anda'
                                : null;
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.date_range),
                              hintText: "Tanggal Periksa"),
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: selectedDate,
                                    cancelText: "",
                                    firstDate: DateTime.now(),
                                    lastDate: (new DateTime.now())
                                        .add(new Duration(days: 7)))
                                .then((date) {
                              setState(() {
                                selectedDate = date;
                                tanggalPeriksa.text =
                                    "${selectedDate.toLocal()}".split(' ')[0];
                              });
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        DropdownButtonFormField(
                          items: _dataDokter.map((item) {
                            return DropdownMenuItem(
                              child: Text(item["nama_dokter"]),
                              value: item['id_dokter'],
                            );
                          }).toList(),
                          onChanged: (val) {
                            dokterID.text = val;
                            print("id_dokter :" + dokterID.text);
                          },
                          hint: Text('Pilih Dokter'),
                          validator: (value) {
                            return (value == null) ? 'Pilih Dokter' : null;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.local_hospital_rounded)),
                        ),
                        SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          items: <String>[
                            'BPJS',
                            'Non BPJS',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          validator: (val) {
                            return (val == null) ? 'Pilih cara bayar' : null;
                          },
                          onChanged: (val) {
                            jenis_bayar.text = val;
                            if (val == "BPJS") {
                              setState(() {
                                visible = true;
                              });
                            } else {
                              setState(() {
                                visible = false;
                              });
                            }
                          },
                          hint: Text('Tipe Pembayaran Bayar'),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.payment_rounded)),
                        ),
                        SizedBox(height: 20),
                        Visibility(
                          visible: visible,
                          child: TextFormField(
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Foto tidak boleh kosong';
                              }
                              return null;
                            },
                            controller: foto_bpjs,
                            readOnly: true,
                            onTap: () {
                              dialogOptionImage(context);
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.camera_alt),
                                hintText: "Upload Foto BPJS"),
                          ),
                        ),
                        SizedBox(height: 50),
                        new Container(
                          height: 50,
                          width: 300,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0))),
                            onPressed: () {
                              idpasien.text =
                                  controllerPasien.pasien.value.idPasien;
                              if (formKey.currentState.validate()) {
                                if (jenis_bayar.text == 'BPJS') {
                                  PendaftaranOnlinePasienServices.connectToAPI(
                                      idpasien.text,
                                      tanggalPeriksa.text,
                                      dokterID.text,
                                      jenis_bayar.text,
                                      _image);
                                } else {
                                  PendaftaranOnlinePasienServices.connectToAPI(
                                      idpasien.text,
                                      tanggalPeriksa.text,
                                      dokterID.text,
                                      jenis_bayar.text,
                                      null);
                                }

                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: const <Widget>[
                                              Text("Daftar"),
                                              Text(
                                                  "Anda Sudah Berhasil Terdaftar")
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DashboardPasien()));
                                              },
                                              child: const Text("Oke"))
                                        ],
                                      );
                                    });
                              }
                            },
                            child: Text('Kirim'),
                          ),
                        ),
                        new Container(
                          child: Container(
                              child: Center(
                                  child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DashboardPasien()));
                            },
                            child: Text('Kembali',
                                style: TextStyle(color: Colors.grey)),
                          ))),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
