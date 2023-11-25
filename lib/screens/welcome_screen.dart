import 'package:flash_chat_new/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../components/rounded_button.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;

  static const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  static const colorizeTextStyle = TextStyle(
    fontSize: 50.0,
    fontFamily: 'Horizon',
    fontWeight: FontWeight.bold,
  );


  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(
          vsync: this,
          duration: Duration(seconds: 1),

        );

    // animation = CurvedAnimation(parent: controller!, curve: Curves.easeIn);
    controller?.forward();

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white).animate(
        controller!);
    controller?.addListener(() {
      setState(() {});
      print(animation?.value);
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation!.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Center(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                        child: Image.asset('images/logo.png'),
                        height: 60
                    ),
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'Flash Chat',
                      textStyle: colorizeTextStyle,
                      colors: colorizeColors,
                    ),
                  ],
                  repeatForever: true,
                  // pause: Duration(seconds: 3),
                  //  animatedTexts: [

                  onTap: () {
                    print("Tap Event");
                  },
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(color: Colors.lightBlue, text: Text('Log In'), onPressed: (){
              Navigator.pushNamed(context, LoginScreen.id);
            }),
            RoundedButton(color: Colors.blueAccent, text: Text('Register'), onPressed: (){
              Navigator.pushNamed(context, RegistrationScreen.id);
            }),



          ],
        )
        ,
      )
      ,
    );
  }
}
