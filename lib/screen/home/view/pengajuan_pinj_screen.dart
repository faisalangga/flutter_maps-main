import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:koperasimobile/constant/const_url.dart';
// import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/constant/utils_rp.dart';
import 'package:koperasimobile/model/model_search_pinjaman.dart';
import 'package:koperasimobile/screen/auth/pengajuan_simp/pengajuan_simp_edit_screen.dart';
import 'package:koperasimobile/screen/auth/pengajuan_simp/pengajuan_simp_ins_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/image_constant.dart';
import '../../../constant/text_constant.dart';

class Pinjaman {
  bool? error;
  String? errorMessage;
  List<DataView>? data;

  Pinjaman({this.error, this.errorMessage, this.data});

  factory Pinjaman.fromJson(Map<String, dynamic> json) {
    return Pinjaman(
      error: json["error"],
      errorMessage: json["error_message"],
      data: json["data"] == null
          ? null
          : (json["data"] as List).map((e) => DataView.fromJson(e)).toList(),
    );
  }
}

class Data {
  String? title;
  List<Data1>? data;

  Data({this.title, this.data});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      title: json["title"],
      data: json["data"] == null
          ? null
          : (json["data"] as List).map((e) => Data1.fromJson(e)).toList(),
    );
  }
}

class Data1 {
  String? angsuran;
  String? cBranch;
  String? cDocno;
  String? cStatus;
  String? cdocno;
  String? cjaminan;
  String? cnote;
  String? jasa;
  String? mBadmin;
  String? mNilaiPinjaman;
  String? mPokok;
  String? mSisa1;
  String? mSisa2;
  String? mValue1;
  String? mValue2;
  String? nJasaPinjaman;
  String? pinjaman;
  String? tenor;
  String? tgl;

  Data1(
      {this.angsuran,
      this.cBranch,
      this.cDocno,
      this.cStatus,
      this.cdocno,
      this.cjaminan,
      this.cnote,
      this.jasa,
      this.mBadmin,
      this.mNilaiPinjaman,
      this.mPokok,
      this.mSisa1,
      this.mSisa2,
      this.mValue1,
      this.mValue2,
      this.nJasaPinjaman,
      this.pinjaman,
      this.tenor,
      this.tgl});

  factory Data1.fromJson(Map<String, dynamic> json) {
    return Data1(
      angsuran: json["angsuran"],
      cdocno: json["cDocno"],
      cStatus: json["cStatus"],
      cjaminan: json["cjaminan"],
      cnote: json["cnote"],
      mBadmin: json["mBadmin"],
      mNilaiPinjaman: json["mNilaiPinjaman"],
      mPokok: json["mPokok"],
      mSisa1: json["mSisa1"],
      tgl: json["tgl"],
    );
  }
}

class PinjamanGridWidget extends StatefulWidget {
  const PinjamanGridWidget({Key? key}) : super(key: key);

  @override
  _PinjamanGridWidgetState createState() => _PinjamanGridWidgetState();
}

