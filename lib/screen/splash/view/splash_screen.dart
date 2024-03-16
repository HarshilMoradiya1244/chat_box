import 'dart:async';
import 'package:chat_box/utils/firebase/firebase_authanticasion.dart';
import 'package:chat_box/utils/theme/share_helper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // bool? status;
  // void create() async {
  //   ShareHelper shr = ShareHelper();
  //   status = await shr.getIntroStatus();
  // }
  @override
  void initState() {
    super.initState();
    // create();
    bool isLogin = FireAuthHelper.fireAuthHelper.checkUser();
    Timer(
      const Duration(seconds: 3),
          () {

            Get.offAllNamed(isLogin == false ? 'signin' : 'dash');
            // Get.offAllNamed(
            //     status == false || status == null ? 'intro' : 'dash');
          }
            );

  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue.shade50,
        body: Center(
          child: LottieBuilder.asset("assets/json/splash.json",
          height: 200,width: 200,),
        )
      ),
    );
  }
}
