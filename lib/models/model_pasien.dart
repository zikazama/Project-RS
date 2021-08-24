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
  });

  String idPasien;
  String namaLengkap;
  String noHp;
  DateTime tanggalLahir;
  String noKtp;
  String jenisKelamin;
  String agama;
  String pendidikan;
  String alamat;
  String email;

  ModelPasien copyWith({
    String idPasien,
    String namaLengkap,
    String noHp,
    DateTime tanggalLahir,
    String noKtp,
    String jenisKelamin,
    String agama,
    String pendidikan,
    String alamat,
    String email,
  }) =>
      ModelPasien(
        idPasien: idPasien ?? this.idPasien,
        namaLengkap: namaLengkap ?? this.namaLengkap,
        noHp: noHp ?? this.noHp,
        tanggalLahir: tanggalLahir ?? this.tanggalLahir,
        noKtp: noKtp ?? this.noKtp,
        jenisKelamin: jenisKelamin ?? this.jenisKelamin,
        agama: agama ?? this.agama,
        pendidikan: pendidikan ?? this.pendidikan,
        alamat: alamat ?? this.alamat,
        email: email ?? this.email,
      );

  factory ModelPasien.fromJson(Map<String, dynamic> json) => ModelPasien(
        idPasien: json["id_pasien"] == null ? null : json["id_pasien"],
        namaLengkap: json["nama_lengkap"] == null ? null : json["nama_lengkap"],
        noHp: json["no_hp"] == null ? null : json["no_hp"],
        tanggalLahir: json["tanggal_lahir"] == null
            ? null
            : DateTime.parse(json["tanggal_lahir"]),
        noKtp: json["no_ktp"] == null ? null : json["no_ktp"],
        jenisKelamin:
            json["jenis_kelamin"] == null ? null : json["jenis_kelamin"],
        agama: json["agama"] == null ? null : json["agama"],
        pendidikan: json["pendidikan"] == null ? null : json["pendidikan"],
        alamat: json["alamat"] == null ? null : json["alamat"],
        email: json["email"] == null ? null : json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id_pasien": idPasien == null ? null : idPasien,
        "nama_lengkap": namaLengkap == null ? null : namaLengkap,
        "no_hp": noHp == null ? null : noHp,
        "tanggal_lahir": tanggalLahir == null
            ? null
            : "${tanggalLahir.year.toString().padLeft(4, '0')}-${tanggalLahir.month.toString().padLeft(2, '0')}-${tanggalLahir.day.toString().padLeft(2, '0')}",
        "no_ktp": noKtp == null ? null : noKtp,
        "jenis_kelamin": jenisKelamin == null ? null : jenisKelamin,
        "agama": agama == null ? null : agama,
        "pendidikan": pendidikan == null ? null : pendidikan,
        "alamat": alamat == null ? null : alamat,
        "email": email == null ? null : email,
      };
}
