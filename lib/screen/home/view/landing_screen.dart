import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/constant/utils_rp.dart';
// import 'package:koperasimobile/model/model_landingpage.dart';
import 'package:koperasimobile/screen/home/view/sub_menu_saldo.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:koperasimobile/constant/colors_icon.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/screen/home/view/profile_screen.dart';
import '../../../constant/image_constant.dart';
// import '../../auth/isitabungan/konfirmasi_isi_tabungan_screen.dart';
// import '../../auth/isitabungan/isi_tabungan_ins_screen.dart';
import '../pengajuan_simp_home.dart';

class LandingScreen extends StatelessWidget {
  final String? saldopinjaman;
  final String? saldosimpanan;

  const LandingScreen({
    Key? key,
    this.saldopinjaman,
    this.saldosimpanan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<Uint8List?> getImageBytes() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? base64Image = prefs.getString('poto');
      if (base64Image != null && base64Image.isNotEmpty) {
        return base64Decode(base64Image);
      }
      return null;
    }

    var size = MediaQuery.of(context).size;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(ImageConstant.cart_logo,
                  height: size.height * 0.050),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Koperasi',
                  style: TextConstant.medium.copyWith(
                    color: Colors.black87,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Sukses Prima Sejahtera',
                  style: TextConstant.medium.copyWith(
                    color: Colors.black87,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => Get.to(ProfileScreen()),
                    child: Row(
                      children: [
                        FutureBuilder<Uint8List?>(
                          future: getImageBytes(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.hasData &&
                                snapshot.data != null) {
                              return ClipOval(
                                child: Image.memory(
                                  snapshot.data!,
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                ),
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        elevation: 0.5,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              Container(
                child: SizedBox(
                  width: width,
                  height: 220,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Lottie.asset(
                            ImageConstant.working,
                            fit: BoxFit.contain,
                            height: 200,
                            width: width,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.primarycolors,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.count(
                              // primary: false,
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(0),
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 4,
                              children: <Widget>[
                                Card(
                                  color: AppColors.abu,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10),
                                  ),
                                  margin: const EdgeInsets.all(5),
                                  child: InkWell(
                                      // onTap: () => Get.to(TopUpPage()),
                                      onTap: () => Get.to(SubMenuSaldo()),
                                      splashColor: Colors.blue,
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(ImageConstant.duet,
                                                height: size.height * 0.06),
                                            SizedBox(height: 10),
                                            Text("Saldo Simpanan",
                                                style: TextStyle(
                                                    fontSize: 8.9,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                  ),
                                ),
                                // Card(
                                //   color: AppColors.abu,
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius:
                                //         BorderRadius.circular(10), // Radius sudut
                                //   ),
                                //   margin: const EdgeInsets.all(5),
                                //   child: InkWell(
                                //       onTap: () => Get.to(SuppInsScreen(
                                //             tipeCheck: 'ini create',
                                //           )),
                                //       // onTap: () => Get.to(Text('BELUM ADA MENU')),
                                //       splashColor: Colors.blue,
                                //       child: Center(
                                //         child: Column(
                                //           mainAxisSize: MainAxisSize.min,
                                //           children: [
                                //             Image.asset(ImageConstant.member,
                                //                 height: size.height * 0.06),
                                //             SizedBox(height: 10),
                                //             Text("Member",
                                //                 style: TextStyle(
                                //                     fontSize: 8.9,
                                //                     fontWeight: FontWeight.bold))
                                //           ],
                                //         ),
                                //       )),
                                // ),
                                // Card(
                                //   color: AppColors.abu,
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius:
                                //         BorderRadius.circular(10), // Radius sudut
                                //   ),
                                //   margin: const EdgeInsets.all(5),
                                //   child: InkWell(
                                //       // onTap: () => Get.to(CustHome()),
                                //       onTap: () => Get.to(SuppHome()),
                                //       splashColor: Colors.blue,
                                //       child: Center(
                                //         child: Column(
                                //           mainAxisSize: MainAxisSize.min,
                                //           children: [
                                //             Image.asset(ImageConstant.shu,
                                //                 height: size.height * 0.06),
                                //             SizedBox(height: 10),
                                //             Text("SHU",
                                //                 style: TextStyle(
                                //                     fontSize: 8.9,
                                //                     fontWeight: FontWeight.bold))
                                //           ],
                                //         ),
                                //       )),
                                // ),
                                Card(
                                  color: AppColors.abu,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10),
                                  ),
                                  margin: const EdgeInsets.all(5),
                                  child: InkWell(
                                      // onTap: () {},
                                      onTap: () => Get.to(AjuSimpHome()),
                                      splashColor: Colors.blue,
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(ImageConstant.pinjaman,
                                                height: size.height * 0.06),
                                            SizedBox(height: 10),
                                            Text("Pinjaman",
                                                style: TextStyle(
                                                    fontSize: 8.9,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                      )),
                                ),
                                // Card(
                                //   color: AppColors.abu,
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius:
                                //         BorderRadius.circular(10), // Radius sudut
                                //   ),
                                //   margin: const EdgeInsets.all(5),
                                //   child: InkWell(
                                //       // onTap: () {},
                                //       onTap: () => Get.to(Text('BELUM ADA MENU')),
                                //       splashColor: Colors.blue,
                                //       child: Center(
                                //         child: Column(
                                //           mainAxisSize: MainAxisSize.min,
                                //           children: [
                                //             Image.asset(ImageConstant.mutasi,
                                //                 height: size.height * 0.06),
                                //             SizedBox(height: 10),
                                //             Text("Mutasi",
                                //                 style: TextStyle(
                                //                     fontSize: 8.9,
                                //                     fontWeight: FontWeight.bold))
                                //           ],
                                //         ),
                                //       )),
                                // ),
                                // Card(
                                //   color: AppColors.abu,
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius:
                                //         BorderRadius.circular(10), // Radius sudut
                                //   ),
                                //   margin: const EdgeInsets.all(5),
                                //   child: InkWell(
                                //       // onTap: () {},
                                //       onTap: () => Get.to(Text('BELUM ADA MENU')),
                                //       splashColor: Colors.blue,
                                //       child: Center(
                                //         child: Column(
                                //           mainAxisSize: MainAxisSize.min,
                                //           children: [
                                //             Image.asset(ImageConstant.rekening,
                                //                 height: size.height * 0.06),
                                //             SizedBox(height: 10),
                                //             Text("Rekening",
                                //                 style: TextStyle(
                                //                     fontSize: 8.9,
                                //                     fontWeight: FontWeight.bold))
                                //           ],
                                //         ),
                                //       )),
                                // ),
                                // Card(
                                //   color: AppColors.abu,
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius:
                                //         BorderRadius.circular(10), // Radius sudut
                                //   ),
                                //   margin: const EdgeInsets.all(5),
                                //   child: InkWell(
                                //       // onTap: () {},
                                //       onTap: () => Get.to(Text('BELUM ADA MENU')),
                                //       splashColor: Colors.blue,
                                //       child: Center(
                                //         child: Column(
                                //           mainAxisSize: MainAxisSize.min,
                                //           children: [
                                //             Image.asset(ImageConstant.setting,
                                //                 height: size.height * 0.06),
                                //             SizedBox(height: 10),
                                //             Text("Bantuan",
                                //                 style: TextStyle(
                                //                     fontSize: 8.9,
                                //                     fontWeight: FontWeight.bold))
                                //           ],
                                //         ),
                                //       )),
                                // ),
                                // Card(
                                //   color: AppColors.abu,
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius:
                                //         BorderRadius.circular(10), // Radius sudut
                                //   ),
                                //   margin: const EdgeInsets.all(5),
                                //   child: InkWell(
                                //       onTap: () => Get.to(() => SettInsScreen()),
                                //       // onTap: () => Get.to(Text('BELUM ADA MENU')),
                                //       splashColor: Colors.blue,
                                //       child: Center(
                                //         child: Column(
                                //           mainAxisSize: MainAxisSize.min,
                                //           children: [
                                //             Image.asset(ImageConstant.role,
                                //                 height: size.height * 0.06),
                                //             SizedBox(height: 10),
                                //             Text("Setting Role",
                                //                 style: TextStyle(
                                //                     fontSize: 8.9,
                                //                     fontWeight: FontWeight.bold))
                                //           ],
                                //         ),
                                //       )),
                                // ),
                              ],
                            ),
                          ),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     SizedBox(height: 20),
                          //     Container(
                          //       color: AppColors.primarycolors,
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Column(
                          //             children: [
                          //               Padding(
                          //                 padding: const EdgeInsets.all(8.0),
                          //                 child: Text(
                          //                   "Terbaru Dari Koperasi",
                          //                   style: TextStyle(
                          //                     fontSize: 20,
                          //                     fontWeight: FontWeight.bold,
                          //                   ),
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //           Column(
                          //             children: [
                          //               Padding(
                          //                 padding: const EdgeInsets.all(8.0),
                          //                 child: Icon(
                          //                   Icons.more_horiz,
                          //                   size: 45,
                          //                   color: AppColors.greenn,
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //     // SingleChildScrollView(
                          //     //   scrollDirection: Axis.horizontal,
                          //     //   child: Row(
                          //     //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     //     children: [
                          //     //       Container(
                          //     //           child: Image.asset(
                          //     //         'assets/images/promo1.png',
                          //     //         width: 250,
                          //     //         height: 100,
                          //     //       )),
                          //     //       SizedBox(width: 15),
                          //     //       Container(
                          //     //           child: Image.asset(
                          //     //         'assets/images/promo2.png',
                          //     //         width: 250,
                          //     //         height: 100,
                          //     //       )),
                          //     //       SizedBox(width: 0),
                          //     //       Container(
                          //     //           child: Image.asset(
                          //     //         'assets/images/ngegame.png',
                          //     //         width: 250,
                          //     //         height: 100,
                          //     //       )),
                          //     //     ],
                          //     //   ),
                          //     // ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: width,
            height: height,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 190,
                  child: Container(
                    width: width,
                    padding: const EdgeInsets.all(0.0),
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primarycolors,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.grey,
                                width: 0.25,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Saldo Pinjaman',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.0),
                                      ),
                                      Text(
                                        'Rp. ${duet(saldopinjaman!)}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: 2,
                                  color: Colors.grey,
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Saldo Simpanan',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.0),
                                      ),
                                      Text(
                                        'Rp. ${duet(saldosimpanan!)}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
