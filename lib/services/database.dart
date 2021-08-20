part of 'services.dart';

TextEditingController namaLengkap = new TextEditingController();
TextEditingController tanggalLahir = new TextEditingController();
TextEditingController noKtp = new TextEditingController();
TextEditingController jenisKelamin = new TextEditingController();
TextEditingController agama = new TextEditingController();
TextEditingController pendidikan = new TextEditingController();
TextEditingController alamat = new TextEditingController();
TextEditingController email = new TextEditingController();
TextEditingController noHp = new TextEditingController();
TextEditingController pass = new TextEditingController();
TextEditingController confirmPass = new TextEditingController();
//TextEditingController created_at = new TextEditingController();
DateTime selectedDate = DateTime.now();
String created_at = selectedDate.toString();

class Registrasi {
  Future<List> sendRegistrasi() async {
    final response = await http.post(
        "https://rsbmgeriatri.com/bhayangkara_geriatri/flutter/pasien.php",
        body: {
          "nama_lengkap": namaLengkap.text,
          "tanggal_lahir": tanggalLahir.text,
          "no_hp": noHp.text,
          "no_ktp": noKtp.text,
          "jenis_kelamin": jenisKelamin.text,
          "agama": agama.text,
          "pendidikan": pendidikan.text,
          "alamat": alamat.text,
          "email": email.text,
          "password": confirmPass.text,
          "created_at": created_at,
        });
  }
}
