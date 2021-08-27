import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  Future<dynamic> loginPasien(
      {@required String noKtp, @required String password}) async {
    String usernameAuth = "admin";
    String passwordAuth = "1234";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);

    try {
      final response = await http.post(
          Uri.parse("https://api.rsbmgeriatri.com/api/Pasien/login"),
          headers: <String, String>{
            'authorization': basicAuth
          },
          body: {
            "no_ktp": noKtp,
            "password": password,
          });

      print("hasil auth : " + response.body.toString());
      //response sukses
      return jsonDecode(response.body);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<dynamic> getPasien() async {
    String usernameAuth = "admin";
    String passwordAuth = "1234";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);

    try {
      final response = await http.get(
          Uri.parse("https://api.rsbmgeriatri.com/api/Pasien/login"),
          headers: <String, String>{'authorization': basicAuth});

      print("hasil auth : " + response.body.toString());
      //response sukses
      return jsonDecode(response.body);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<dynamic> loginDokter(
      {@required String noKtp, @required String password}) async {
    String usernameAuth = "admin";
    String passwordAuth = "1234";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);

    try {
      final response = await http.post(
          Uri.parse("https://api.rsbmgeriatri.com/api/Dokter/login"),
          headers: <String, String>{
            'authorization': basicAuth
          },
          body: {
            "no_ktp": noKtp,
            "password": password,
          });

      print("hasil auth : " + response.body.toString());
      //response sukses
      return jsonDecode(response.body);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
