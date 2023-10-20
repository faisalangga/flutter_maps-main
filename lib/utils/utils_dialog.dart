import 'package:flutter/material.dart';

class UtilsDialog{
  static Future<bool> onBackPressConfirm(BuildContext context) async {
    bool confirmExit = await showDialog(
        context: context,
        builder: (context)=>
            AlertDialog(
              title: Text('Konfirmasi',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              content: Text('Apakah Anda yakin ingin menutup halaman ini?',
                  style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Tutup dialog
                  },
                  child: Text('Ya',
                      style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // Tutup dialog
                  },
                  child: Text('Tidak',
                      style: TextStyle(
                      fontSize: 15,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            )
    );
    return confirmExit;
  }
}

// getPrefs() async {
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   var islogin = preferences.getBool("islogin");
//   print("fais islogin1111:  $islogin");
//   var logout = widget.logout as bool;
//   print('fais $logout');
//   if (logout = true) {
//     final pref = await SharedPreferences.getInstance();
//     pref.clear();
//     Navigator.pushAndRemoveUntil(context,
//       new MaterialPageRoute(builder: (context) => new LandingHome()),
//           (Route<dynamic> route) => false,
//     );
//   } else {
//     if (islogin == true) {
//       LandingHome();
//       // final pref= await SharedPreferences.getInstance();
//       // pref.clear();
//       // Navigator.push(context,
//       //     new MaterialPageRoute(builder: (context) => new LandingHome()));
//       print("fais xxxxxzzzzzxxxxx");
//     } else {
//       // final pref = await SharedPreferences.getInstance();
//       // pref.clear();
//       LoginScreen(logout: 'logout');
//       print("fais zzzzz");
//     }
//   }
// }

class UtilsDialogApp{
  static Future<bool> onBackPressConfirm(BuildContext context) async {
    bool confirmExit = await showDialog(
        context: context,
        builder: (context)=>
            AlertDialog(
              title: Text(
                'Konfirmasi',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              content: Text(
                'Anda ingin menutup Aplikasi ini ?',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
                    Navigator.of(context).pop(true);
                    print('fais in');
                  },
                  child: Text(
                    'Ya',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'Tidak',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
    );
    return confirmExit;
  }
}
