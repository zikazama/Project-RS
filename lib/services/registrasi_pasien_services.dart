import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class registrasiPasienServices {
  static Future connectToAPI(
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
      final response = await http.get(Uri.parse(apiURL),
          headers: <String, String>{'authorization': basicAuth});
      print('Status code: ${response.statusCode}');
      print('response Body: ' + response.statusCode.toString());
      print('Body: ${response.runtimeType.toString()}');
      bool flagRegis = false;

      if (response.statusCode == 200) {
        List listPasiens = jsonDecode(response.body);

        listPasiens.forEach((element) {
          if (element['email'] == email) {
            print("ada");
            Get.defaultDialog(
                title: "Info", middleText: "Email sudah terdaftar");
            flagRegis = false;
            throw false;
          } else if (element['no_ktp'] == no_ktp) {
            print("ada");
            Get.defaultDialog(title: "Info", middleText: "NIK sudah terdaftar");
            flagRegis = false;
            throw false;
          }
        });
      }
      // } else if (response.statusCode == 404) {
      //   print("masuk");

      //   return true;
      // }
      // final regisResponse = await http.post(Uri.parse(apiURL),
      //     headers: <String, String>{'authorization': basicAuth}, body: data);
      // print("regisResposne " + regisResponse.statusCode.toString());
      // if (regisResponse.statusCode == 200) {
      //   return jsonDecode(regisResponse.body);
      // }
      // return jsonDecode(regisResponse.body);
      return true;
    } catch (e) {
      print("error connectToAPI Services" + e.toString());
    }
  }
}
