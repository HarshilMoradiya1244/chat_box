import 'package:chat_box/screen/contact/view/contact_screen.dart';
import 'package:chat_box/screen/home/view/home_screen.dart';
import 'package:chat_box/screen/profile/view/profile_screen.dart';
import 'package:chat_box/utils/colors.dart';
import 'package:chat_box/utils/text_style.dart';
import 'package:flutter/material.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({super.key});

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  List<Widget> screen =[
   const HomeScreen(),
   const ContactScreen(),
   const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          bottom:  TabBar(
            tabs: [
              Tab(child: Text("Chat",style: txtSmall,),),
              Tab(child:Text("Users",style: txtSmall,),),
              Tab(child:Text("Profile",style: txtSmall,),),
            ],
          ),
          title:  Text("Chat Box",style: txtMedium,),
        ),
        body:  TabBarView(
          children:screen,
        ),
      ),
      );
  }
}
