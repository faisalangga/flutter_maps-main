import 'dart:async';

// import 'dart:convert';
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:intl/intl.dart';
import 'package:koperasimobile/model/model_landingpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:koperasimobile/controller/home_controller.dart';

// import 'package:koperasimobile/screen/home/pengajuan_simp_home.dart';
import 'package:koperasimobile/screen/home/view/landing_screen.dart';
import 'package:koperasimobile/screen/home/view/profile_screen.dart';

import '../../api/api.dart';
import '../../constant/const_url.dart';
import '../../constant/text_constant.dart';
// import '../../utils/utils_dialog.dart';

class LandingHome extends StatefulWidget {
  const LandingHome({Key? key}) : super(key: key);

  @override
  State<LandingHome> createState() => _LandingHomeState();
}

class _LandingHomeState extends State<LandingHome> {
  String? saldopnjString;
  String? saldosimpString;
  String? cmember;

  PageController controller = PageController();
  HomeController homeController = Get.put(HomeController());
  DateTime newTime = DateTime.now();
  DateTime oldTime = DateTime.now();

  void getUsername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cmember = preferences.getString("cmember");
  }

  Future<String> fetchSaldo() async {
    Completer<String> completer = Completer<String>();
    try {
      Map<String, String> header = {'Content-Type': 'application/json'};
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? ccustcode = preferences.getString("cmember");
      Map<String, dynamic> post = {"ccustcode": "$ccustcode"};
      API.basePostGolang(ConstUrl.ceksaldo, post, header, true,
          (result, error) {
        if (error != null) {
          print('Error fetching saldo inifais: $error');
          completer.complete('0');
        }
        if (result != null) {
          setState(() {
            try {
              LandingpageModel response = LandingpageModel.fromJson(result);
              saldopnjString  = response.data![0].saldopinj!;
              saldosimpString = response.data![0].saldosimp!;
            } catch (e) {
              print('$e');
            }
          });
          // print('inipaisxxx: $saldo');
          completer.complete(saldopnjString);
        }
      });
    } catch (error) {
      print('Error fetching saldo : $error');
      completer.complete('0');
    }
    return completer.future;
  }

  @override
  void initState() {
    super.initState();
    getUsername();
    fetchSaldo().then((value) {
      setState(() {
        // String jsonString      = value.replaceAll(RegExp('[^0-9.]'), '');
        // double saldoValue      = double.tryParse(jsonString) ?? 0.0;
        // NumberFormat formatter = NumberFormat('#,###');
        // saldopnj               = saldopnj;
        // print('inipais1 fetching saldo inipais: $value');
        // saldosimp              = saldosimp;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double saldopnj   = saldopnjString  != null ? double.tryParse(saldopnjString!) ?? 0.0 : 0.0;
    double saldosimp  = saldosimpString != null ? double.tryParse(saldosimpString!) ?? 0.0: 0.0;
    return Scaffold(
      body: WillPopScope(
        onWillPop: onBackPress,
        child: Container(
          child: PageView(
            controller: controller,
            // physics: BouncingScrollPhysics(),
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              LandingScreen(
                  saldopinjaman: saldopnj.toString(),
                  saldosimpanan: saldosimp.toString()),
              ProfileScreen(),
              // Text('BELUM ADA MENU'),
              ProfileScreen(),
            ],
            onPageChanged: (val) => homeController.changeLandingPage(val),
          ),
        ),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Beranda',
                backgroundColor: Colors.greenAccent,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_box_outlined),
                label: 'Profile',
                backgroundColor: Colors.greenAccent,
              ),
            ],
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey.shade400,
            showUnselectedLabels: false,
            currentIndex: homeController.posLandingPage.value,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.green,
            onTap: (val) {
              print("fais val $val");
              homeController.changeLandingPage(val);
              controller.animateToPage(val,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.bounceOut);
            },
            // onTap: _onItemTapped,
          )),
    );
  }

  // Future<bool> onBackPress() async {
  //   return await UtilsDialog.onBackPressConfirm(context);
  // }
  Future<bool> onBackPress() async {
    newTime = DateTime.now();
    int difference = newTime.difference(oldTime).inMilliseconds;
    oldTime = newTime;
    if (difference < 2000) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      SystemNavigator.pop();
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Tap 2 kali untuk keluar',
              style:
              TextConstant.regular.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 15,
            )
          )
        )
      );
      return false;
    }
  }
}
