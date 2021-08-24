import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class registrasiPasienServices {
  static Future<void> connectToAPI(
      String nama_lengkap,
      no_hp,
      jenis_kelamin,
      tanggal_lahir,
      no_ktp,
      agama,
      pendidikan,
      alamat,
      email,
      created_at,
      updated_at,
      password) async {
    String usernameAuth = "admin";
    String passwordAuth = "1234";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    String apiURL =
        "https://api.rsbmgeriatri.com/api/Pasien?bhayangkara-key=bhayangkara123";

    Map<String, dynamic> data = {
      "nama_lengkap": nama_lengkap,
      "no_hp": no_hp,
      "tanggal_lahir": tanggal_lahir,
      "jenis_kelamin": jenis_kelamin,
      "no_ktp": no_ktp,
      "agama": agama,
      "pendidikan": pendidikan,
      "alamat": alamat,
      "email": email,
      "created_at": created_at,
      "updated_at": updated_at,
      "password": password
    };
    // print("cetak data : " + data.toString());
    try {
      final response = await http.post(Uri.parse(apiURL),
          headers: <String, String>{'authorization': basicAuth}, body: data);

      print('Status code: ${response.statusCode}');
      // print('Body: ${response.body}');
      if (response.statusCode == 201) {
        return jsonDecode(response.body).toString();
      }
    } catch (e) {
      print("error editProfile Services" + e.toString());
    }
  }
}
