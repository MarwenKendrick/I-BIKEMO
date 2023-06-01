import 'package:firebase_auth/firebase_auth.dart';
import 'package:ibikemo/consts/colors.dart';
import 'package:ibikemo/consts/consts.dart';
import 'package:ibikemo/views/home_screen/home.dart';
import 'package:ibikemo/wigets_common/applogo_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      // Get.to(() => const LoginScreen());
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => const LoginScreen());
        } else {
          Get.to(() => const Home());
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueBg,
      body: Center(
        child: Column(children: [
          Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                icSplashBg,
                width: 250,
              )),
          20.heightBox,
          applogoWidgets(),
          10.heightBox,
          appdialog.text.fontFamily(bold).size(22).white.make(),
          5.heightBox,
          appversion.text.white.make(),
          Spacer(),
          credits.text.white.fontFamily(semibold).make(),
          30.heightBox,
        ]),
      ),
    );
  }
}
