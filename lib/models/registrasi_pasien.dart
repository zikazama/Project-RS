part of 'models.dart';

class registrasiPasien {
  static Future<dynamic> connectToAPI(String nama_lengkap, no_hp, jenis_kelamin,
      no_ktp, agama, pendidikan, alamat, email, created_at, password) async {
    String apiURL =
        "https://api.rsbmgeriatri.com/api/Pasien?bhayangkara-key=bhayangkara123";
    var apiResult = await http.post(apiURL, body: {
      "nama_lengkap": nama_lengkap,
      "no_hp": no_hp,
      "jenis_kelamin": jenis_kelamin,
      "no_ktp": no_ktp,
      "agama": agama,
      "pendidikan": pendidikan,
      "alamat": alamat,
      "email": email,
      "password": password
    });
    print(jsonDecode(apiResult.body));
  }
}
