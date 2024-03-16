import 'package:chat_box/utils/app_routes.dart';
import 'package:chat_box/utils/theme/app_theme.dart';
import 'package:chat_box/utils/theme/theme_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ThemeController controller = Get.put(ThemeController());
  runApp(
    Obx(() {
      controller.changeThem();
      return  GetMaterialApp(
        debugShowCheckedModeBanner: false,
        routes: app_routes,
        theme: controller.isLight.value?darkTheme:lightTheme,
      );
    },
    ),
  );
}
