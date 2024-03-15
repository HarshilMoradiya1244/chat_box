import 'package:get/get.dart';

class ProfileController extends GetxController {

  String? path;

  void updateImagePath(String? newPath) {
    path = newPath;
  }
}