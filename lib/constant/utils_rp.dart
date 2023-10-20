import 'package:intl/intl.dart';

String rupiah(String amount) {
  final formatter = NumberFormat("#,###,##0");
  return 'Rp. ' + formatter.format(double.parse(amount));
}

String duet(String amount) {
  final formatter = NumberFormat("#,###,##0");
  return formatter.format(double.parse(amount));
}