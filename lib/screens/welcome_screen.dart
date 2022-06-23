import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      upperBound: 1,
    );
    animation = ColorTween(begin: kLogoBright, end: Color(0xFF0A0E21))
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
      // print(controller.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/flash_icon.png'),
                    height: 100,
                  ),
                ),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontFamily: 'Blogger_Sans',
                    fontSize: 58.0,
                    fontWeight: FontWeight.w700,
                    color: kLogoBright,
                    shadows: [
                      Shadow(
                        blurRadius: 7.0,
                        color: kLogoBright,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: AnimatedTextKit(
                    // stopPauseOnTap: true,
                    repeatForever: true,
                    isRepeatingAnimation: true,
                    // totalRepeatCount: 2,
                    animatedTexts: [
                      FlickerAnimatedText('FlashChat'),
                    ],
                    onTap: () {
                      // print("Tap Event");
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 60.0,
            ),
            RoundedButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              color: kLightBtn,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Log in  ',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.login),
                        ],
                      )),
                ],
              ),
            ),
            RoundedButton(
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              color: kLogoBright,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Register',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.app_registration_sharp),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
