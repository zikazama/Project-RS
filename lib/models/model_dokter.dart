import 'package:meta/meta.dart';
import 'dart:convert';

ModelDokter modelDokterFromJson(String str) => ModelDokter.fromJson(json.decode(str));

String modelDokterToJson(ModelDokter data) => json.encode(data.toJson());

class ModelDokter {
  ModelDokter({
     this.idDokter,
     this.namaDokter,
     this.noKtp,
     this.password,
     this.spesialis,
  });

  String idDokter;
  String namaDokter;
  String noKtp;
  String password;
  String spesialis;

  factory ModelDokter.fromJson(Map<String, dynamic> json) => ModelDokter(
    idDokter: json["id_dokter"] == null ? null : json["id_dokter"],
    namaDokter: json["nama_dokter"] == null ? null : json["nama_dokter"],
    noKtp: json["no_ktp"] == null ? null : json["no_ktp"],
    password: json["password"] == null ? null : json["password"],
    spesialis: json["spesialis"] == null ? null : json["spesialis"],
  );

  Map<String, dynamic> toJson() => {
    "id_dokter": idDokter == null ? null : idDokter,
    "nama_dokter": namaDokter == null ? null : namaDokter,
    "no_ktp": noKtp == null ? null : noKtp,
    "password": password == null ? null : password,
    "spesialis": spesialis == null ? null : spesialis,
  };
}
