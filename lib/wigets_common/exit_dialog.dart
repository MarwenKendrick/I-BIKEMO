import 'package:flutter/services.dart';
import 'package:ibikemo/consts/consts.dart';
import 'package:ibikemo/wigets_common/our_button.dart';

Widget exitDialog(context) {
  return Dialog(
      child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
      Divider(),
      10.heightBox,
      "Are you sure you want to exit?"
          .text
          .fontFamily(bold)
          .size(18)
          .color(darkFontGrey)
          .make(),
      10.heightBox,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ourButton(
              color: blueBg,
              onPress: () {
                SystemNavigator.pop();
              },
              textColor: whiteColor,
              title: "Yes"),
          ourButton(
              color: redColor,
              onPress: () {
                Navigator.pop(context);
              },
              textColor: whiteColor,
              title: "No"),
        ],
      )
    ],
  ).box.color(lightGrey).padding(const EdgeInsets.all(12)).rounded.make());
}
