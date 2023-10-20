import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/controller/pengajuan_simp_controller.dart';
import 'package:koperasimobile/screen/auth/pengajuan_simp/pengajuan_simp_ins_screen.dart';
import 'package:koperasimobile/screen/home/view/pengajuan_pinj_screen.dart';
//import 'package:koperasimobile/screen/home/view/pengajuan_simp_screen.dart';
//import 'package:koperasimobile/screen/home/view/supp_screen.dart';
//import 'package:koperasimobile/screen/auth/supp/supp_ins_screen.dart';
//import 'package:koperasimobile/controller/supp_controller.dart';

class AjuSimpHome extends StatefulWidget {
  const AjuSimpHome({Key? key}) : super(key: key);

  @override
  State<AjuSimpHome> createState() => _MainHomeState() ;
}

class _MainHomeState extends State<AjuSimpHome> {

  PageController controller = PageController();
  AjuSimpController ajusimpController = Get.put(AjuSimpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView(
          controller: controller,
          // physics: BouncingScrollPhysics(),
          physics: NeverScrollableScrollPhysics(),
          children: const <Widget>[
            // AjuSimpScreen(),
            PinjamanGridWidget(),
            AjuSimpInsScreen(tipeCheck: 'ini create'),
            //SuppEdtScreen(tipeCheck: 'ini edit'),
          ],
          onPageChanged: (val)=>ajusimpController.changePage(val),
        ),
      ),
      // bottomNavigationBar: Obx(()=>BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.youtube_searched_for_outlined),
      //       label: 'Lihat',
      //       backgroundColor: Colors.green,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.add_to_photos),
      //       label: 'Create',
      //       backgroundColor: Colors.green,
      //     ),
      //     // BottomNavigationBarItem(
      //     //   icon: Icon(Icons.work_off_outlined),
      //     //   label: 'Delete',
      //     //   backgroundColor: Colors.green,
      //     // ),
      //   ],
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.grey.shade400,
      //   showUnselectedLabels: true,
      //   currentIndex: ajusimpController.posPage.value,
      //   type: BottomNavigationBarType.fixed,
      //   backgroundColor: Colors.green,
      //   onTap: (val){
      //     ajusimpController.changePage(val);
      //     controller.animateToPage(val, duration: Duration(milliseconds: 200), curve: Curves.bounceOut);
      //   },
      //   // onTap: _onItemTapped,
      // )),
    );
  }
}
