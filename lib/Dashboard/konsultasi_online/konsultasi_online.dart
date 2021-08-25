import 'package:aplikasi_rs/Dashboard/dashboard_pasien.dart';
import 'package:aplikasi_rs/config/theme.dart';
import 'package:aplikasi_rs/controllers/controller_chat.dart';
import 'package:aplikasi_rs/controllers/controller_dokter.dart';
import 'package:aplikasi_rs/models/model_dokter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

List userDokter = [
  {
    'name': 'Susanto',
    'Status': 'Dokter spesialis THT',
  },
  {
    'name': 'Susanti',
    'Status': 'Dokter spesialis penyakit dalam',
  },
  {
    'name': 'Ginting',
    'Status': 'Dokter spesialis HTH',
  },
  {
    'name': 'Tes',
    'Status': 'Dokter spesialis beda',
  },
  {
    'name': 'Tes',
    'Status': 'Dokter spesialis beda',
  },
  {
    'name': 'Tes',
    'Status': 'Dokter spesialis beda',
  },
  {
    'name': 'Tes',
    'Status': 'Dokter spesialis beda',
  },
  {
    'name': 'Tes',
    'Status': 'Dokter spesialis beda',
  },
  {
    'name': 'Tes',
    'Status': 'Dokter spesialis beda',
  },
];

class KonsultasiOnline extends StatefulWidget {
  @override
  _KonsultasiOnlineState createState() => _KonsultasiOnlineState();
}

class _KonsultasiOnlineState extends State<KonsultasiOnline> {
  ControllerDokter controllerDokter = Get.find<ControllerDokter>();
  ControllerChat controllerChat = Get.find<ControllerChat>();
  bool loading = false;
  List<ModelDokter> _filterDokter = [];

  _onLoading() => setState(() => loading = true);
  _offLoading() => setState(() => loading = false);

  makeNewChat(int index)async{
    _onLoading();
   return controllerChat.addNewConnection(
        controllerChat.user.value.nik,
        (_filterDokter.length > 0)
            ? _filterDokter[index].namaDokter
            : controllerDokter
            .dokterList[index].noKtp).then((value) {
              _offLoading();
   }).catchError((e){
     _offLoading();
     Get.snackbar("error", "gagal", backgroundColor: Colors.red);
   });
  }

  getDataDokter() async {
    _onLoading();
    await controllerDokter.getListDokterController().then((value) {
      print("value ui : " + value.toString());
      _offLoading();
    }).catchError((e) {
      _offLoading();
      print("error ui : " + e.toString());
    });
  }

  List<ModelDokter> _buildSearchList(String keyword) {
    List<ModelDokter> _searchList = [];

    for (int i = 0; i < controllerDokter.dokterList.length; i++) {
      String name = controllerDokter.dokterList[i].namaDokter;
      if (name.toLowerCase().contains(keyword.toLowerCase())) {
        _searchList.add(controllerDokter.dokterList[i]);
      }
    }

    return _searchList;
  }