class _PinjamanGridWidgetState extends State<PinjamanGridWidget> {
  List<DataView> inidatas = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchPinjamans();
  }

  void performSearch(String value) {
    setState(() {
      _searchQuery = value;
      // print('fais $value');
    });
  }

  Future<void> fetchPinjamans() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var cuser = preferences.getString("cmember");
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      Map<String, String> body = {
        'input': '$cuser',
      };
      final response = await http.post(
        Uri.parse(ConstUrl.BASE_URL_VIEW_PINJAMAN),
        headers: headers,
        body: json.encode(body),
      );
      // print('fais $cuser');
      // print('fais ${response.statusCode}');
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final Pinjaman datanya = Pinjaman.fromJson(jsonData);
        print('faisxxxx $jsonData');

        if (datanya.data != null && datanya.data!.isNotEmpty) {
          setState(() {
            inidatas = datanya.data!;
            print('fais $inidatas');
          });
        } else {
          print('fais ERROR data kosong');
        }
      } else {
        print(' fais Error: ${response.statusCode}');
      }
    } catch (error) {
      print(' faisError: $error');
    }
  }

  bool _searchMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _searchMode
            ? TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Cari...',
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.black),
                onChanged: performSearch,
              )
            : Text(
                'Data Pengajuan Pinjaman',
                style: TextConstant.regular.copyWith(
                    fontSize: 19.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _searchMode = !_searchMode;
                print('faisxx $_searchMode');
              });
            },
            icon: Icon(
              _searchMode ? Icons.close : Icons.search,
              color: Colors.black,
            ),
          ),
        ],
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(CupertinoIcons.back, color: Colors.black),
        ),
        centerTitle: true,
      ),
      // body: ListView.builder(
      //   itemCount: _searchMode
      //       ? inidatas
      //           .where((pinjaman) => pinjaman.cdocno!
      //               .toLowerCase()
      //               .contains(_searchQuery.toLowerCase()))
      //           .length
      //       : inidatas.length,
      //   itemBuilder: (context, index) {
      //     final inipinj = _searchMode
      //         ? inidatas.where((inipinj) => inipinj.cdocno!
      //             .toLowerCase()
      //             .contains(_searchQuery.toLowerCase()))
      //         : inidatas;
      //     final filteredPinj = inipinj.elementAt(index);
      //     return buildPinjamanCard(filteredPinj);
      //   },
      // ),
      body: inidatas.isEmpty
          ? Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      ImageConstant.lotienodata,
                      fit: BoxFit.contain,
                      height: 350,
                      width: 400,
                    ),
                    Text(
                      '',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            )
          : ListView.builder(
              itemCount: _searchMode
                  ? inidatas
                      .where((pinjaman) => pinjaman.cdocno!
                          .toLowerCase()
                          .contains(_searchQuery.toLowerCase()))
                      .length
                  : inidatas.length,
              itemBuilder: (context, index) {
                final inipinj = _searchMode
                    ? inidatas.where((inipinj) => inipinj.cdocno!
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase()))
                    : inidatas;
                print('faisxxx $inidatas');
                final filteredPinj = inipinj.elementAt(index);
                return buildPinjamanCard(filteredPinj);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          bool isPendingApproval = !inidatas.any((pinjaman) => pinjaman.cStatus == '3');
          print('faisinidata + $isPendingApproval');
          if (isPendingApproval) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Peringatan'),
                  content: Text('Tidak dapat membuat pinjaman baru, Ada pinjaman belum Approve Final.'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Tutup'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AjuSimpInsScreen(
                  tipeCheck: 'ini create',
                ),
              ),
            );
          }
        },
        icon: Icon(Icons.add_circle),
        label: Text('Add'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget buildPinjamanCard(DataView pinjaman) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PengajuanEdtScreen(
                tipeCheck: 'ini edit',
                cdocno: '${pinjaman.cdocno}',
                pokok: '${pinjaman.mValue1 ?? '0'}',
                jasa: '${pinjaman.nJasaPinjaman}',
                pinjaman: '${pinjaman.mNilaiPinjaman ?? '0'}',
                tenor: '${pinjaman.tenor}',
                badmin: '${pinjaman.mBadmin ?? '0'}',
                angsuran: '${pinjaman.angsuran ?? '0'}',
                keperluan: '${pinjaman.cnote}',
                jaminan: '${pinjaman.cjaminan}'),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 0.0),
        child: Card(
          elevation: 2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                color: Colors.black,
                width: 0.5,
              ),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                  pinjaman.cStatus != '3'
                      ? "assets/images/checklist.png"
                      : "assets/images/rejected.png",
                ),
                backgroundColor: pinjaman.cStatus != '3'
                    ? Colors.green.shade200
                    : Colors.lightBlue.shade100,
                radius: 20,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.shade100,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        '${pinjaman.cdocno ?? '(belum ada)'}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  pinjaman.cStatus == '0'
                      ? IconButton(
                          icon: Stack(
                            children: <Widget>[
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.lightBlue.shade100,
                                ),
                              ),
                              Center(
                                child: Icon(
                                  Icons.delete_forever_sharp,
                                  color: Colors.redAccent.shade400,
                                  size: 30.0,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            // Logika penghapusan di sini
                            // Contoh: fungsiHapusItem(product);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Tidak Bisa Hapus',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  // content: Text('Pesan atau alasan mengapa item ini tidak dapat dihapus.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Tutup'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        )
                      : SizedBox(height: 40),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          // color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          ' Pinjaman : ${duet(pinjaman.mNilaiPinjaman ?? '')}   ',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3),
                  Text(
                    '  ${pinjaman.tgl}',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 3),
                  Text(
                    '  Tenor : ${pinjaman.tenor} Bulan',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            'Pinjaman Grid Example',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: PinjamanGridWidget(),
        backgroundColor: Colors.white,
      ),
    ),
  );
}
