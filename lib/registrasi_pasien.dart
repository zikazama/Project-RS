import 'package:aplikasi_rs/services/registrasi_pasien_services.dart';
import 'package:flutter/material.dart';
import 'login_pasien.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RegistrasiPasien extends StatefulWidget {
  @override
  _RegistrasiPasienState createState() => _RegistrasiPasienState();
}

DateTime selectedDate = new DateTime.now();
String created_at = DateTime.now().toString();
//int yearNow = int.parse("${selectedDate.toLocal()}".split('-')[0]);

class _RegistrasiPasienState extends State<RegistrasiPasien> {
  TextEditingController namaLengkap = new TextEditingController();
  TextEditingController tanggalLahir = new TextEditingController();
  TextEditingController noKtp = new TextEditingController();
  TextEditingController jenisKelamin = new TextEditingController();
  TextEditingController agama = new TextEditingController();
  TextEditingController pendidikan = new TextEditingController();
  TextEditingController alamat = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController noHp = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController confirmPass = new TextEditingController();
  bool isHiddenPassword = true;
  bool isHiddenPassword1 = true;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFF0068F7),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      'PENDAFTARAN\nPASIEN BARU',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 24.0),
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(25.0),
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.140),
                      width: MediaQuery.of(context).size.width,
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            new TextFormField(
                              controller: namaLengkap,
                              validator: (val) {
                                return val.isEmpty || val.length <= 2
                                    ? 'Cek kembali nama lengkap anda'
                                    : null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                hintText: 'Nama Lengkap',
                              ),
                            ),
                            SizedBox(height: 10),
                            new TextFormField(
                              controller: noHp,
                              validator: (val) {
                                return val.length < 10
                                    ? 'Nomer HP anda tidak valid'
                                    : null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.phone),
                                  hintText: 'Nomor HP'),
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              validator: (val) {
                                if (val.length == 0) {
                                  return 'Masukan tanggal lahir anda';
                                } else if ((int.parse("${DateTime.now()}"
                                                .split('-')[0]) -
                                            17) -
                                        int.parse("${val}".split('-')[0]) <
                                    0) {
                                  return 'Anda belum cukup usia';
                                } else {
                                  return null;
                                }
                              },
                              readOnly: true,
                              onTap: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: selectedDate,
                                        initialDatePickerMode:
                                            DatePickerMode.year,
                                        cancelText: "",
                                        firstDate: DateTime(1821),
                                        lastDate: DateTime.now())
                                    .then((date) {
                                  setState(() {
                                    selectedDate = date;
                                    tanggalLahir.text =
                                        "${selectedDate.toLocal()}"
                                            .split(' ')[0];
                                  });
                                });
                              },
                              controller: tanggalLahir,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.date_range),
                                hintText: 'Tanggal Lahir',
                              ),
                            ),
                            SizedBox(height: 10),
                            new DropdownButtonFormField<String>(
                              hint: Text('Jenis Kelamin'),
                              items: [
                                DropdownMenuItem(
                                  child: Text('Laki-Laki'),
                                  value: 'l',
                                ),
                                DropdownMenuItem(
                                  child: Text('Perempuan'),
                                  value: 'p',
                                )
                              ],
                              validator: (value) {
                                if (value == null) {
                                  return 'Pilih gender anda';
                                }
                              },
                              onChanged: (val) {
                                jenisKelamin.text = val;
                              },
                            ),
                            SizedBox(height: 10),
                            new TextFormField(
                              controller: noKtp,
                              validator: (val) {
                                return val.length < 16
                                    ? 'Cek kembali nomer KTP anda'
                                    : null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.card_membership),
                                  hintText: 'Nomor KTP'),
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 10),
                            new DropdownButtonFormField<String>(
                              hint: Text('Agama'),
                              items: <String>[
                                'Islam',
                                'Kristen',
                                'Hindu',
                                'Buddha',
                                'Khonghucu'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Pilih agama anda';
                                }
                              },
                              onChanged: (val) {
                                agama.text = val;
                              },
                            ),
                            SizedBox(height: 10),
                            new TextFormField(
                              controller: pendidikan,
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Isikan pendidikan terakhir anda';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.school),
                                hintText: 'Pendidikan',
                              ),
                            ),
                            SizedBox(height: 10),
                            new TextFormField(
                              controller: email,
                              validator: (val) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val)
                                    ? null
                                    : 'Email anda salah';
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.mail),
                                  hintText: 'Email'),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(height: 10),
                            new TextFormField(
                              controller: alamat,
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Isi alamat anda';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.home),
                                hintText: 'Alamat',
                              ),
                            ),
                            SizedBox(height: 10),
                            new TextFormField(
                              obscureText: isHiddenPassword,
                              controller: pass,
                              validator: (val) {
                                return val.length < 6
                                    ? 'Buat password minimal 6 karakter'
                                    : null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.vpn_key),
                                  hintText: 'Password',
                                  suffixIcon: InkWell(
                                    onTap: _togglePasswordView,
                                    child: Icon(Icons.visibility_off),
                                  )),
                            ),
                            SizedBox(height: 10),
                            new TextFormField(
                              obscureText: isHiddenPassword1,
                              controller: confirmPass,
                              validator: (val) {
                                if (val != pass.text) {
                                  return 'Password anda salah, coba periksa lagi';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.vpn_key),
                                  hintText: 'Konfirmasi Password',
                                  suffixIcon: InkWell(
                                    onTap: _togglePasswordView1,
                                    child: Icon(Icons.visibility_off),
                                  )),
                            ),
                            SizedBox(height: 25),
                            new Container(
                              height: 50,
                              width: 300,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(5.0))),
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    registrasiPasienServices.connectToAPI(
                                        namaLengkap.text,
                                        noHp.text,
                                        jenisKelamin.text,
                                        tanggalLahir.text,
                                        noKtp.text,
                                        agama.text,
                                        pendidikan.text,
                                        alamat.text,
                                        email.text,
                                        created_at,
                                        "0000-00-00 00:00:00",
                                        confirmPass.text);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginPasien()));
                                  }
                                },
                                child: Text('Daftar'),
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
                                          builder: (context) => LoginPasien()));
                                },
                                child: Text('Kembali'),
                              ))),
                            ),
                            SizedBox(
                              height: 50,
                            )
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

  void _togglePasswordView() {
    if (isHiddenPassword == true) {
      isHiddenPassword = false;
    } else {
      isHiddenPassword = true;
    }
    setState(() {});
  }

  void _togglePasswordView1() {
    if (isHiddenPassword1 == true) {
      isHiddenPassword1 = false;
    } else {
      isHiddenPassword1 = true;
    }
    setState(() {});
  }
}
