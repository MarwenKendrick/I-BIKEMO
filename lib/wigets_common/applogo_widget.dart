import 'package:ibikemo/consts/consts.dart';

Widget applogoWidgets() {
  return Image.asset(icAppLogo)
      .box
      .transparent
      .size(77, 77)
      .padding(const EdgeInsets.all(10))
      .rounded
      .make();
}
