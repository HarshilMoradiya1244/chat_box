import 'dart:io';
import 'package:chat_box/screen/profile/controller/profile_controller.dart';
import 'package:chat_box/screen/profile/model/profile_model.dart';
import 'package:chat_box/utils/firebase/firebasedb_helper.dart';
import 'package:chat_box/screen/widget/custome_textfiled.dart';
import 'package:chat_box/utils/firebase/firebase_authanticasion.dart';
import 'package:chat_box/utils/services/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtBio = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtImage = TextEditingController();
  String? image;
  ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: FireDbHelper.fireDbHelper.getProfileData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              DocumentSnapshot? ds = snapshot.data;
              Map? data = ds?.data() as Map?;
              if (data != null) {
                txtName.text = data['name'];
                txtEmail.text = data['email'];
                txtMobile.text = data['mobile'];
                image = data['image'];
                txtAddress.text = data['address'];
                txtBio.text = data['bio'];
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(
                            () =>
                        controller.imagePath.value == null && image == null
                            ? const CircleAvatar(
                          radius: 50,
                        )
                            : controller.imagePath.value != null
                            ? CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(
                              File(controller.imagePath.value!)),
                        )
                            : CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(image!),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            ImagePicker picker = ImagePicker();
                            XFile? file = await picker.pickImage(
                                source: ImageSource.gallery);
                            controller.imagePath.value = file?.path;
                          },
                          child: const Text("Image")),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomeTextFiled(
                        label: "Name",
                        controller: txtName,
                      ),
                      CustomeTextFiled(
                        label: "Mobile",
                        controller: txtMobile,
                      ),
                      CustomeTextFiled(
                        label: "Bio",
                        controller: txtBio,
                      ),
                      CustomeTextFiled(
                        label: "Email",
                        controller: txtEmail,
                      ),
                      CustomeTextFiled(
                        label: "Address",
                        controller: txtAddress,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          String? path;
                          if(controller.imagePath.value!=null)
                          {
                            path = await FireStorage.fireStorage.uploadProfile(controller.imagePath.value!);
                          }
                          ProfileModel p1 = ProfileModel(
                              uid: FireAuthHelper.fireAuthHelper.user!.uid,
                              name: txtName.text,
                              mobile: txtMobile.text,
                              bio: txtBio.text,
                              email: txtEmail.text,
                              address: txtAddress.text,
                              image: controller.imagePath.value!=null?path:image,);
                          FireDbHelper.fireDbHelper.addProfileData(p1);
                          Get.offAllNamed('dash');
                          controller.imagePath.value = null;
                        },
                        child: const Text("Save"),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
