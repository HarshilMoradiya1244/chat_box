import 'package:chat_box/screen/contact/view/contact_screen.dart';
import 'package:chat_box/screen/home/view/home_screen.dart';
import 'package:chat_box/screen/profile/view/profile_screen.dart';
import 'package:chat_box/utils/colors.dart';
import 'package:chat_box/utils/firebase/firebase_authanticasion.dart';
import 'package:chat_box/utils/text_style.dart';
import 'package:chat_box/utils/theme/share_helper.dart';
import 'package:chat_box/utils/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  ThemeController controller = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title:  Align(alignment:Alignment.topLeft,child: Text("Chat Box",style: txtLarge,)),
          actions: [
            PopupMenuButton(
              color: mainColor,
              icon: const Icon(Icons.more_vert_outlined,color: Colors.white,),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    onTap: ()
                       {
                        Get.toNamed('setting');
                    },
                    child:Row(
                      children: [
                        IconButton(onPressed: (){}, icon: const Icon(Icons.settings,color: Colors.white,)),
                         Text("Settings",style: txtMedium,),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Obx(() =>
                            Switch(value: controller.isLight.value, onChanged: (value) {
                              ShareHelper shr =ShareHelper();
                              shr.setTheme(value);
                              controller.changeThem();
                            },),
                        ),
                         Text("ChangeTheme",style: txtMedium,),
                      ],
                    ),
                  ),
                ];
              },
            )
          ],
          bottom:  TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(child: Text("Chat",style: txtMedium,),),
              Tab(child:Text("Users",style: txtMedium,),),
              Tab(child:Text("Profile",style: txtMedium,),),
            ],
          ),
        ),
        body:  TabBarView(
          children:screen,
        ),
      ),
      );
  }
}
