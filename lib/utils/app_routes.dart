import 'package:chat_box/screen/chat/view/chat_screen.dart';
import 'package:chat_box/screen/contact/view/contact_screen.dart';
import 'package:chat_box/screen/dash/view/dash_screen.dart';
import 'package:chat_box/screen/home/view/home_screen.dart';
import 'package:chat_box/screen/login/view/login_screen.dart';
import 'package:chat_box/screen/login/view/signup_screen.dart';
import 'package:chat_box/screen/profile/view/profile_screen.dart';
import 'package:chat_box/screen/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';

Map<String,WidgetBuilder> app_routes = {
  '/':(context) => const SplashScreen(),
  'dash':(context) => const DashScreen(),
  'signin':(context) => const SignInScreen(),
  'signup':(context) => const SignUpScreen(),
  'home':(context) => const HomeScreen(),
  'chat':(context) => const ChatScreen(),
  'contact':(context) => const ContactScreen(),
  'profile':(context) => const ProfileScreen(),
};