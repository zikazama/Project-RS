// To parse this JSON data, do
//
//     final postingan = postinganFromJson(jsonString);

import 'dart:convert';

List<Postingan> postinganFromJson(String str) =>
    List<Postingan>.from(json.decode(str).map((x) => Postingan.fromJson(x)));

String postinganToJson(List<Postingan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Postingan {
  Postingan({
    this.idPost,
    this.judul,
    this.gambar,
    this.konten,
    this.plainKonten,
  });

  String idPost;
  String judul;
  String gambar;
  String konten;
  String plainKonten;

  factory Postingan.fromJson(Map<String, dynamic> json) => Postingan(
        idPost: json["id_post"],
        judul: json["judul"],
        gambar: json["gambar"],
        konten: json["konten"],
        plainKonten: json["plain_konten"],
      );

  Map<String, dynamic> toJson() => {
        "id_post": idPost,
        "judul": judul,
        "gambar": gambar,
        "konten": konten,
        "plain_konten": plainKonten,
      };
}
