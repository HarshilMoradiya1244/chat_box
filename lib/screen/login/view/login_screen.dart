import 'package:chat_box/screen/widget/custome_textfiled.dart';
import 'package:chat_box/utils/colors.dart';
import 'package:chat_box/utils/constant.dart';
import 'package:chat_box/utils/firebase/firebase_authanticasion.dart';
import 'package:chat_box/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    loginTitle,
                    style: txtMain,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    loginDec,
                    style: txtSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () async {
                            FireAuthHelper.fireAuthHelper.checkUser();
                            String msg = await FireAuthHelper.fireAuthHelper
                                .googleSignIn();
                            Get.snackbar(msg, "Login Success Fully");
                            if (msg == "success") {
                              Get.offAllNamed('profile');
                            }
                          },
                          child: socialContainer("assets/images/google.png")),
                      socialContainer("assets/images/apple.png"),
                      InkWell(
                        onTap: () async {
                          FireAuthHelper.fireAuthHelper.checkUser();
                          String msg = await FireAuthHelper.fireAuthHelper.guestLogin();
                          Get.snackbar(msg, "Login Success Fully");
                          if(msg == "success"){
                            Get.offAllNamed('profile');
                          }
                        },
                          child: socialContainer("assets/images/guest.png")),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      SizedBox(
                        width: 10,
                      ),
                      Text("OR"),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomeTextFiled(
                    label: email,labelColor: mainColor,
                    controller: txtEmail,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomeTextFiled(
                    label: password,labelColor: mainColor,
                    controller: txtPassword,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  InkWell(
                    onTap: () async {
                      String msg = await FireAuthHelper.fireAuthHelper.singIn(
                          email: txtEmail.text, password: txtPassword.text);
                      Get.snackbar(msg, "");
                      if (msg == "success") {
                        FireAuthHelper.fireAuthHelper.checkUser();
                        Get.offAllNamed('profile');
                      }
                    },
                    child: Container(
                      height: 48,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xffF3F6F6),
                      ),
                      child: Center(
                          child: Text(
                        loginButton,
                        style: txtMain
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    forgetPass,
                    style: txtSmall,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                      onTap: () {
                        Get.toNamed('signup');
                      },
                      child: Text(
                        createNewAccount,
                        style: txtMain,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container socialContainer(String path) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 48,
      width: 48,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Image.asset(
        path,
        height: 45,
        width: 45,
      ),
    );
  }
}
