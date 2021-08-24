import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DokterServices {
  Future<dynamic> getDokterList() async {
    String usernameAuth = "admin";
    String passwordAuth = "1234";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);

    try {
      final response = await http.get(
          Uri.parse(
              "https://api.rsbmgeriatri.com/api/Dokter?bhayangkara-key=bhayangkara123"),
          headers: <String, String>{'authorization': basicAuth});

      print("hasil auth : " + response.body.toString());
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("error getDokterList Services" + e.toString());
    }
  }
}
