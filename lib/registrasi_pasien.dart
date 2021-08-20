import 'package:flutter/material.dart';
import 'login_pasien.dart';
import 'services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RegistrasiPasien extends StatefulWidget {
  @override
  _RegistrasiPasienState createState() => _RegistrasiPasienState();
}

class _RegistrasiPasienState extends State<RegistrasiPasien> {
  Registrasi registrasi = new Registrasi();
  final formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

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
                                    ? 'Please provide username'
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
                                return val.length < 14 ? 'cek' : null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.phone),
                                  hintText: 'Nomor HP'),
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              onTap: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: selectedDate,
                                        firstDate: DateTime(1),
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
                                  return 'Relationship is required';
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
                                return val.length < 16 ? 'cek' : null;
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
                                  return 'Relationship is required';
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
                                  return 'Empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.card_membership),
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
                                    : 'Enter correct email';
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
                                  return 'Empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.mail),
                                hintText: 'Alamat',
                              ),
                            ),
                            SizedBox(height: 10),
                            new TextFormField(
                              obscureText: true,
                              controller: pass,
                              validator: (val) {
                                return val.length < 6
                                    ? 'Enter Password 6+ characters'
                                    : null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.vpn_key),
                                  hintText: 'Password',
                                  suffixIcon: InkWell(
                                    child: Icon(Icons.visibility_off),
                                  )),
                            ),
                            SizedBox(height: 10),
                            new TextFormField(
                              obscureText: true,
                              controller: confirmPass,
                              validator: (val) {
                                if (val != pass.text) {
                                  return 'Not Match';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.vpn_key),
                                  hintText: 'Konfirmasi Password',
                                  suffixIcon: InkWell(
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
                                    registrasi.sendRegistrasi();
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
