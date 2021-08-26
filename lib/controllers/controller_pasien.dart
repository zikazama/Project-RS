import 'dart:convert';

import 'package:aplikasi_rs/models/models.dart';
import 'package:aplikasi_rs/registrasi_pasien.dart';
import 'package:aplikasi_rs/services/registrasi_pasien_services.dart';
import 'package:aplikasi_rs/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ControllerPasien extends GetxController {
  var pasien = ModelPasien().obs;

  Future loginPasienController(
      {@required String no_ktp, @required String password}) async {
    return AuthServices()
        .loginPasien(noKtp: no_ktp, password: password)
        .then((value) async {
      print("value c : " + value.toString());
      if (value['status'] == true) {
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: value['user']['email'], password: password);

          if (userCredential.user.emailVerified == true) {
            return value;
          } else {
            Get.defaultDialog(
                title: "Info", middleText: "Email belum diverifikasi");
          }
          print(userCredential.user);
        } on FirebaseAuthException catch (e) {
          print(e);
          if (e.code == 'user-not-found') {
            print('No user found for that email.');
            Get.defaultDialog(title: "Error", middleText: e.code);
          } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user.');
            Get.defaultDialog(title: "Error", middleText: e.code);
          } else {
            Get.defaultDialog(title: "Error", middleText: e.code);
          }
        }
      } else {
        return value;
      }
    }).catchError((e) {
      Get.defaultDialog(title: "Info", content: Text(e.toString()));
    });
  }

  Future registerPasienController(
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
    return registrasiPasienServices
        .connectToAPI(nama_lengkap, no_hp, jenis_kelamin, tanggal_lahir, no_ktp,
            agama, pendidikan, alamat, email, created_at, updated_at, password)
        .then((value) async {
      print("value c : " + value.toString());
      if (value == null) {
        print("daftar gagal");
      } else {
        print("daftar lanjut verif $email  : $password");
        try {
          print("daftar firebase");
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);
          print("user : " + userCredential.user.toString());
          if (!userCredential.user.emailVerified) {
            print("Cek email anda untuk verifikasi");
            print("boleh lanjut");
            String usernameAuth = "admin";
            String passwordAuth = "1234";
            String basicAuth = 'Basic ' +
                base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
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
            final regisResponse = await http.post(Uri.parse(apiURL),
                headers: <String, String>{'authorization': basicAuth},
                body: data);
            print("regisResposne " + regisResponse.statusCode.toString());
            if (regisResponse.statusCode == 200) {
              return jsonDecode(regisResponse.body);
            }
            Get.defaultDialog(
                title: "Info",
                middleText: "Cek email anda untuk verifikasi",
                onConfirm: () {
                  Get.back();
                  Get.back();
                });
            await userCredential.user.sendEmailVerification();
          }
        } on FirebaseAuthException catch (e) {
          print("error fr : " + e.toString());
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
            Get.defaultDialog(title: "Error", middleText: e.code);
          } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
            Get.defaultDialog(title: "Error", middleText: e.code);
          } else {
            Get.defaultDialog(title: "Error", middleText: e.code);
          }
        } catch (e) {
          print(e);
        }
      }
      return value;
    }).catchError((e) {
      Get.defaultDialog(title: "Info", content: Text(e.toString()));
    });
  }
}
