import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailInformasi extends StatelessWidget {
  final dynamic informasi;

  DetailInformasi({@required this.informasi});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(
            height: 62,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  offset: Offset(0, 3))
            ]),
            child: Column(
              children: [
                Image.network(
                  'http://admin.rsbmgeriatri.com/asset/' + informasi.gambar,
                  fit: BoxFit.cover,
                  height: 166,
                  width: double.infinity,
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      informasi.judul,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Html(data: informasi.konten),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: 51,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color(0XFF7380F3),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5))),
          child: Center(
            child: Icon(
              Icons.home,
              size: 35,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
