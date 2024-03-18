import 'package:chat_box/utils/shared_helper.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {

  RxBool isLight = true.obs;

  void changeThem() async {
    ShareHelper shr = ShareHelper();
    bool? isTheme = await shr.getTheme();
    isLight.value = isTheme ?? false;
  }
}