  @override
  void initState() {
    getDataDokter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: loading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(delegate: MyHeader()),
            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.white,
              elevation: 0,
              title: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: -1,
                      blurRadius: 21,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.search_rounded,
                      color: const Color(0xFF8F8F8F),
                      size: 30,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: TextField(
                            onChanged: (v) {
                              setState(() {
                                _filterDokter = _buildSearchList(v);
                              });
                            },
                            style: TextStyle(fontSize: 17),
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              hintText: 'Cari Dokter',
                              hintStyle: TextStyle(fontSize: 17),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ))),
                  ],
                ),
              ),
              automaticallyImplyLeading: false,
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            loading
                ? SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  )
                : Obx(
                    () => controllerDokter.dokterList.length == 0
                        ? SliverToBoxAdapter(
                            child: Center(child: Text("Kosong")),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  print("Nik : " +controllerDokter.dokterList[index].noKtp.toString());
                            return Container(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {
                                 makeNewChat(index);
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(left: 15),
                                  margin: const EdgeInsets.only(
                                      bottom: 40, left: 24, right: 24),
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: -1,
                                        blurRadius: 20,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: AppColor.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                      ),
                                      SizedBox(
                                        width: 14,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            (_filterDokter.length > 0)
                                                ? _filterDokter[index]
                                                    .namaDokter
                                                : controllerDokter
                                                    .dokterList[index]
                                                    .namaDokter,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            (_filterDokter.length > 0)
                                                ? _filterDokter[index].spesialis
                                                : controllerDokter
                                                    .dokterList[index]
                                                    .spesialis,
                                            style: TextStyle(fontSize: 14),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                                childCount: (_filterDokter.length > 0)
                                    ? _filterDokter.length
                                    : controllerDokter.dokterList.length)),
                  )
          ],
        ),
      ),
    );
    // return Scaffold(
    //   backgroundColor: const Color(0xFFFFFFFF),
    //   body: Container(
    //     child: Column(
    //       children: <Widget>[
    //         Stack(
    //           children: <Widget>[
    //             Positioned(
    //               child: Container(
    //                 height: 250,
    //                 decoration: BoxDecoration(
    //                     image: DecorationImage(
    //                   image: AssetImage('assets/images/wave_chat.png'),
    //                   fit: BoxFit.fill,
    //                 )),
    //                 child: Stack(
    //                   children: <Widget>[
    //                     Positioned(
    //                         child: Container(
    //                             margin: EdgeInsets.only(
    //                                 bottom: MediaQuery.of(context).size.height *
    //                                     0.120),
    //                             child: Center(
    //                                 child: Text(
    //                               "Konsultasi Online",
    //                               textAlign: TextAlign.center,
    //                               style: TextStyle(
    //                                 color: Colors.white,
    //                                 fontWeight: FontWeight.bold,
    //                                 fontSize: 24,
    //                               ),
    //                             )))),
    //                     Positioned(
    //                         child: GestureDetector(
    //                       onTap: () {
    //                         Navigator.push(
    //                             context,
    //                             MaterialPageRoute(
    //                                 builder: (context) => DashboardPasien()));
    //                       },
    //                       child: Container(
    //                         padding: EdgeInsets.only(left: 20.0),
    //                         margin: EdgeInsets.only(
    //                             top:
    //                                 MediaQuery.of(context).size.height * 0.100),
    //                         child: Icon(
    //                           Icons.arrow_back_rounded,
    //                           color: Colors.white,
    //                           size: 33,
    //                         ),
    //                       ),
    //                     ))
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //         Container(
    //           margin: const EdgeInsets.only(left: 24.0, right: 24.0),
    //           padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 25),
    //           decoration: BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.circular(10),
    //             boxShadow: [
    //               BoxShadow(
    //                 color: Colors.grey.withOpacity(0.5),
    //                 spreadRadius: -1,
    //                 blurRadius: 21,
    //                 offset: Offset(0, 0),
    //               ),
    //             ],
    //           ),
    //           child: Row(
    //             children: <Widget>[
    //               Icon(
    //                 Icons.search_rounded,
    //                 color: const Color(0xFF8F8F8F),
    //                 size: 30,
    //               ),
    //               SizedBox(
    //                 width: 5,
    //               ),
    //               Expanded(
    //                   child: TextField(
    //                       style: TextStyle(fontSize: 17),
    //                       cursorColor: Colors.black,
    //                       decoration: const InputDecoration(
    //                         hintText: 'Cari Dokter',
    //                         hintStyle: TextStyle(fontSize: 17),
    //                         border: InputBorder.none,
    //                         focusedBorder: InputBorder.none,
    //                         enabledBorder: InputBorder.none,
    //                         errorBorder: InputBorder.none,
    //                         disabledBorder: InputBorder.none,
    //                       ))),
    //             ],
    //           ),
    //         ),
    //         Expanded(
    //           child: Container(
    //             margin: const EdgeInsets.only(top: 25),
    //             child: Inbox(),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}

class MyHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: Get.height * 0.3,
            width: Get.width,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/wave_chat.png'),
              fit: BoxFit.fill,
            )),
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: MediaQuery.of(context).padding.top * 2,
                    child: Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.white,
                              size: 33,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Konsultasi Online",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Spacer()
                        ],
                      ),
                    )),
              ],
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.only(left: 24.0, right: 24.0),
          //   padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 25),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(10),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey.withOpacity(0.5),
          //         spreadRadius: -1,
          //         blurRadius: 21,
          //         offset: Offset(0, 0),
          //       ),
          //     ],
          //   ),
          //   child: Row(
          //     children: <Widget>[
          //       Icon(
          //         Icons.search_rounded,
          //         color: const Color(0xFF8F8F8F),
          //         size: 30,
          //       ),
          //       SizedBox(
          //         width: 5,
          //       ),
          //       Expanded(
          //           child: TextField(
          //               style: TextStyle(fontSize: 17),
          //               cursorColor: Colors.black,
          //               decoration: const InputDecoration(
          //                 hintText: 'Cari Dokter',
          //                 hintStyle: TextStyle(fontSize: 17),
          //                 border: InputBorder.none,
          //                 focusedBorder: InputBorder.none,
          //                 enabledBorder: InputBorder.none,
          //                 errorBorder: InputBorder.none,
          //                 disabledBorder: InputBorder.none,
          //               ))),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => Get.height * 0.3;

  @override
  // TODO: implement minExtent
  double get minExtent => Get.height * 0.3;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}
//data dabbing

class _InboxState extends State<Inbox> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //physics: NeverScrollableScrollPhysics(),
      itemCount: userDokter.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.only(left: 15),
          margin: const EdgeInsets.only(bottom: 40, left: 24, right: 24),
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: -1,
                blurRadius: 20,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(50)),
              ),
              SizedBox(
                width: 14,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Dr. ${userDokter[index]['name']}',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    userDokter[index]['Status'],
                    style: TextStyle(fontSize: 14),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
