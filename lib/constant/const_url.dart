class ConstUrl {
  //ip
  static String BASE_URL_GOLANG = 'http://192.168.100.244:5000/koperasi';
  static String BASE_URL= 'http://192.168.100.206/tokool';

  //module
  // API GOLANG
  static String login           = "/login";
  static String insertMember    = "/insertMember";
  static String provinzi        = "/place";
  static String kota            = "/place";
  static String kecamatan       = "/place";
  static String desa            = "/place";
  static String kodepost        = "/place";
  static String ceksaldo        = "/ceksaldo";
  static String cekaccount      = "/cekaccount";
  static String compcode        = "/cekcomp";
  static String cabang          = "/cekcabang";
  static String nik             = "/get-nik";
  static String tenor           = "/cektenor";
  static String jaminan         = "/cekjaminan";
  static String rekening        = "/cekrekening";
  static String insertPinjaman  = "/insertPinjaman";
  static String viewpinjaman    = "/cekviewpinjaman";
  static String editpinjaman    = "/cekviewpinjamandocno";
  static String Inserttabungan  = "/insertTabungan";
  static String cekdatabank     = "/cekdatabank";
  static String insertTTunai    = "/insertTarikTunai";
  static String BASE_URL_VIEW_PINJAMAN = "http://192.168.100.244:5000/koperasi/cekviewpinjaman";

  // ----------------//----------------------//

  // static String compcode     = "/company.php";
  // static String cabang       = "/cabang.php";
  // static String login        = "/login.php";
  // static String ceksaldo     = "/cek_saldo.php";
  // static String cekaccount   = "/cek_account.php";
  // static String insMemberphp = "/member_ins.php";
  // static String provinzi     = "/cari_prov.php";
  // static String kota         = "/cari_kota.php";
  // static String kecamatan    = "/cari_kec.php";
  // static String desa         = "/cari_desa.php";
  // static String kodepost     = "/cari_kdpost.php";
  static String insertUser      = "/register.php";
  static String User            = "/cari_user.php";
  static String Akses           = "/cari_akses.php";
  static String Updtusr         = "/upd_user.php";
  static String tampMember      = "/member.php";
  static String simp_awal       = "/simpanan.php";
  static String viewsimp        = "/cek_simp_view.php";
}