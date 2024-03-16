import 'package:chat_box/screen/profile/model/profile_model.dart';
import 'package:chat_box/utils/firebase/firebase_authanticasion.dart';
import 'package:chat_box/utils/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/firebase/firebasedb_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Future<void> getProfile() async {
    await FireDbHelper.fireDbHelper.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FireDbHelper.fireDbHelper.chatContact(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData) {
            List<ProfileModel> contactChatList = [];
            QuerySnapshot? qs = snapshot.data;
            if (qs != null) {
              List<QueryDocumentSnapshot> qsList = qs.docs;
              for (var x in qsList) {
                List mainList = [];
                Map data = x.data() as Map;

                data.entries.forEach((e) {
                  mainList.add(e.value);
                });

                if (mainList[0]
                    .contains(FireAuthHelper.fireAuthHelper.user!.uid)) {
                  ProfileModel p1 = ProfileModel(
                    name: mainList[1][0],
                    uid: mainList[1][1],
                    image: mainList[1][2],
                    address: mainList[1][3],
                    bio: mainList[1][4],
                    email: mainList[1][5],
                    mobile: mainList[1][6],
                    docId: x.id,
                  );
                  contactChatList.add(p1);
                } else if (mainList[1]
                    .contains(FireAuthHelper.fireAuthHelper.user!.uid)) {
                  ProfileModel p1 = ProfileModel(
                    name: mainList[0][0],
                    uid: mainList[0][1],
                    image: mainList[0][2],
                    address: mainList[0][3],
                    bio: mainList[0][4],
                    email: mainList[0][5],
                    mobile: mainList[0][6],
                    docId: x.id,
                  );
                  contactChatList.add(p1);
                }
              }
            }
            return ListView.builder(
              itemCount: contactChatList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Get.toNamed('chat', arguments: contactChatList[index]);
                  },
                  leading: contactChatList[index].image == null
                      ? SizedBox(
                          width: 50,
                          child: CircleAvatar(
                            radius: 50,
                            child: Text("${contactChatList[index].name}"
                                .toUpperCase()
                                .substring(0, 1),style: const TextStyle(fontSize: 20),),
                          ),
                        )
                      : SizedBox(width: 50,
                        child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                NetworkImage("${contactChatList[index].image}"),
                          ),
                      ),
                  title: Text("${contactChatList[index].name}"),
                  subtitle: Text("${contactChatList[index].mobile}"),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
