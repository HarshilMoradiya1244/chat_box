import 'package:chat_box/utils/colors.dart';
import 'package:chat_box/utils/firebase/firebase_authanticasion.dart';
import 'package:chat_box/utils/firebase/firebasedb_helper.dart';
import 'package:chat_box/utils/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: mainColor,
          centerTitle: true,
          title: const Text(
            "Settings",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            StreamBuilder(
              stream: FireDbHelper.fireDbHelper.getProfileData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  DocumentSnapshot ds = snapshot.data!;
                  Map m1 = ds.data() as Map;
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * 0.12,
                      width: MediaQuery.sizeOf(context).height,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            m1['image'] == null
                                ? CircleAvatar(
                                    radius: 35,
                                    child: Text("${m1['name']}"
                                        .toUpperCase()
                                        .substring(0, 1)),
                                  )
                                : CircleAvatar(
                                    radius: 35,
                                    backgroundImage:
                                        NetworkImage("${m1['image']}"),
                                  ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${m1['name']}",
                                  style: txtContact,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${m1['mobile']}",
                                  style: txtSmall,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            const Divider(),
            ListTile(
              onTap: (){
                {
                  Get.toNamed("profile");
                }
              },
              leading:const Icon(Icons.person),
              title: const Text("Profile Update"),
            ),
            const Divider(),
            ListTile(
              onTap: ()async {
                await FireAuthHelper.fireAuthHelper.signOut();
                Get.offAllNamed('signin');
              },
              leading:  const Icon(Icons.logout
              ),
              title: const Text("LogOut"),
            ),
            const Divider(),
            ListTile(
              onTap: () async {
                await FireAuthHelper.fireAuthHelper.deleteUser();
                Get.offAllNamed("signin");
              },
              leading: const Icon(Icons.account_circle_outlined
              ),
              title: const Text("Delete Account"),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
