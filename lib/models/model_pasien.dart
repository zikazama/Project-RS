// To parse this JSON data, do
//
//     final modelPasien = modelPasienFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ModelPasien modelPasienFromJson(String str) =>
    ModelPasien.fromJson(json.decode(str));

String modelPasienToJson(ModelPasien data) => json.encode(data.toJson());

class ModelPasien {
  ModelPasien({
    this.idPasien,
    this.namaLengkap,
    this.noHp,
    this.tanggalLahir,
    this.noKtp,
    this.jenisKelamin,
    this.agama,
    this.pendidikan,
    this.alamat,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.password,
  });

  String idPasien;
  String namaLengkap;
  String noHp;
  String tanggalLahir;
  String noKtp;
  String jenisKelamin;
  String agama;
  String pendidikan;
  String alamat;
  String email;
  String createdAt;
  String updatedAt;
  String password;

  factory ModelPasien.fromJson(Map<String, dynamic> json) => ModelPasien(
        idPasien: json["id_pasien"] == null ? null : json["id_pasien"],
        namaLengkap: json["nama_lengkap"] == null ? null : json["nama_lengkap"],
        noHp: json["no_hp"] == null ? null : json["no_hp"],
        tanggalLahir:
            json["tanggal_lahir"] == null ? null : json["tanggal_lahir"],
        noKtp: json["no_ktp"] == null ? null : json["no_ktp"],
        jenisKelamin:
            json["jenis_kelamin"] == null ? null : json["jenis_kelamin"],
        agama: json["agama"] == null ? null : json["agama"],
        pendidikan: json["pendidikan"] == null ? null : json["pendidikan"],
        alamat: json["alamat"] == null ? null : json["alamat"],
        email: json["email"] == null ? null : json["email"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        password: json["password"] == null ? null : json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id_pasien": idPasien == null ? null : idPasien,
        "nama_lengkap": namaLengkap == null ? null : namaLengkap,
        "no_hp": noHp == null ? null : noHp,
        "tanggal_lahir": tanggalLahir == null ? null : tanggalLahir,
        "no_ktp": noKtp == null ? null : noKtp,
        "jenis_kelamin": jenisKelamin == null ? null : jenisKelamin,
        "agama": agama == null ? null : agama,
        "pendidikan": pendidikan == null ? null : pendidikan,
        "alamat": alamat == null ? null : alamat,
        "email": email == null ? null : email,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "password": password == null ? null : password,
      };
}
