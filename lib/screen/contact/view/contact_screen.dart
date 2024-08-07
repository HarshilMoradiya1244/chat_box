import 'package:chat_box/screen/profile/model/profile_model.dart';
import 'package:chat_box/utils/firebase/firebasedb_helper.dart';
import 'package:chat_box/utils/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder(
        stream: FireDbHelper.fireDbHelper.getAllContact(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData) {

            List<ProfileModel> contactData = [];
            QuerySnapshot? qs = snapshot.data;
            if(qs!=null){
              List<QueryDocumentSnapshot> qsList = qs.docs;

              for (var x in qsList) {
                Map m1 = x.data() as Map;
                print(m1);
                ProfileModel p1 = ProfileModel(
                  uid: x.id,
                  image: m1['image'],
                  name: m1['name'],
                  bio: m1['bio'],
                  email: m1['email'],
                  mobile: m1['mobile'],
                  address: m1['address'],
                );
                contactData.add(p1);
              }
            }

            return ListView.builder(
              itemCount: contactData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Get.toNamed('chat',arguments: contactData[index]);
                  },
                  leading: contactData[index].image != null
                      ? CircleAvatar(
                    radius: 30,
                    backgroundImage:
                    NetworkImage("${contactData[index].image}"),
                  )
                      : CircleAvatar(
                    radius: 30,
                    child: Text(
                      "${contactData[index].name != null && contactData[index].name!.isNotEmpty
                          ? contactData[index].name!.substring(0, 1)
                          : 'N'}",style: const TextStyle(fontSize: 20),),
                  ),
                  title: Text("${contactData[index].name}",),
                  subtitle: Text("${contactData[index].mobile}",style: txtSmall,),
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
