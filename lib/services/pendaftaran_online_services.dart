import 'package:http/http.dart' as http;
import 'dart:convert';

class PendaftaranOnlinePasienServices {
  static Future<void> connectToAPI(
      String idPasien, tgl_periksa, idDokter, jenis_bayar, foto_bpjs) async {
    String usernameAuth = "admin";
    String passwordAuth = "1234";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    String apiURL =
        "https://api.rsbmgeriatri.com/api/Pemeriksaan?bhayangkara-key=bhayangkara123";
    Map<String, dynamic> data = {
      "pasien_id": idPasien,
      "tanggal_periksa": tgl_periksa,
      "dokter_id": idDokter,
      "jenis_bayar": jenis_bayar,
      "file": foto_bpjs
    };
    try {
      final response = await http.post(Uri.parse(apiURL),
          headers: <String, String>{'authorization': basicAuth}, body: data);

      print('Status code: ${response.statusCode}');
      print('Body: ${response.body}');
      if (response.statusCode == 201) {
        return jsonDecode(response.body).toString();
      }
    } catch (e) {
      print("error editProfile Services" + e.toString());
    }
  }
}
