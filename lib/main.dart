import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:koperasimobile/screen/auth/isitabungan/isi_nominal_sendiri_screen.dart';
import 'package:koperasimobile/screen/auth/isitabungan/isi_tabungan_ins_screen.dart';
import 'package:koperasimobile/splash_screen.dart';

import 'screen/auth/isitabungan/konfirmasi_isi_tabungan_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return GetMaterialApp(
      title: 'K-SPS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: Theme.of(context)
            .colorScheme
            .copyWith(secondary: Colors.grey.shade500),
      ),
      home: SplashView(),
    );
  }
}
