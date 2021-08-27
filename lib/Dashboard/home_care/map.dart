import 'package:aplikasi_rs/Dashboard/home_care/homecare.dart';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  BitmapDescriptor customIcon, mapMarker;
  Set<Marker> markers = {};
  GoogleMapController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    markers = Set.from([]);
    setCustomMarker();
  }

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), "assets/icons/current-location.png");
  }

  Future getCurrentLocation() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitudeMap1, longitudeMap1);
    location1 = placemarks[0].toJson();
    print("loationmasuk");
    setState(() {});
  }

  createMarker(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, "assets/icons/marker.png")
          .then((icon) {
        setState(() {
          customIcon = icon;
        });
      });
    }
  }

  void _onMapCreated(GoogleMapController _cntrl) {
    setState(() {
      _controller = _cntrl;
      markers.add(Marker(
        markerId: MarkerId("id-1"),
        position: LatLng(latitudeMap, longitudeMap),
        icon: mapMarker,
        //infoWindow: InfoWindow(title: "Posisi anda")
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    createMarker(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF7380F3),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Row(
              children: <Widget>[
                SizedBox(width: 25),
                Icon(Icons.arrow_back, color: Colors.white),
                SizedBox(width: 5),
                Container(
                  child: Text("Lokasi Anda",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 24.0)),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          Expanded(
            child: Stack(children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width * 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    markers: markers,
                    onTap: (pos) {
                      print(pos);
                      Marker m = Marker(
                          markerId: MarkerId('1'),
                          icon: customIcon,
                          position: pos);
                      setState(() {
                        markers.add(m);

                        latitudeMap1 = double.tryParse(
                            "$pos".replaceAll('LatLng(', '').split(',')[0]);
                        longitudeMap1 = double.tryParse(
                            "$pos".replaceAll(')', '').split(',')[1]);

                        print("latitudeMap1 " + latitudeMap1.toString());
                        print("longitudeMap1 " + longitudeMap1.toString());
                      });
                    },
                    initialCameraPosition: CameraPosition(
                        target: LatLng(latitudeMap, longitudeMap), zoom: 18),
                  )),
              GestureDetector(
                onTap: () {
                  getCurrentLocation();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeCare()));
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: 65.0,
                      right: 65.0,
                      top: MediaQuery.of(context).size.height * 0.730),
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color(0xFF7380F3),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text("Pilih Lokasi",
                        style: TextStyle(color: Colors.white, fontSize: 14.0)),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
