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
      final response = await http.get(
          Uri.parse(
              "https://api.rsbmgeriatri.com/api/Pasien?bhayangkara-key=bhayangkara123"),
          headers: <String, String>{'authorization': basicAuth});

      print("hasil auth : " + response.body.toString());
      var data;
      //response sukses
      if (response.statusCode == 200) {
        List listPasien = jsonDecode(response.body);
        print(listPasien.runtimeType.toString());
        print(listPasien[0].toString());
        //kembalikan data sesuai username password
        listPasien.forEach((element) {
          print("ktp : " + element.containsValue(noKtp).toString());
          print("password : " + element.containsValue(password).toString());
          if (element.containsValue(noKtp) && element.containsValue(password)) {
            print("cek" + element.runtimeType.toString());

            data = element;
          }
        });
      }
      print("data : " + data.toString());

      return data;
    } catch (e) {
      print(e.toString());
    }
  }

//TODO:: BELUM DI COBA
  Future<dynamic> loginDokter(
      {@required String noKtp, @required String password}) async {
    String usernameAuth = "admin";
    String passwordAuth = "1234";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);

    try {
      final response = await http.get(
          Uri.parse(
              "https://api.rsbmgeriatri.com/api/Pasien?bhayangkara-key=bhayangkara123"),
          headers: <String, String>{'authorization': basicAuth});

      print("hasil auth : " + response.body.toString());
      var data;
      //response sukses
      if (response.statusCode == 200) {
        List listPasien = jsonDecode(response.body);
        print(listPasien.runtimeType.toString());
        print(listPasien[0].toString());
        //kembalikan data sesuai username password
        listPasien.forEach((element) {
          print("ktp : " + element.containsValue(noKtp).toString());
          print("password : " + element.containsValue(password).toString());
          if (element.containsValue(noKtp) && element.containsValue(password)) {
            print("cek" + element.runtimeType.toString());

            data = element;
          }
        });
      }
      print("data : " + data.toString());

      return data;
    } catch (e) {
      print(e.toString());
    }
  }
}
