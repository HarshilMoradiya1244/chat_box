import 'package:chat_box/utils/theme/share_helper.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: IntroductionScreen(
          pages: [
            PageViewModel(
                title: "Easily Chatting ",
                body:
                "A live chat greeting message is a message that is automatically sent to a customer or website visitor when they initiate a live chat session",
                image: Image.asset(
                  "assets/images/intro1.png",height: MediaQuery.sizeOf(context).height*0.2,
                )),
            PageViewModel(
                title: "Best Live Chat Welcome",
                body:
                "A live chat greeting message can greatly enhance a business’s ability to connect and engage with customers.\n We’ll take you through the benefits.",
                image: Image.asset(
                  "assets/images/intro2.png",height: MediaQuery.sizeOf(context).height*0.2,
                )),
            PageViewModel(
                title: "Title of custom button page",
                body:
                "This is a description on a page with a custom button below.",
                image: Image.asset(
                  "assets/images/intro3.png",height: MediaQuery.sizeOf(context).height*0.25,
                )),
          ],
          showDoneButton: true,
          onDone: () {
            ShareHelper shr = ShareHelper();
            shr.setIntroStatus();
            Navigator.pushReplacementNamed(context, 'dash');
          },
          done: Text("Done"),
          showNextButton: true,
          next: Text("Next"),
        ),
      ),
    );
  }
}

