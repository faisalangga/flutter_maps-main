
import 'package:koperasimobile/constant/image_constant.dart';

String getLogoBank(String bank) {
  if (bank == 'BCA Syariah') {
    return ImageConstant.bcasyariah;
  }else{
    return ImageConstant.loading;
  }
}


